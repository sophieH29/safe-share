pragma solidity ^0.4.20;

contract WorkbenchBase {
    event WorkbenchContractCreated(string applicationName, string workflowName, address originatingAddress);
    event WorkbenchContractUpdated(string applicationName, string workflowName, string action, address originatingAddress);

    string internal ApplicationName;
    string internal WorkflowName;

    function WorkbenchBase(string applicationName, string workflowName) internal {
        ApplicationName = applicationName;
        WorkflowName = workflowName;
    }

    function ContractCreated() internal {
        WorkbenchContractCreated(ApplicationName, WorkflowName, msg.sender);
    }

    function ContractUpdated(string action) internal {
        WorkbenchContractUpdated(ApplicationName, WorkflowName, action, msg.sender);
    }
}

contract SafeShare3 is WorkbenchBase('SafeShare3', 'SafeShare3')
{
    enum StateType { 
      Offered,
      Requested,
      Accepted
    }

    address public InstanceOwner;
    string public Name;
    int public AskingPrice;
    StateType public State;

    address public InstanceBorrower;

    function SafeShare3(string name) public
    {
        InstanceOwner = msg.sender;
        Name = name;
        State = StateType.Offered;
        ContractCreated();
    }

    function OfferAsset() public 
    {
        if ( msg.sender != InstanceBorrower )
        {
            revert();
        }

        InstanceBorrower = 0x0;
        State = StateType.Offered;
        ContractUpdated('Offered');
    }

    function Request() public
    {

        if (State != StateType.Offered)
        {
            revert();
        }
        
        if (InstanceOwner == msg.sender)
        {
            revert();
        }

        InstanceBorrower = msg.sender;
        State = StateType.Requested;
        ContractUpdated('Request');
    }

    function Reject() public
    {
        if ( State != StateType.Requested )
        {
            revert();
        }

        if (InstanceOwner != msg.sender)
        {
            revert();
        }

        InstanceBorrower = 0x0;
        State = StateType.Offered;
        ContractUpdated('Reject');
    }

    function AcceptOffer() public
    {
        if ( msg.sender != InstanceOwner )
        {
            revert();
        }

        State = StateType.Accepted;
        ContractUpdated('AcceptOffer');
    }
}