using Catalogservice as service from '../../srv/service';
annotate service.purchaseorder with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'CURRENCY_CODE',
                Value : CURRENCY_CODE,
            },
            {
                $Type : 'UI.DataField',
                Label : 'GROSS_AMOUNT',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Label : 'NET_AMOUNT',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Label : 'TAX_AMOUNT',
                Value : TAX_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Label : 'NODE_KEY',
                Value : NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Label : 'PO_ID',
                Value : PO_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'PARTNER_GUID_NODE_KEY',
                Value : PARTNER_GUID_NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Label : 'LIFECYCLE_STATUS',
                Value : LIFECYCLE_STATUS,
            },
            {
                $Type : 'UI.DataField',
                Label : 'OVERALL_STATUS',
                Value : OVERALL_STATUS,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'NODE_KEY',
            Value : NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Label : 'CURRENCY_CODE',
            Value : CURRENCY_CODE,
        },
        {
            $Type : 'UI.DataField',
            Label : 'GROSS_AMOUNT',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Label : 'NET_AMOUNT',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Label : 'TAX_AMOUNT',
            Value : TAX_AMOUNT,
        },
    ],
);

annotate service.purchaseorder with {
    PARTNER_GUID @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'businesspartner',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : PARTNER_GUID_NODE_KEY,
                ValueListProperty : 'NODE_KEY',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'BP_ROLE',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'EMAIL_ADDRESS',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'PHONE_NUMBER',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'FAX_NUMBER',
            },
        ],
    }
};

