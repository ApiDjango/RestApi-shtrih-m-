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
        try:
            return chek(request.json)
        except Exception as e:
            return e.message

def chek(json):
    ci.ConnectionURI="tcp://172.16.0.222:7778?timeout=10000&protocol=v1&enq_mode=1"
    try:
        status = checkResult(ci.Connect())
        if status == None:
            if ci.ECRMode==4:
                status = checkResult(ci.OpenSession())
                if status != None:
                    return status
            if ci.ECRMode==3:
                oldPassword = ci.Password
                ci.Password=ci.SysAdminPassword
                status = checkResult(ci.PrintReportWithCleaning())
                if status != None:
                    return status
                ci.Password=oldPassword
        else:
            status    
    except Exception as e:
            return e.message

@app.route('/status', methods = ['GET'])
def status():
	return 'Run'


if __name__ == '__main__':
    #context = ('certificate.crt', 'privateKey.key')
    app.run(host='0.0.0.0',port=5555,debug=True)#,ssl_context=context)
