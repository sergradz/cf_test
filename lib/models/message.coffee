mongoose = require("mongoose")

Schema = mongoose.Schema

messageSchema = new Schema(
  userId:
    type: Number
    required: true

  currencyFrom:
    type: String
    trim: true,
    uppercase: true,
    required: true

  currencyTo:
    type: String
    trim: true,
    uppercase: true,
    required: true

  amountSell:
    type: Number
    required: true
    min: 0

  amountBuy:
    type: Number
    required: true
    min: 0

  rate:
    type: Number
    required: true

  originatingCountry:
    type: String
    trim: true,
    uppercase: true,
    required: true

  created_at:
    index: true
    type: Date
    default: Date.now
)

module.exports = mongoose.model("message", messageSchema)


