mongoose = require("mongoose")
Schema = mongoose.Schema
module.exports = ->
  #User
  User = new Schema(
    username: String
    email: String
  )
  mongoose.model "User", User
  #会计科目（Account Title）
  AccountTitle = new Schema(
  	#编号
  	code:String
  	#会计科目名称
  	name:String
  )
  #通用记账凭证（general purpose voucher）
  GeneralPurposeVoucherItem = new Schema(
  	#摘要
  	summary:String
  	#会计科目（Account Title）
  	accout_title:String
  	#借方金额
  	debit:Number
  	#贷方金额
  	credit:Number
  )
  mongoose.model "GeneralPurposeVoucherItem", GeneralPurposeVoucherItem

  GeneralPurposeVoucher = new Schema(
  	time:{ type: Date, default: Date.now }
  	items : [{ type: Schema.Types.ObjectId, ref: 'GeneralPurposeVoucherItem' }]
  )
  mongoose.model "GeneralPurposeVoucher", GeneralPurposeVoucher

  return
