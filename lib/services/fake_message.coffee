###
  Generate realistic data
###

faker = require 'faker'
_ = require 'underscore'
moment = require 'moment'

countryCodes =  ["AD", "AE", "AF", "AG", "AI", "AL", "AM", "AO", "AQ", "AR", "AS", "AT", "AU", "AW", "AX", "AZ", "BA", "BB", "BD", "BE", "BF", "BG", "BH", "BI", "BJ", "BL", "BM", "BN", "BO", "BQ", "BQ", "BR", "BS", "BT", "BV", "BW", "BY", "BZ", "CA", "CC", "CD", "CF", "CG", "CH", "CI", "CK", "CL", "CM", "CN", "CO", "CR", "CU", "CV", "CW", "CX", "CY", "CZ", "DE", "DJ", "DK", "DM", "DO", "DZ", "EC", "EE", "EG", "EH", "ER", "ES", "ET", "FI", "FJ", "FK", "FM", "FO", "FR", "GA", "GB", "GD", "GE", "GF", "GG", "GH", "GI", "GL", "GM", "GN", "GP", "GQ", "GR", "GS", "GT", "GU", "GW", "GY", "HK", "HM", "HN", "HR", "HT", "HU", "ID", "IE", "IL", "IM", "IN", "IO", "IQ", "IR", "IS", "IT", "JE", "JM", "JO", "JP", "KE", "KG", "KH", "KI", "KM", "KN", "KP", "KR", "KW", "KY", "KZ", "LA", "LB", "LC", "LI", "LK", "LR", "LS", "LT", "LU", "LV", "LY", "MA", "MC", "MD", "ME", "MF", "MG", "MH", "MK", "ML", "MM", "MN", "MO", "MP", "MQ", "MR", "MS", "MT", "MU", "MV", "MW", "MX", "MY", "MZ", "NA", "NC", "NE", "NF", "NG", "NI", "NL", "NO", "NP", "NR", "NU", "NZ", "OM", "PA", "PE", "PF", "PG", "PH", "PK", "PL", "PM", "PN", "PR", "PS", "PT", "PW", "PY", "QA", "RE", "RO", "RS", "RU", "RW", "SA", "SB", "SC", "SD", "SE", "SG", "SH", "SI", "SJ", "SK", "SL", "SM", "SN", "SO", "SR", "SS", "ST", "SV", "SX", "SY", "SZ", "TC", "TD", "TF", "TG", "TH", "TJ", "TK", "TL", "TM", "TN", "TO", "TR", "TT", "TV", "TW", "TZ", "UA", "UG", "UM", "US", "UY", "UZ", "VA", "VC", "VE", "VG", "VI", "VN", "VU", "WF", "WS", "YE", "YT", "ZA", "ZM", "ZW"]

module.exports = (options = {}) ->


  userId = if options.userId then options.userId else _.random(1, 9999999)
  timePlaced = if options.timePlaced then options.timePlaced else moment(faker.date.recent()).format('DD-MMM-YYYY hh:mm:ss')
  currencyFrom = if options.currencyFrom then options.currencyFrom else faker.finance.currencyCode()
  currencyTo = if options.currencyTo then options.currencyTo else faker.finance.currencyCode()
  originatingCountry = if options.originatingCountry then options.originatingCountry else _.sample countryCodes

  amountBuy = _.random(50, 1000000)
  diffPercent = _.random(1, 100) / 10 # 1% - 10%
  plusMinus = if _.random(0, 1) == 0 then 1 else -1
  amountSell = amountBuy + (amountBuy / 100 * plusMinus * diffPercent)
  rate = amountBuy / amountSell

  message =
    'userId': userId
    'currencyFrom': currencyFrom
    'currencyTo': currencyTo
    'amountSell': amountSell
    'amountBuy': amountBuy
    'rate': rate
    'timePlaced': timePlaced
    'originatingCountry': originatingCountry

