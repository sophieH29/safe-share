Safe Share Application built with smart contracts
====================================================================

Overview 
---------

The asset transfer smart contract covers the scenario for lending and borrowing assets, beetween group of people.

The Safe Share application expresses a workflow for a simple transaction
between an owner and a borrower.

Application Roles 
------------------
| Name                   | Description                                       |
|------------------------|---------------------------------------------------|
|Owner |A person who wants to lend an asset. |
|Borrower|A person who wants to borrow an asset. |

States 
-------

| Name                   | Description                                       |
|------------------------|---------------------------------------------------|
|ItemAvailable |Indicates that an owner has made the item they want to lend available. 
|Accepted |Indicates that the owner has accepted the borrower's offer for the item. 

Workflow Details
----------------
An instance of the Simple Marketplace application's workflow starts in the
ItemAvailable state when an Owner makes an item available for sale by specifying
its description and price.  A buyer can then make an offer by specifying their
price for the item.  This action causes the state to change from ItemAvailable
to OfferPlaced.  Now, if the owner agrees to the buyer's offer, then owner calls
the function to accept an offer, and the workflow reaches a successful
conclusion state denoted by the Accepted state.  If the owner, however, is not
satisfied with the offer, then the owner can call the function to reject the
offer.  On rejection, the state changes to ItemAvailable indicating that the
item is still up for sale.  The transitions between the ItemAvailable and the
OfferPlaced states can continue until the owner is satisfied with the offer
made. 

A happy path shown in the transition diagram traces an owner making an item
available, a buyer making an offer, and the owner accepting the offer. 
