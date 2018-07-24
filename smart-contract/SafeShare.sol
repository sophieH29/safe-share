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

contract SafeShare is WorkbenchBase('SafeShare', 'SafeShare')
{
    enum StateType { 
      ItemAvailable,
      OfferPlaced,
      Accepted
    }

    address public InstanceOwner;
    string public Name;
    int public AskingPrice;
    StateType public State;

    address public InstanceBorrower;

    function SafeShare(string name) public
    {
        InstanceOwner = msg.sender;
        Name = name;
        State = StateType.ItemAvailable;
        ContractCreated();
    }

    function MakeOffer() public
    {

        if (State != StateType.ItemAvailable)
        {
            revert();
        }
        
        if (InstanceOwner == msg.sender)
        {
            revert();
        }

        InstanceBorrower = msg.sender;
        State = StateType.OfferPlaced;
        ContractUpdated('MakeOffer');
    }

    function Reject() public
    {
        if ( State != StateType.OfferPlaced )
        {
            revert();
        }

        if (InstanceOwner != msg.sender)
        {
            revert();
        }

        InstanceBorrower = 0x0;
        State = StateType.ItemAvailable;
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