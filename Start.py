import os
import sys
from flask import Flask, flash, request, redirect, url_for, send_file
from fr_drv_ng import classic_interface
app = Flask(__name__)
ci = classic_interface()

def checkResult(err):
    if ci.ResultCode != 0:
        return('Error: '+ str(ci.ResultCode)+' '+ci.ResultCodeDescription)

@app.route('/sale', methods = ['POST'])
def sale():
    content_type = request.headers.get('Content-Type')
    if (content_type == 'application/json'):
            json = request.get_json()
            ci.ConnectionURI="tcp://172.0.0.222:7778?timeout=10000&protocol=v1&enq_mode=1"
            status = ''
            status = checkResult(ci.Connect())
            if ci.ECRMode==4:
                status = checkResult(ci.OpenSession())
                if status != None:
                    return 'OpenSession: '+status
            if ci.ECRMode==3:
                oldPassword = ci.Password
                ci.Password=ci.SysAdminPassword
                status = checkResult(ci.PrintReportWithCleaning())
                if status != None:
                    return 'PrintReportWithCleaning: '+status
                ci.Password=oldPassword
            ci.CheckType = 0 #json["CheckType"]
            status = checkResult(ci.OpenCheck())
            if status != None:
                return 'OpenCheck: '+status
            ci.CustomerEmail = json["CustomerEmail"]
            status = checkResult(ci.FNSendCustomerEmail())
            if status != None:
                return 'FNSendCustomerEmail: '+status
            ci.StringForPrinting = '"'+json["StringForPrinting"]+'"'
            ci.Price = json["Price"]
            ci.Quantity = json["QUANTITY"]
            ci.Summa2 = json["SaleSumma"]
            ci.Tax1 = 1
            ci.CheckType = json["CheckType"]
            ci.Summa2 = json["SaleSumma"]
            ci.PaymentTypeSign = json["PaymentTypeSign"]
            ci.PaymentItemSign = json["PaymentItemSign"]
            status = checkResult(ci.FNOperation())
            if status != None:
                return 'FNOperation: '+status
            status = checkResult(ci.CheckSubTotal())
            if status != None:
                return 'CheckSubTotal: '+status
            ci.Summa2 = json["SaleSumma"]
            status = checkResult(ci.FNCloseCheckEx())
            if status != None:
                return 'FNCloseCheckEx: '+status
            return 'GOD'               

@app.route('/status', methods = ['GET'])
def status():
	return 'Run'


if __name__ == '__main__':
    #context = ('certificate.crt', 'privateKey.key')
    app.run(host='0.0.0.0',port=5555,debug=True)#,ssl_context=context)
