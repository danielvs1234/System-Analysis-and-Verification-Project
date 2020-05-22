//This file was generated from (Academic) UPPAAL 4.1.24 (rev. 29A3ECA4E5FB0808), November 2019

/*

*/
E<> Int.Shopping imply CashP.PaymentSucceded

/*

*/
A<> Int.Shopping imply Int.Payed

/*
There should be no deadlocks in the system
*/
A[] not deadlock

/*
When an item is scanned you should be able to pay in cash 

*/
E<> ((HS.ItemIsScanned || AS.ItemIsScanned) imply Con.CashPayment) imply Con.PaymentIsAccepted

/*
When an item is scanned you should be able to pay with card
*/
E<> ((HS.ItemIsScanned || AS.ItemIsScanned) imply Con.CardPayment) imply Con.PaymentIsAccepted

/*
When an item is scanned you should be able to pay with coupons
*/
E<> ((HS.ItemIsScanned || AS.ItemIsScanned) imply Con.CouponPayment) imply Con.PaymentIsAccepted

/*
You should be able to scan two items after one another

*/
E<> (Int.ScannedItem imply Int.ScannedItem)

/*
You should not be able to scan an item if you are paying
*/
E<> Con.PaymentChosen and not (HS.ItemIsScanned || AS.ItemIsScanned)\


/*
If you have overpaid you should get payment back and a receipt
*/
E<> Con.BackPayment imply (RP.ReceiptPrinted and BackP.Succes)

/*
If weight is not OK you should not be able to pay

*/
E<> Con.PaymentChosen imply (ErrStat == 0 && W.Error)

/*
If unrecognized weight the error lamp should be on
*/
A<> W.Error imply EL.Red

/*

*/
A<> Con.PaymentError imply EL.Red

/*
If Error lamp is on the interactive screen should be reset 
*/
A<> EL.Red imply EL.Green

/*
It should not be possible to scan a new item if the weight returns an error

*/
A<> ((Con.ItemIsScanned imply W.Error) imply not Con.ItemIsScanned)

/*
While a card payment is happening, another payment of cash\/coupon is not possible
*/
A<> Con.CardPayment imply (not Con.CashPayment and not Con.CouponPayment)

/*
If an error occurs, the shopper should not be able to continue before a reset has happened
*/
A<> ErrStat > 0 imply (EL.Red and (HS.Idle and AS.Idle))

/*
If scanning an age restricted item the age error should be present and in need of a reset
*/
A<> (Con.AgeVerification imply EL.Red) imply EL.Green

/*

*/
//NO_QUERY

/*

*/
CardP.CardInserted and CardP.CardPayTimer > 10000 --> CardP.PaymentFailed

/*

*/
//NO_QUERY

/*

*/
//NO_QUERY

/*

*/
//NO_QUERY

/*

*/
//NO_QUERY

/*

*/
//NO_QUERY
