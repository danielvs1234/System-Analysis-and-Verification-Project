//This file was generated from (Academic) UPPAAL 4.1.24 (rev. 29A3ECA4E5FB0808), November 2019

/*
The user should be able to start shopping, and eventually pay with cash
*/
E<> Int.Shopping imply CashP.PaymentSucceded

/*
It should be able to start shopping, and complete the flow by paying
*/
A<> Int.Shopping imply Int.Payed

/*
There should be no deadlocks in the system
*/
A[] not deadlock

/*
You should not be able to scan an item if you are paying
*/
E<> Con.PaymentChosen && !HS.ItemIsScanned && !AS.ItemIsScanned\


/*
If weight is not OK you should not be able to pay

*/
E<> Con.PaymentChosen imply (ErrStat == 0 && W.Error)

/*
If Error lamp is on the interactive screen should be reset 
*/
A<> EL.Red imply EL.Green

/*

*/
//NO_QUERY

/*
1. When an item is scanned you should be able to pay in cash 

*/
E<> ((HS.ItemIsScanned || AS.ItemIsScanned) imply Con.CashPayment) imply Con.PaymentIsAccepted

/*
1. When an item is scanned you should be able to pay with card
*/
E<> ((HS.ItemIsScanned || AS.ItemIsScanned) imply Con.CardPayment) imply Con.PaymentIsAccepted

/*
1. When an item is scanned you should be able to pay with coupons
*/
E<> ((HS.ItemIsScanned || AS.ItemIsScanned) imply Con.CouponPayment) imply Con.PaymentIsAccepted

/*
2. You should be able to scan two items after one another
*/
E<> Int.ScannedItem imply Int.Shopping imply Int.ScannedItem

/*
3. If you have overpaid you should get payment back and a receipt
*/
E<> Con.BackPayment imply (RP.ReceiptPrinted and BackP.Succes)

/*
4. If unrecognized weight the error lamp should be on
*/
A<> W.Error imply EL.Red

/*
5. If the weight detects abnormalities between expected and actual weight it should be poossible for the customer to perform any actions before reset by an employee
*/
A<> Con.PaymentError imply EL.Red

/*
5. It should not be possible to scan a new item if the weight returns an error
*/
A<> ((Con.ItemIsScanned imply W.Error) imply not Con.ItemIsScanned)

/*
5. If an error occurs, the shopper should not be able to continue before a reset has happened
*/
A<> ErrStat > 0 imply (EL.Red and (HS.Idle and AS.Idle))

/*
6. If scanning an age restricted item the age error should be present and in need of a reset
*/
A<> (Con.AgeVerification imply EL.Red) imply EL.Green

/*
8. You  should  be  able  to  scan  items  with  either  a  stationary  (auto)  scanner  or  amanual hand-scanner.
*/
A<> Con.Shopping imply HS.ItemIsScanned

/*
8. You  should  be  able  to  scan  items  with  either  a  stationary  (auto)  scanner  or  amanual hand-scanner.
*/
A<> Con.Shopping imply AS.ItemIsScanned

/*

*/
//NO_QUERY

/*
2. If  card  has  not  been  accepted  or  declined  within  10  seconds  from  beinginserted give the customer a notice something went wrong and should try again.
*/
A[] (CardP.PaymentTimeout imply CardP.CardPayTimer >= 10000)

/*
2. If  card  has  not  been  accepted  or  declined  within  10  seconds  from  beinginserted give the customer a notice something went wrong and should try again.
*/
A<> CardP.PaymentCancelled imply CardP.CardPayTimer < 10000

/*
2. If  card  has  not  been  accepted  or  declined  within  10  seconds  from  beinginserted give the customer a notice something went wrong and should try again.
*/
A<> CardP.PinCodeAccepted imply CardP.CardPayTimer < 10000

/*
1. If no actions are performed by the customer within 30 seconds after initiatingthe shopping by scanning an item. The self-service register should ask thecustomer if they want to continue while also turn on the error lamp.
*/
A<> (Con.IdleTimeout && Con.LastActionTimer >= 30000) imply EL.Red

/*
2. If card is inserted and the PayTimer is above or equal to 10000 the transaction should be failed
*/
A<> (CardP.CardInserted and CardP.CardPayTimer >= 10000) imply CardP.PaymentFailed

/*
3. If an item is scanned but not placed on the weight within 5 seconds the self-service register should notify the customer to place the item on the weight while also turn on the error lamp.
*/
A<> (Con.ItemIsScanned && Con.ItemPlacedTimer >= 5000) imply EL.Red

/*
4. The error lamp should be turned on within 1 second of detecting an error
*/
A<> (ErrStat > 0 && ErrorResponseTimer < 1000)imply EL.Red

/*
5 After paying the self-service register should be ready for the new customer within 10 seconds
*/
E[] (Con.PaymentCompleted && Con.PaymentCompletedTimer <= 10000) imply Con.Idle

/*
6 The customer should be able to start payment at latest 1 second after last item successfully scanned
*/
A<> Con.Shopping imply Con.PaymentChosen && Con.TimeSinceLastAction < 1000
