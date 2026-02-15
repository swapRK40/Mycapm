namespace india.customAspect;


type AmountType : Decimal(15,2);

aspect Amount {
    CURRENCY_CODE : String(40);
    GROSS_AMOUNT  : AmountType;   //Decimal(15,2)
    NET_AMOUNT : AmountType ;     // Decimal(15,2)
    TAX_AMOUNT : AmountType       //Decimal(15,2)


}


// assert.format is used for validation. Checiking phoneNumber and email patterns.

type phoneNumber : String(30)@assert.format : '([+])?((\d)[.-]?)?[\s]?\(?(\d{3})\)?[.-]?[\s]?(\d{3})[.-]?[\s]?(\d{4,})';
type Email: String(255) @assert.format : '^[a-zA-Z0-9_.±]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$';