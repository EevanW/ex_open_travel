defmodule ExOpenTravel.Composers.OtaRead.Mapping do
  @behaviour ExOpenTravel.Response.Converter
  alias ExOpenTravel.Response.Converter
  import SweetXml

  @taxes_type [
    ~x"./*[local-name() = 'Taxes']/*[local-name() = 'Tax']"ol,
    "@Code": ~x"./@Code"os,
    "@Percentage": ~x"./@Percentage"os,
    "@Amount": ~x"./@Amount"os,
    TaxDescription: [
      ~x"./*[local-name() = 'TaxDescription']"o,
      Text: ~x"./*[local-name() = 'Text']/text()"os
    ]
  ]

  @total_type [
    ~x"./*[local-name() = 'Total']"o,
    "@CurrencyCode": ~x"./@CurrencyCode"os,
    "@AmountAfterTax": ~x"./@AmountAfterTax"os,
    "@AmountBeforeTax": ~x"./@AmountBeforeTax"os,
    Taxes: @taxes_type
  ]

  @services_type [
    ~x"./*[local-name() = 'Services']/*[local-name() = 'Service']"ol,
    "@ServiceInventoryCode": ~x"./@ServiceInventoryCode"os,
    "@ServiceRPH": ~x"./@ServiceRPH"os,
    "@Inclusive": ~x"./@Inclusive"os,
    "@Quantity": ~x"./@Quantity"os,
    "@ID": ~x"./@ID"os,
    "@ID_Context": ~x"./@ID_Context"os,
    "@Type": ~x"./@Type"os,
    Price: [
      ~x"./*[local-name() = 'Price']"o,
      Total: @total_type,
      RateDescription: [
        ~x"./*[local-name() = 'DetailDescription']"o,
        Text: ~x"./*[local-name() = 'Text']/text()"os
      ]
    ],
    ServiceDetails: [
      ~x"./*[local-name() = 'ServiceDetails']"o,
      TimeSpan: [
        ~x"./*[local-name() = 'TimeSpan']"o,
        "@Start": ~x"./@Start"os,
        "@End": ~x"./@End"os
      ]
    ]
  ]

  @profiles_type [
    ~x"./*[local-name() = 'Profiles']"ol,
    ProfileInfo: [
      ~x"./*[local-name() = 'ProfileInfo']"o,
      UniqueID: [
        ~x"./*[local-name() = 'UniqueID']"ol,
        "@Type": ~x"./@Type"os,
        "@ID": ~x"./@ID"os,
        "@ID_Context": ~x"./@ID_Context"os
      ],
      Profile: [
        ~x"./*[local-name() = 'Profile']"o,
        "@ProfileType": ~x"./@ProfileType"os,
        Customer: [
          ~x"./*[local-name() = 'Customer']"o,
          PersonName: [
            ~x"./*[local-name() = 'PersonName']"o,
            NamePrefix: ~x"./*[local-name() = 'NamePrefix']/text()"os,
            GivenName: ~x"./*[local-name() = 'GivenName']/text()"os,
            MiddleName: ~x"./*[local-name() = 'MiddleName']/text()"os,
            Surname: ~x"./*[local-name() = 'Surname']/text()"os
          ],
          Telephone: [
            ~x"./*[local-name() = 'Telephone']"ol,
            "@PhoneNumber": ~x"./@PhoneNumber"os,
            "@PhoneUseType": ~x"./@PhoneUseType"os,
            "@PhoneTechType": ~x"./@PhoneTechType"os
          ],
          Email: ~x"./*[local-name() = 'Email']/text()"os,
          Address: [
            ~x"./*[local-name() = 'Address']"o,
            AddressLine: ~x"./*[local-name() = 'AddressLine']/text()"os,
            CityName: ~x"./*[local-name() = 'CityName']/text()"os,
            PostalCode: ~x"./*[local-name() = 'PostalCode']/text()"os,
            StateProv: ~x"./*[local-name() = 'StateProv']/text()"os,
            CountryName: ~x"./*[local-name() = 'CountryName']/text()"os,
            CompanyName: ~x"./*[local-name() = 'CompanyName']/text()"os
          ],
          CustLoyalty: [
            ~x"./*[local-name() = 'CustLoyalty']"ol,
            "@MembershipID": ~x"./@MembershipID"os,
            "@ProgramID": ~x"./@ProgramID"os,
            "@ExpiryDate": ~x"./@ExpiryDate"os
          ]
        ]
      ]
    ]
  ]

  @guarantee_type [
    ~x"./*[local-name() = 'Guarantee']"o,
    GuaranteesAccepted: [
      ~x"./*[local-name() = 'GuaranteesAccepted']/*[local-name() = 'GuaranteeAccepted']"ol,
      PaymentCard: [
        ~x"./*[local-name() = 'PaymentCard']"o,
        "@CardCode": ~x"./@CardCode"os,
        "@CardType": ~x"./@CardType"os,
        "@CardNumber": ~x"./@CardNumber"os,
        "@ExpireDate": ~x"./@ExpireDate"os,
        "@MaskedCardNumber": ~x"./@MaskedCardNumber"os,
        CardHolderName: ~x"./*[local-name() = 'CardHolderName']/text()"os,
        ThreeDomainSecurity: [
          ~x"./*[local-name() = 'ThreeDomainSecurity']"o,
          Results: [
            ~x"./*[local-name() = 'Results']"o,
            "@ThreeDSVersion": ~x"./@ThreeDSVersion"os,
            "@ECI": ~x"./@ECI"os,
            "@CAVV": ~x"./@CAVV"os,
            "@PAResStatus": ~x"./@PAResStatus"os,
            "@SignatureVerification": ~x"./@SignatureVerification"os,
            "@XID": ~x"./@XID"os,
            "@Enrolled": ~x"./@Enrolled"os,
            "@DSTransactionID": ~x"./@DSTransactionID"os
          ]
        ]
      ]
    ],
    Comments: [
      ~x"./*[local-name() = 'Comments']/*[local-name() = 'Comment']"ol,
      "@Name": ~x"./@Name"os,
      Text: ~x"./*[local-name() = 'Text']/text()"os
    ],
    GuaranteeDescription: [
      ~x"./*[local-name() = 'GuaranteeDescription']"ol,
      Text: ~x"./*[local-name() = 'Text']/text()"os
    ]
  ]

  @res_guests_type [
    ~x"./*[local-name() = 'ResGuests']/*[local-name() = 'ResGuest']"ol,
    "@ResGuestRPH": ~x"./@ResGuestRPH"os,
    "@ArrivalTime": ~x"./@ArrivalTime"os,
    "@Age": ~x"./@Age"os,
    "@PrimaryIndicator": ~x"./@PrimaryIndicator"os,
    Profiles: @profiles_type,
    Comments: [
      ~x"./*[local-name() = 'Comments']/*[local-name() = 'Comment']"ol,
      "@Name": ~x"./@Name"os,
      Text: ~x"./*[local-name() = 'Text']/text()"os
    ]
  ]

  @additional_details_type [
    ~x"./*[local-name() = 'AdditionalDetails']/*[local-name() = 'AdditionalDetail']"ol,
    "@Type": ~x"./@Type"os,
    DetailDescription: [
      ~x"./*[local-name() = 'DetailDescription']"o,
      Text: ~x"./*[local-name() = 'Text']/text()"os
    ]
  ]

  @room_rates_type [
    ~x"./*[local-name() = 'RoomRates']/*[local-name() = 'RoomRate']"ol,
    "@RoomTypeCode": ~x"./@RoomTypeCode"os,
    "@NumberOfUnits": ~x"./@NumberOfUnits"os,
    "@RatePlanCode": ~x"./@RatePlanCode"os,
    Rates: [
      ~x"./*[local-name() = 'Rates']/*[local-name() = 'Rate']"ol,
      "@RateTimeUnit": ~x"./@RateTimeUnit"os,
      "@EffectiveDate": ~x"./@EffectiveDate"os,
      "@ExpireDate": ~x"./@ExpireDate"os,
      UnitMultiplier: ~x"./@UnitMultiplier"os,
      Base: @total_type,
      Total: @total_type
    ],
    ServiceRPHs: [
      ~x"./*[local-name() = 'ServiceRPHs']/*[local-name() = 'ServiceRPH']"ol,
      "@RPH": ~x"./@RPH"os
    ]
  ]

  @room_types_type [
    ~x"./*[local-name() = 'RoomTypes']/*[local-name() = 'RoomType']"ol,
    "@RoomType": ~x"./@RoomType"os,
    "@RoomTypeCode": ~x"./@RoomTypeCode"os,
    "@NonSmoking": ~x"./@NonSmoking"os,
    "@Configuration": ~x"./@Configuration"os,
    RoomDescription: [
      ~x"./*[local-name() = 'RoomDescription']"o,
      Text: ~x"./*[local-name() = 'Text']/text()"os
    ],
    AdditionalDetails: @additional_details_type
  ]

  @rate_plans_type [
    ~x"./*[local-name() = 'RatePlans']/*[local-name() = 'RatePlan']"ol,
    "@RatePlanCode": ~x"./@RatePlanCode"os,
    "@RatePlanName": ~x"./@RatePlanName"os,
    "@EffectiveDate": ~x"./@EffectiveDate"os,
    "@ExpireDate": ~x"./@ExpireDate"os,
    RateDescription: [
      ~x"./*[local-name() = 'RateDescription']"o,
      Text: ~x"./*[local-name() = 'Text']/text()"os
    ],
    AdditionalDetails: @additional_details_type
  ]

  @room_stays_type [
    ~x"./*[local-name() = 'RoomStays']/*[local-name() = 'RoomStay']"ol,
    "@MarketCode": ~x"./@MarketCode"os,
    "@PromotionCode": ~x"./@PromotionCode"os,
    "@SourceOfBusiness": ~x"./@SourceOfBusiness"os,
    RoomTypes: @room_types_type,
    RatePlans: @rate_plans_type,
    RoomRates: @room_rates_type,
    GuestCounts: [
      ~x"./*[local-name() = 'GuestCounts']/*[local-name() = 'GuestCount']"ol,
      "@AgeQualifyingCode": ~x"./@AgeQualifyingCode"os,
      "@Count": ~x"./@Count"os
    ],
    TimeSpan: [
      ~x"./*[local-name() = 'TimeSpan']"o,
      "@Start": ~x"./@Start"os,
      "@End": ~x"./@End"os
    ],
    Total: @total_type,
    BasicPropertyInfo: [
      ~x"./*[local-name() = 'BasicPropertyInfo']"o,
      "@HotelCode": ~x"./@HotelCode"os
    ],
    ServiceRPHs: [
      ~x"./*[local-name() = 'ServiceRPHs']/*[local-name() = 'ServiceRPH']"ol,
      "@RPH": ~x"./@RPH"os
    ],
    ResGuestRPHs: [
      ~x"./*[local-name() = 'ResGuestRPHs']/*[local-name() = 'ResGuestRPH']"ol,
      "@RPH": ~x"./@RPH"os
    ],
    Comments: [
      ~x"./*[local-name() = 'Comments']/*[local-name() = 'Comment']"ol,
      Text: ~x"./*[local-name() = 'Text']/text()"os
    ]
  ]

  @res_global_info_type [
    ~x"./*[local-name() = 'ResGlobalInfo']"o,
    HotelReservationIDs: [
      ~x"./*[local-name() = 'HotelReservationIDs']/*[local-name() = 'HotelReservationID']"ol,
      "@ResID_Type": ~x"./@ResID_Type"os,
      "@ResID_Value": ~x"./@ResID_Value"os
    ],
    Total: @total_type,
    Profiles: @profiles_type,
    Memberships: [
      ~x"./*[local-name() = 'Memberships']/*[local-name() = 'Membership']"ol,
      "@ProgramCode": ~x"./@ProgramCode"os,
      "@AccountID": ~x"./@AccountID"os
    ],
    Fees: [
      ~x"./*[local-name() = 'Fees']/*[local-name() = 'Fee']"ol,
      "@TaxInclusive": ~x"./@TaxInclusive"os,
      "@Type": ~x"./@Type"os,
      "@Code": ~x"./@Code"os,
      "@Amount": ~x"./@Amount"os,
      Taxes: @taxes_type,
      Description: [
        ~x"./*[local-name() = 'Description']"o,
        "@Name": ~x"./@Name"os,
        Text: ~x"./*[local-name() = 'Text']/text()"os
      ]
    ],
    DepositPayments: [
      ~x"./*[local-name() = 'DepositPayments']"ol,
      GuaranteePayment: [
        ~x"./*[local-name() = 'GuaranteePayment']"ol,
        AmountPercent: [
          ~x"./*[local-name() = 'AmountPercent']"o,
          "@Amount": ~x"./@Amount"os,
          "@CurrencyCode": ~x"./@CurrencyCode"os,
          "@Percent": ~x"./@Percent"os,
          "@TaxInclusive": ~x"./@TaxInclusive"os
        ],
        Description: [
          ~x"./*[local-name() = 'Description']"o,
          Text: ~x"./*[local-name() = 'Text']/text()"os
        ]
      ]
    ],
    Guarantee: @guarantee_type,
    Comments: [
      ~x"./*[local-name() = 'Comments']/*[local-name() = 'Comment']"ol,
      Text: ~x"./*[local-name() = 'Text']/text()"os
    ]
  ]

  @hotel_reservation_type [
    ~x"./*[local-name() = 'HotelReservation']"ol,
    "@CreateDateTime": ~x"./@CreateDateTime"os,
    "@LastModifyDateTime": ~x"./@LastModifyDateTime"os,
    "@ResStatus": ~x"./@ResStatus"os,
    "@RoomStayReservation": ~x"./@RoomStayReservation"os,
    UniqueID: [
      ~x"./*[local-name() = 'UniqueID']"ol,
      "@Type": ~x"./@Type"os,
      "@ID": ~x"./@ID"os,
      "@ID_Context": ~x"./@ID_Context"os
    ],
    POS: [
      ~x"./*[local-name() = 'POS']"ol,
      Source: [
        ~x"./*[local-name() = 'Source']"o,
        RequestorID: [
          ~x"./*[local-name() = 'RequestorID']"o,
          "@Type": ~x"./@Type"os,
          "@ID": ~x"./@ID"os
        ],
        BookingChannel: [
          ~x"./*[local-name() = 'BookingChannel']"o,
          "@Primary": ~x"./@Primary"os,
          "@Type": ~x"./@Type"os,
          CompanyName: [
            ~x"./*[local-name() = 'CompanyName']"o,
            CompanyName: ~x"./text()"os,
            "@Code": ~x"./@Code"os
          ]
        ]
      ]
    ],
    BasicPropertyInfo: [
      ~x"./*[local-name() = 'BasicPropertyInfo']"o,
      "@HotelCode": ~x"./@HotelCode"os
    ],
    RoomStays: @room_stays_type,
    ResGuests: @res_guests_type,
    Services: @services_type,
    ResGlobalInfo: @res_global_info_type
  ]

  @sweet_xpath [
    OTA_ResRetrieveRS: [
      ~x"//*[local-name() = 'OTA_ResRetrieveRS']",
      "@Version": ~x"./@Version"os,
      "@EchoToken": ~x"./@EchoToken"os,
      "@TimeStamp": ~x"./@TimeStamp"os,
      ReservationsList: [
        ~x"./*[local-name() = 'ReservationsList']"o,
        HotelReservation: @hotel_reservation_type
      ]
    ]
  ]

  @success [
    OTA_ResRetrieveRS: [
      ~x"//*[local-name() = 'OTA_ResRetrieveRS']",
      Success: ~x"./*[local-name() = 'Success']"
    ]
  ]

  @errors [
    OTA_ResRetrieveRS: [
      ~x"//*[local-name() = 'OTA_ResRetrieveRS']",
      Errors: [
        ~x"./*[local-name() = 'Errors']/*[local-name() = 'Error']"l,
        Error: ~x"./text()"os,
        "@Type": ~x"./@Type"os,
        "@Code": ~x"./@Code"os
      ]
    ]
  ]

  @warnings [
    OTA_ResRetrieveRS: [
      ~x"//*[local-name() = 'OTA_ResRetrieveRS']",
      Warnings: [
        ~x"./*[local-name() = 'Warnings']/*[local-name() = 'Warning']"l,
        Warning: ~x"./text()"s,
        "@Type": ~x"./@Type"os,
        "@Code": ~x"./@Code"os,
        "@RecordID": ~x"./@RecordID"os
      ]
    ]
  ]

  @action :OTA_ResRetrieveRS

  def get_action_name, do: @action
  def get_mapping_for_success, do: @success
  def get_mapping_for_errors, do: @errors
  def get_mapping_for_warnings, do: @warnings
  def get_mapping_for_payload, do: @sweet_xpath
  def convert_body(struct), do: Converter.convert(struct, @sweet_xpath)
end
