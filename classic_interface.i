%module classic_fr_drv_ng
%include <std_string.i>
%include <stdint.i>
%include <std_vector.i>
%pragma(java) moduleimports=%{
import java.util.Date;
%}
%pragma(java) jniclassimports=%{
import java.util.Date;
%}


#ifdef SWIGPYTHON
%{
#include <cstdint>
%}
// Instantiate templates used by classic_fr_drv_ng
namespace std {
    %template(VectorOfBytes) vector<uint8_t>;
}
#endif //SWIGPYTHON

%{
#include <classic_interface.h>
#include <chrono>

%}
#ifdef SWIGPYTHON
%{
#include <datetime.h>
%}

%typemap(out) std::time_t {
  if (!PyDateTimeAPI) { PyDateTime_IMPORT; }
  PyObject *floatObj = NULL;
  PyObject *timeTuple = NULL;
  floatObj = PyFloat_FromDouble(static_cast<double>($1));
  timeTuple = Py_BuildValue("(O)", floatObj);
  $result = PyDateTime_FromTimestamp(timeTuple);
}

%typemap(typecheck, precedence=SWIG_TYPECHECK_POINTER) std::time_t {
  if (!PyDateTimeAPI) { PyDateTime_IMPORT; }
  $1 = PyDateTime_Check($input) ? 1 : 0;
}

%typemap(in) std::time_t {
  if (!PyDateTimeAPI) { PyDateTime_IMPORT; }
  if (!PyDateTime_Check($input)) {
    PyErr_SetString(PyExc_ValueError,"Expected a datetime"); return NULL;
  }
    struct tm t ={
      PyDateTime_DATE_GET_SECOND($input),
      PyDateTime_DATE_GET_MINUTE($input),
      PyDateTime_DATE_GET_HOUR($input),
      PyDateTime_GET_DAY($input),
      PyDateTime_GET_MONTH($input)-1,
      PyDateTime_GET_YEAR($input)-1900,
      0,
      0,
      0
    };
  $1 = mktime(&t);
}
#endif //SWIGPYTHON

#ifdef SWIGJAVA


/* turn on director wrapping std::function<void(const std::string&)> */
%feature("director") std::function<void(const std::string&)>;
/* turn on director wrapping std::function<void(const std::string&)> */
%feature("director") (*const func)(const std::string&);
%typemap(javaimports) classic_interface
%{
import java.util.Date;
%}
%typemap(javacode) classic_interface
%{
static{
        System.loadLibrary("classic_fr_drv_ng");
}
%}
// std::time_t
%typemap(jni) std::time_t "jobject"
%typemap(jtype) std::time_t "Date"
%typemap(jstype) std::time_t "Date"
%typemap(javadirectorin) std::time_t "$jniinput"
%typemap(javadirectorout) std::time_t "$javacall"

%typemap(in) std::time_t 
%{ if(!$input) {
     SWIG_JavaThrowException(jenv, SWIG_JavaNullPointerException, "null std::time_t");
     return $null;
    } 
    auto dateClass = jenv->GetObjectClass($input);
    auto getTimeId = jenv->GetMethodID(dateClass, "getTime", "()J");
    auto ret = jenv->CallLongMethod($input, getTimeId);
    $1 = static_cast<std::time_t>(ret / 1000);
%}

%typemap(out) std::time_t 
%{ 
 auto dateClass = jenv->FindClass("java/util/Date");
 auto dateTypeConstructor = jenv->GetMethodID(dateClass, "<init>", "(J)V");
 $result = jenv->NewObject(dateClass, dateTypeConstructor, static_cast<jlong>($1 * static_cast<jlong>(1000)));
%}

%typemap(javain) std::time_t "$javainput"

%typemap(javaout) std::time_t {
    return $jnicall;
  }
  
// std::vector<uint8_t>
%typemap(jni) std::vector<uint8_t> "jbyteArray"
%typemap(jtype) std::vector<uint8_t> "byte[]"
%typemap(jstype) std::vector<uint8_t> "byte[]"
%typemap(javadirectorin) std::vector<uint8_t> "$jniinput"
%typemap(javadirectorout) std::vector<uint8_t> "$javacall"

%typemap(in) std::vector<uint8_t> 
%{ if(!$input) {
     SWIG_JavaThrowException(jenv, SWIG_JavaNullPointerException, "null std::vector<uint8_t>");
     return $null;
    } 
    std::vector<uint8_t> result;
    auto bytesSize = jenv->GetArrayLength($input);
    if (bytesSize != 0) {
        result = std::vector<uint8_t> (static_cast<size_t>(bytesSize));
        $1 = &result;
        jenv->GetByteArrayRegion($input, 0, bytesSize, reinterpret_cast<jbyte*>(result.data()));
    }
%}

%typemap(out) std::vector<uint8_t> 
%{ 
    auto maxSize = $1.size();
    $result = jenv->NewByteArray(maxSize);
    jenv->SetByteArrayRegion(
                $result, 0, maxSize, reinterpret_cast<const signed char*>($1.data()));
%}

%typemap(javain) std::vector<uint8_t> "$javainput"

%typemap(javaout) std::vector<uint8_t> {
    return $jnicall;
  }
  
  // const std::vector<uint8_t> &
%typemap(jni) const std::vector<uint8_t> & "jbyteArray"
%typemap(jtype) const std::vector<uint8_t> & "byte[]"
%typemap(jstype) const std::vector<uint8_t> & "byte[]"
%typemap(javadirectorin) const std::vector<uint8_t> & "$jniinput"
%typemap(javadirectorout) const std::vector<uint8_t> & "$javacall"

%typemap(in) const std::vector<uint8_t> & 
%{ if(!$input) {
     SWIG_JavaThrowException(jenv, SWIG_JavaNullPointerException, "null std::vector<uint8_t> &");
     return $null;
    } 
    std::vector<uint8_t> result;
    auto bytesSize = jenv->GetArrayLength($input);
    if (bytesSize != 0) {
        result = std::vector<uint8_t> (static_cast<size_t>(bytesSize));
        $1 = &result;
        jenv->GetByteArrayRegion($input, 0, bytesSize, reinterpret_cast<jbyte*>(result.data()));
    }
%}

%typemap(out) const std::vector<uint8_t> & 
%{ 
    auto maxSize = $1.size();
    $result = jenv->NewByteArray(maxSize);
    jenv->SetByteArrayRegion(
                $result, 0, maxSize, reinterpret_cast<const signed char*>($1.data()));
%}

%typemap(javain) const std::vector<uint8_t> & "$javainput"

%typemap(javaout) const std::vector<uint8_t> & {
    return $jnicall;
  }
  
#endif //SWIGJAVA
#ifdef SWIGCSHARP

typedef long long int std::time_t;
%template(BytesVector) std::vector<uint8_t>;
%apply int64_t { std::time_t };
#endif //SWIGCSHARP

#if defined(SWIGPYTHON) || defined (SWIGCSHARP)
%include <attribute.i>
%attribute(classic_interface, int, ActivizationControlByte, Get_ActivizationControlByte, Set_ActivizationControlByte);
%attribute(classic_interface, int, ActivizationStatus, Get_ActivizationStatus, Set_ActivizationStatus);
%attribute(classic_interface, bool, AdjustRITimeout, Get_AdjustRITimeout, Set_AdjustRITimeout);
%attribute(classic_interface, int, AnswerCode, Get_AnswerCode, Set_AnswerCode);
%attribute(classic_interface, int, AttributeNumber, Get_AttributeNumber, Set_AttributeNumber);
%attributestring(classic_interface, std::string, AttributeValue, Get_AttributeValue, Set_AttributeValue);
%attribute(classic_interface, bool, AutoSensorValues, Get_AutoSensorValues, Set_AutoSensorValues);
%attribute(classic_interface, bool, AutoStartSearch, Get_AutoStartSearch, Set_AutoStartSearch);
%attribute(classic_interface, int, BanknoteCount, Get_BanknoteCount);
%attribute(classic_interface, int, BanknoteType, Get_BanknoteType);
%attributestring(classic_interface, std::string, BarCode, Get_BarCode, Set_BarCode);
%attribute(classic_interface, TBarcodeAlignment, BarcodeAlignment, Get_BarcodeAlignment, Set_BarcodeAlignment);
%attribute(classic_interface, int, BarcodeDataLength, Get_BarcodeDataLength, Set_BarcodeDataLength);
%attribute(classic_interface, int, BarcodeFirstLine, Get_BarcodeFirstLine, Set_BarcodeFirstLine);
%attributestring(classic_interface, std::string, BarcodeHex, Get_BarcodeHex, Set_BarcodeHex);
%attribute(classic_interface, int, BarcodeParameter1, Get_BarcodeParameter1, Set_BarcodeParameter1);
%attribute(classic_interface, int, BarcodeParameter2, Get_BarcodeParameter2, Set_BarcodeParameter2);
%attribute(classic_interface, int, BarcodeParameter3, Get_BarcodeParameter3, Set_BarcodeParameter3);
%attribute(classic_interface, int, BarcodeParameter4, Get_BarcodeParameter4, Set_BarcodeParameter4);
%attribute(classic_interface, int, BarcodeParameter5, Get_BarcodeParameter5, Set_BarcodeParameter5);
%attribute(classic_interface, int, BarcodeStartBlockNumber, Get_BarcodeStartBlockNumber, Set_BarcodeStartBlockNumber);
%attribute(classic_interface, int, BarcodeType, Get_BarcodeType, Set_BarcodeType);
%attribute(classic_interface, int, BarWidth, Get_BarWidth, Set_BarWidth);
%attribute(classic_interface, double, BatteryVoltage, Get_BatteryVoltage);
%attribute(classic_interface, int, BaudRate, Get_BaudRate, Set_BaudRate);
%attribute(classic_interface, TBinaryConversion, BinaryConversion, Get_BinaryConversion, Set_BinaryConversion);
%attributeval(classic_interface, std::vector<uint8_t>, BlockData, Get_BlockData, Set_BlockData);
%attributestring(classic_interface, std::string, BlockDataHex, Get_BlockDataHex, Set_BlockDataHex);
%attribute(classic_interface, int, BlockNumber, Get_BlockNumber, Set_BlockNumber);
%attribute(classic_interface, int, BlockType, Get_BlockType, Set_BlockType);
%attribute(classic_interface, int, BufferingType, Get_BufferingType, Set_BufferingType);
%attribute(classic_interface, int, CalculationSign, Get_CalculationSign, Set_CalculationSign);
%attribute(classic_interface, bool, CapGetShortECRStatus, Get_CapGetShortECRStatus);
%attribute(classic_interface, bool, CarryStrings, Get_CarryStrings, Set_CarryStrings);
%attribute(classic_interface, int, CashAcceptorPollingMode, Get_CashAcceptorPollingMode);
%attribute(classic_interface, bool, CashControlEnabled, Get_CashControlEnabled, Set_CashControlEnabled);
%attributestring(classic_interface, std::string, CashControlHost, Get_CashControlHost, Set_CashControlHost);
%attribute(classic_interface, int, CashControlPassword, Get_CashControlPassword, Set_CashControlPassword);
%attributestring(classic_interface, std::string, CashControlPort, Get_CashControlPort, Set_CashControlPort);
%attributestring(classic_interface, std::string, CashControlProtocols, Get_CashControlProtocols);
%attribute(classic_interface, bool, CashControlUseTCP, Get_CashControlUseTCP, Set_CashControlUseTCP);
%attribute(classic_interface, int, ccHeaderLineCount, Get_ccHeaderLineCount, Set_ccHeaderLineCount);
%attribute(classic_interface, bool, ccUseTextAsWareName, Get_ccUseTextAsWareName, Set_ccUseTextAsWareName);
%attribute(classic_interface, int, ccWareNameLineNumber, Get_ccWareNameLineNumber, Set_ccWareNameLineNumber);
%attribute(classic_interface, bool, CenterImage, Get_CenterImage, Set_CenterImage);
%attribute(classic_interface, int64_t, Change, Get_Change);
%attribute(classic_interface, int, ChangeFont, Get_ChangeFont, Set_ChangeFont);
%attribute(classic_interface, int, ChangeOffset, Get_ChangeOffset, Set_ChangeOffset);
%attribute(classic_interface, int, ChangeStringNumber, Get_ChangeStringNumber, Set_ChangeStringNumber);
%attribute(classic_interface, int, ChangeSumFont, Get_ChangeSumFont, Set_ChangeSumFont);
%attribute(classic_interface, int, ChangeSumOffset, Get_ChangeSumOffset, Set_ChangeSumOffset);
%attribute(classic_interface, int, ChangeSymbolNumber, Get_ChangeSymbolNumber, Set_ChangeSymbolNumber);
%attribute(classic_interface, int64_t, ChargeValue, Get_ChargeValue, Set_ChargeValue);
%attribute(classic_interface, int, CharHeight, Get_CharHeight);
%attribute(classic_interface, int, CharWidth, Get_CharWidth);
%attribute(classic_interface, bool, CheckEJConnection, Get_CheckEJConnection, Set_CheckEJConnection);
%attribute(classic_interface, bool, CheckFMConnection, Get_CheckFMConnection, Set_CheckFMConnection);
%attribute(classic_interface, int, CheckingType, Get_CheckingType, Set_CheckingType);
%attribute(classic_interface, int, CheckType, Get_CheckType, Set_CheckType);
%attributestring(classic_interface, std::string, ConnectionURI, Get_ConnectionURI, Set_ConnectionURI);
%attribute(classic_interface, int, ClicheFont, Get_ClicheFont, Set_ClicheFont);
%attribute(classic_interface, int, ClicheOffset, Get_ClicheOffset, Set_ClicheOffset);
%attribute(classic_interface, int, ClicheStringNumber, Get_ClicheStringNumber, Set_ClicheStringNumber);
%attribute(classic_interface, bool, CloudCashdeskEnabled, Get_CloudCashdeskEnabled, Set_CloudCashdeskEnabled);
%attribute(classic_interface, TCodePage, CodePage, Get_CodePage, Set_CodePage);
%attribute(classic_interface, int, CommandCode, Get_CommandCode);
%attribute(classic_interface, int, CommandCount, Get_CommandCount);
%attribute(classic_interface, int, CommandDefTimeout, Get_CommandDefTimeout);
%attribute(classic_interface, int, CommandIndex, Get_CommandIndex, Set_CommandIndex);
%attributestring(classic_interface, std::string, CommandName, Get_CommandName);
%attribute(classic_interface, int, CommandRetryCount, Get_CommandRetryCount, Set_CommandRetryCount);
%attribute(classic_interface, int, CommandTimeout, Get_CommandTimeout, Set_CommandTimeout);
%attribute(classic_interface, int, ComNumber, Get_ComNumber, Set_ComNumber);
%attributestring(classic_interface, std::string, ComputerName, Get_ComputerName, Set_ComputerName);
%attribute(classic_interface, bool, Connected, Get_Connected, Set_Connected);
%attribute(classic_interface, int, ConnectionTimeout, Get_ConnectionTimeout, Set_ConnectionTimeout);
%attribute(classic_interface, TConnectionType, ConnectionType, Get_ConnectionType, Set_ConnectionType);
%attribute(classic_interface, int64_t, ContentsOfCashRegister, Get_ContentsOfCashRegister);
%attribute(classic_interface, int, ContentsOfOperationRegister, Get_ContentsOfOperationRegister);
%attribute(classic_interface, int, CopyOffset1, Get_CopyOffset1, Set_CopyOffset1);
%attribute(classic_interface, int, CopyOffset2, Get_CopyOffset2, Set_CopyOffset2);
%attribute(classic_interface, int, CopyOffset3, Get_CopyOffset3, Set_CopyOffset3);
%attribute(classic_interface, int, CopyOffset4, Get_CopyOffset4, Set_CopyOffset4);
%attribute(classic_interface, int, CopyOffset5, Get_CopyOffset5, Set_CopyOffset5);
%attribute(classic_interface, int, CopyType, Get_CopyType, Set_CopyType);
%attribute(classic_interface, int, CorrectionType, Get_CorrectionType, Set_CorrectionType);
%attribute(classic_interface, int, CustomerCode, Get_CustomerCode, Set_CustomerCode);
%attributestring(classic_interface, std::string, CustomerEmail, Get_CustomerEmail, Set_CustomerEmail);
%attribute(classic_interface, bool, CutType, Get_CutType, Set_CutType);
%attributestring(classic_interface, std::string, DataBlock, Get_DataBlock);
%attribute(classic_interface, int, DataBlockNumber, Get_DataBlockNumber);
%attribute(classic_interface, int, DataLength, Get_DataLength, Set_DataLength);
%attribute(classic_interface, std::time_t, Date, Get_Date, Set_Date);
%attribute(classic_interface, std::time_t, Date2, Get_Date2, Set_Date2);
%attribute(classic_interface, int, DBDocType, Get_DBDocType, Set_DBDocType);
%attributestring(classic_interface, std::string, DBFilePath, Get_DBFilePath, Set_DBFilePath);
%attribute(classic_interface, bool, DelayedPrint, Get_DelayedPrint, Set_DelayedPrint);
%attribute(classic_interface, int, Department, Get_Department, Set_Department);
%attribute(classic_interface, int, DepartmentFont, Get_DepartmentFont, Set_DepartmentFont);
%attribute(classic_interface, int, DepartmentOffset, Get_DepartmentOffset, Set_DepartmentOffset);
%attribute(classic_interface, int, DepartmentStringNumber, Get_DepartmentStringNumber, Set_DepartmentStringNumber);
%attribute(classic_interface, int, DepartmentSymbolNumber, Get_DepartmentSymbolNumber, Set_DepartmentSymbolNumber);
%attribute(classic_interface, int, DeviceCode, Get_DeviceCode, Set_DeviceCode);
%attributestring(classic_interface, std::string, DeviceCodeDescription, Get_DeviceCodeDescription);
%attribute(classic_interface, int64_t, Discount1, Get_Discount1, Set_Discount1);
%attribute(classic_interface, int64_t, Discount2, Get_Discount2, Set_Discount2);
%attribute(classic_interface, int64_t, Discount3, Get_Discount3, Set_Discount3);
%attribute(classic_interface, int64_t, Discount4, Get_Discount4, Set_Discount4);
%attribute(classic_interface, double, DiscountOnCheck, Get_DiscountOnCheck,Set_DiscountOnCheck);
%attribute(classic_interface, int, DiscountOnCheckFont, Get_DiscountOnCheckFont, Set_DiscountOnCheckFont);
%attribute(classic_interface, int, DiscountOnCheckOffset, Get_DiscountOnCheckOffset, Set_DiscountOnCheckOffset);
%attribute(classic_interface, int, DiscountOnCheckStringNumber, Get_DiscountOnCheckStringNumber, Set_DiscountOnCheckStringNumber);
%attribute(classic_interface, int, DiscountOnCheckSumFont, Get_DiscountOnCheckSumFont, Set_DiscountOnCheckSumFont);
%attribute(classic_interface, int, DiscountOnCheckSumOffset, Get_DiscountOnCheckSumOffset, Set_DiscountOnCheckSumOffset);
%attribute(classic_interface, int, DiscountOnCheckSumSymbolNumber, Get_DiscountOnCheckSumSymbolNumber, Set_DiscountOnCheckSumSymbolNumber);
%attribute(classic_interface, int, DiscountOnCheckSymbolNumber, Get_DiscountOnCheckSymbolNumber, Set_DiscountOnCheckSymbolNumber);
%attribute(classic_interface, int64_t, DiscountValue, Get_DiscountValue, Set_DiscountValue);
%attribute(classic_interface, int, DocumentCount, Get_DocumentCount, Set_DocumentCount);
%attributestring(classic_interface, std::string, DocumentName, Get_DocumentName, Set_DocumentName);
%attribute(classic_interface, int, DocumentNumber, Get_DocumentNumber, Set_DocumentNumber);
%attribute(classic_interface, int, DocumentType, Get_DocumentType, Set_DocumentType);
%attribute(classic_interface, bool, DoNotSendENQ, Get_DoNotSendENQ, Set_DoNotSendENQ);
%attribute(classic_interface, int, DrawerNumber, Get_DrawerNumber, Set_DrawerNumber);
%attribute(classic_interface, int, DriverBuild, Get_DriverBuild);
%attribute(classic_interface, int, DriverMajorVersion, Get_DriverMajorVersion);
%attribute(classic_interface, int, DriverMinorVersion, Get_DriverMinorVersion);
%attribute(classic_interface, int, DriverRelease, Get_DriverRelease);
%attributestring(classic_interface, std::string, DriverVersion, Get_DriverVersion);
%attribute(classic_interface, int, ECRAdvancedMode, Get_ECRAdvancedMode);
%attributestring(classic_interface, std::string, ECRAdvancedModeDescription, Get_ECRAdvancedModeDescription);
%attribute(classic_interface, int, ECRBuild, Get_ECRBuild);
%attribute(classic_interface, std::time_t, ECRDate, Get_ECRDate, Set_ECRDate);
%attribute(classic_interface, int, ECRFlags, Get_ECRFlags);
%attributestring(classic_interface, std::string, ECRID, Get_ECRID, Set_ECRID);
%attributestring(classic_interface, std::string, ECRInput, Get_ECRInput);
%attribute(classic_interface, int, ECRMode, Get_ECRMode);
%attribute(classic_interface, int, ECRMode8Status, Get_ECRMode8Status);
%attributestring(classic_interface, std::string, ECRModeDescription, Get_ECRModeDescription);
%attribute(classic_interface, int, ECRModeStatus, Get_ECRModeStatus);
%attributestring(classic_interface, std::string, ECROutput, Get_ECROutput);
%attribute(classic_interface, std::time_t, ECRSoftDate, Get_ECRSoftDate);
%attributestring(classic_interface, std::string, ECRSoftVersion, Get_ECRSoftVersion);
%attribute(classic_interface, std::time_t, ECRTime, Get_ECRTime, Set_ECRTime);
%attribute(classic_interface, int, EjectDirection, Get_EjectDirection, Set_EjectDirection);
%attributestring(classic_interface, std::string, EKLZData, Get_EKLZData);
%attribute(classic_interface, int, EKLZFlags, Get_EKLZFlags);
%attribute(classic_interface, int, EKLZFont, Get_EKLZFont, Set_EKLZFont);
%attribute(classic_interface, bool, EKLZIsPresent, Get_EKLZIsPresent);
%attributestring(classic_interface, std::string, EKLZNumber, Get_EKLZNumber);
%attribute(classic_interface, int, EKLZOffset, Get_EKLZOffset, Set_EKLZOffset);
%attribute(classic_interface, int, EKLZResultCode, Get_EKLZResultCode);
%attribute(classic_interface, int, EKLZStringNumber, Get_EKLZStringNumber, Set_EKLZStringNumber);
%attributestring(classic_interface, std::string, EKLZVersion, Get_EKLZVersion);
%attribute(classic_interface, int, ErrorCode, Get_ErrorCode, Set_ErrorCode);
%attributestring(classic_interface, std::string, ErrorDescription, Get_ErrorDescription);
%attributestring(classic_interface, std::string, EscapeIP, Get_EscapeIP, Set_EscapeIP);
%attribute(classic_interface, int, EscapePort, Get_EscapePort, Set_EscapePort);
%attribute(classic_interface, int, EscapeTimeout, Get_EscapeTimeout, Set_EscapeTimeout);
%attribute(classic_interface, int, ExciseCode, Get_ExciseCode, Set_ExciseCode);
%attribute(classic_interface, bool, FeedAfterCut, Get_FeedAfterCut, Set_FeedAfterCut);
%attribute(classic_interface, int, FeedLineCount, Get_FeedLineCount, Set_FeedLineCount);
%attributestring(classic_interface, std::string, FieldName, Get_FieldName);
%attribute(classic_interface, int, FieldNumber, Get_FieldNumber, Set_FieldNumber);
%attribute(classic_interface, int, FieldSize, Get_FieldSize);
%attribute(classic_interface, bool, FieldType, Get_FieldType);
%attributestring(classic_interface, std::string, FileName, Get_FileName, Set_FileName);
%attribute(classic_interface, TFinishDocumentMode, FinishDocumentMode, Get_FinishDocumentMode, Set_FinishDocumentMode);
%attribute(classic_interface, int, FirstLineNumber, Get_FirstLineNumber, Set_FirstLineNumber);
%attribute(classic_interface, std::time_t, FirstSessionDate, Get_FirstSessionDate, Set_FirstSessionDate);
%attribute(classic_interface, int, FirstSessionNumber, Get_FirstSessionNumber, Set_FirstSessionNumber);
%attribute(classic_interface, int, FiscalSign, Get_FiscalSign, Set_FiscalSign);
%attributestring(classic_interface, std::string, FiscalSignAsString, Get_FiscalSignAsString);
%attributestring(classic_interface, std::string, FiscalSignOFD, Get_FiscalSignOFD, Set_FiscalSignOFD);
%attribute(classic_interface, bool, FM1IsPresent, Get_FM1IsPresent);
%attribute(classic_interface, bool, FM2IsPresent, Get_FM2IsPresent);
%attribute(classic_interface, int, FMBuild, Get_FMBuild);
%attribute(classic_interface, int, FMFlags, Get_FMFlags);
%attribute(classic_interface, int, FMFlagsEx, Get_FMFlagsEx);
%attribute(classic_interface, int, FMMode, Get_FMMode);
%attribute(classic_interface, int, FMOffset, Get_FMOffset, Set_FMOffset);
%attribute(classic_interface, bool, FMOverflow, Get_FMOverflow);
%attribute(classic_interface, int, FMResultCode, Get_FMResultCode);
%attribute(classic_interface, std::time_t, FMSoftDate, Get_FMSoftDate);
%attributestring(classic_interface, std::string, FMSoftVersion, Get_FMSoftVersion);
%attribute(classic_interface, int, FMStringNumber, Get_FMStringNumber, Set_FMStringNumber);
%attribute(classic_interface, int, FNCurrentDocument, Get_FNCurrentDocument, Set_FNCurrentDocument);
%attribute(classic_interface, int, FNDocumentData, Get_FNDocumentData);
%attribute(classic_interface, int, FNLifeState, Get_FNLifeState);
%attribute(classic_interface, int, FNSessionState, Get_FNSessionState);
%attribute(classic_interface, int, FNSoftType, Get_FNSoftType);
%attributestring(classic_interface, std::string, FNSoftVersion, Get_FNSoftVersion);
%attribute(classic_interface, int, FNWarningFlags, Get_FNWarningFlags);
%attribute(classic_interface, int, FontCount, Get_FontCount);
%attribute(classic_interface, int, FontType, Get_FontType, Set_FontType);
%attribute(classic_interface, int, FreeRecordInFM, Get_FreeRecordInFM);
%attribute(classic_interface, int, FreeRegistration, Get_FreeRegistration);
%attribute(classic_interface, int, HeaderFont, Get_HeaderFont, Set_HeaderFont);
%attribute(classic_interface, int, HeaderOffset, Get_HeaderOffset, Set_HeaderOffset);
%attribute(classic_interface, int, HeaderStringNumber, Get_HeaderStringNumber, Set_HeaderStringNumber);
%attribute(classic_interface, int, HorizScale, Get_HorizScale, Set_HorizScale);
%attribute(classic_interface, int, HRIPosition, Get_HRIPosition, Set_HRIPosition);
%attribute(classic_interface, int, IBMDocumentNumber, Get_IBMDocumentNumber);
%attribute(classic_interface, int, IBMFlags, Get_IBMFlags);
%attribute(classic_interface, int, IBMLastBuyReceiptNumber, Get_IBMLastBuyReceiptNumber);
%attribute(classic_interface, int, IBMLastReturnBuyReceiptNumber, Get_IBMLastReturnBuyReceiptNumber);
%attribute(classic_interface, int, IBMLastReturnSaleReceiptNumber, Get_IBMLastReturnSaleReceiptNumber);
%attribute(classic_interface, int, IBMLastSaleReceiptNumber, Get_IBMLastSaleReceiptNumber);
%attribute(classic_interface, std::time_t, IBMSessionDateTime, Get_IBMSessionDateTime);
%attribute(classic_interface, int, IBMSessionDay, Get_IBMSessionDay);
%attribute(classic_interface, int, IBMSessionHour, Get_IBMSessionHour);
%attribute(classic_interface, int, IBMSessionMin, Get_IBMSessionMin);
%attribute(classic_interface, int, IBMSessionMonth, Get_IBMSessionMonth);
%attribute(classic_interface, int, IBMSessionSec, Get_IBMSessionSec);
%attribute(classic_interface, int, IBMSessionYear, Get_IBMSessionYear);
%attribute(classic_interface, int, IBMStatusByte1, Get_IBMStatusByte1);
%attribute(classic_interface, int, IBMStatusByte2, Get_IBMStatusByte2);
%attribute(classic_interface, int, IBMStatusByte3, Get_IBMStatusByte3);
%attribute(classic_interface, int, IBMStatusByte4, Get_IBMStatusByte4);
%attribute(classic_interface, int, IBMStatusByte5, Get_IBMStatusByte5);
%attribute(classic_interface, int, IBMStatusByte6, Get_IBMStatusByte6);
%attribute(classic_interface, int, IBMStatusByte7, Get_IBMStatusByte7);
%attribute(classic_interface, int, IBMStatusByte8, Get_IBMStatusByte8);
%attribute(classic_interface, int, InfoExchangeStatus, Get_InfoExchangeStatus, Set_InfoExchangeStatus);
%attribute(classic_interface, int, InfoType, Get_InfoType, Set_InfoType);
%attributestring(classic_interface, std::string, INN, Get_INN, Set_INN);
%attribute(classic_interface, int, INNAsInteger, Get_INNAsInteger);
%attribute(classic_interface, int, IntervalNumber, Get_IntervalNumber, Set_IntervalNumber);
%attribute(classic_interface, int, IntervalValue, Get_IntervalValue, Set_IntervalValue);
%attributestring(classic_interface, std::string, IPAddress, Get_IPAddress, Set_IPAddress);
%attribute(classic_interface, bool, IsASPDMode, Get_IsASPDMode);
%attribute(classic_interface, bool, IsBatteryLow, Get_IsBatteryLow);
%attribute(classic_interface, bool, IsBlockedByWrongTaxPassword, Get_IsBlockedByWrongTaxPassword);
%attribute(classic_interface, bool, IsClearUnfiscalInfo, Get_IsClearUnfiscalInfo, Set_IsClearUnfiscalInfo);
%attribute(classic_interface, bool, IsCorruptedFiscalizationInfo, Get_IsCorruptedFiscalizationInfo);
%attribute(classic_interface, bool, IsCorruptedFMRecords, Get_IsCorruptedFMRecords);
%attribute(classic_interface, bool, IsDrawerOpen, Get_IsDrawerOpen);
%attribute(classic_interface, bool, IsEKLZOverflow, Get_IsEKLZOverflow);
%attribute(classic_interface, bool, IsFM24HoursOver, Get_IsFM24HoursOver);
%attribute(classic_interface, bool, IsFMSessionOpen, Get_IsFMSessionOpen);
%attribute(classic_interface, bool, IsLastFMRecordCorrupted, Get_IsLastFMRecordCorrupted);
%attribute(classic_interface, bool, IsPrinterLeftSensorFailure, Get_IsPrinterLeftSensorFailure);
%attribute(classic_interface, bool, IsPrinterRightSensorFailure, Get_IsPrinterRightSensorFailure);
%attribute(classic_interface, bool, JournalEnabled, Get_JournalEnabled, Set_JournalEnabled);
%attribute(classic_interface, bool, JournalRibbonIsPresent, Get_JournalRibbonIsPresent);
%attribute(classic_interface, bool, JournalRibbonLever, Get_JournalRibbonLever);
%attribute(classic_interface, bool, JournalRibbonOpticalSensor, Get_JournalRibbonOpticalSensor);
%attributestring(classic_interface, std::string, JournalRow, Get_JournalRow);
%attribute(classic_interface, int, JournalRowCount, Get_JournalRowCount);
%attribute(classic_interface, int, JournalRowNumber, Get_JournalRowNumber, Set_JournalRowNumber);
%attributestring(classic_interface, std::string, JournalText, Get_JournalText);
%attributestring(classic_interface, std::string, KKTRegistrationNumber, Get_KKTRegistrationNumber, Set_KKTRegistrationNumber);
%attribute(classic_interface, int, KPKFont, Get_KPKFont, Set_KPKFont);
%attribute(classic_interface, int, KPKNumber, Get_KPKNumber, Set_KPKNumber);
%attribute(classic_interface, int, KPKOffset, Get_KPKOffset, Set_KPKOffset);
%attributestring(classic_interface, std::string, KPKStr, Get_KPKStr);
%attribute(classic_interface, int, KPKValue, Get_KPKValue, Set_KPKValue);
%attributestring(classic_interface, std::string, KSAInfo, Get_KSAInfo, Set_KSAInfo);
%attribute(classic_interface, int, LastFMRecordType, Get_LastFMRecordType);
%attribute(classic_interface, std::time_t, LastKPKDate, Get_LastKPKDate);
%attributestring(classic_interface, std::string, LastKPKDateStr, Get_LastKPKDateStr);
%attribute(classic_interface, int64_t, LastKPKDocumentResult, Get_LastKPKDocumentResult);
%attribute(classic_interface, int, LastKPKNumber, Get_LastKPKNumber);
%attribute(classic_interface, std::time_t, LastKPKTime, Get_LastKPKTime);
%attributestring(classic_interface, std::string, LastKPKTimeStr, Get_LastKPKTimeStr);
%attribute(classic_interface, int, LastLineNumber, Get_LastLineNumber, Set_LastLineNumber);
%attribute(classic_interface, int, LastPrintResult, Get_LastPrintResult);
%attribute(classic_interface, std::time_t, LastSessionDate, Get_LastSessionDate, Set_LastSessionDate);
%attribute(classic_interface, int, LastSessionNumber, Get_LastSessionNumber, Set_LastSessionNumber);
%attribute(classic_interface, int, LDBaudrate, Get_LDBaudrate, Set_LDBaudrate);
%attribute(classic_interface, int, LDComNumber, Get_LDComNumber, Set_LDComNumber);
%attributestring(classic_interface, std::string, LDComputerName, Get_LDComputerName, Set_LDComputerName);
%attribute(classic_interface, TConnectionType, LDConnectionType, Get_LDConnectionType, Set_LDConnectionType);
%attribute(classic_interface, int, LDCount, Get_LDCount);
%attributestring(classic_interface, std::string, LDEscapeIP, Get_LDEscapeIP, Set_LDEscapeIP);
%attribute(classic_interface, int, LDEscapePort, Get_LDEscapePort, Set_LDEscapePort);
%attribute(classic_interface, int, LDEscapeTimeout, Get_LDEscapeTimeout, Set_LDEscapeTimeout);
%attribute(classic_interface, int, LDIndex, Get_LDIndex, Set_LDIndex);
%attributestring(classic_interface, std::string, LDIPAddress, Get_LDIPAddress, Set_LDIPAddress);
%attributestring(classic_interface, std::string, LDName, Get_LDName, Set_LDName);
%attribute(classic_interface, int, LDNumber, Get_LDNumber, Set_LDNumber);
%attribute(classic_interface, int, LDProtocolType, Get_LDProtocolType, Set_LDProtocolType);
%attribute(classic_interface, int, LDSysAdminPassword, Get_LDSysAdminPassword, Set_LDSysAdminPassword);
%attribute(classic_interface, int, LDTCPPort, Get_LDTCPPort, Set_LDTCPPort);
%attribute(classic_interface, int, LDTimeout, Get_LDTimeout, Set_LDTimeout);
%attribute(classic_interface, bool, LDUseIPAddress, Get_LDUseIPAddress, Set_LDUseIPAddress);
%attributestring(classic_interface, std::string, License, Get_License, Set_License);
%attribute(classic_interface, bool, LicenseIsPresent, Get_LicenseIsPresent);
%attribute(classic_interface, bool, LidPositionSensor, Get_LidPositionSensor);
%attributestring(classic_interface, std::string, LineData, Get_LineData, Set_LineData);
%attributestring(classic_interface, std::string, LineData2, Get_LineData2, Set_LineData2);
%attributestring(classic_interface, std::string, LineDataHex, Get_LineDataHex, Set_LineDataHex);
%attribute(classic_interface, int, LineNumber, Get_LineNumber, Set_LineNumber);
%attribute(classic_interface, bool, LineSwapBytes, Get_LineSwapBytes, Set_LineSwapBytes);
%attribute(classic_interface, int, LockTimeout, Get_LockTimeout, Set_LockTimeout);
%attribute(classic_interface, int, LogicalNumber, Get_LogicalNumber);
%attribute(classic_interface, int, LogMaxFileCount, Get_LogMaxFileCount, Set_LogMaxFileCount);
%attribute(classic_interface, int, LogMaxFileSize, Get_LogMaxFileSize, Set_LogMaxFileSize);
%attribute(classic_interface, bool, LogOn, Get_LogOn, Set_LogOn);
%attribute(classic_interface, int, MAXValueOfField, Get_MAXValueOfField);
%attribute(classic_interface, int, MessageCount, Get_MessageCount, Set_MessageCount);
%attribute(classic_interface, int, MessageState, Get_MessageState, Set_MessageState);
%attributestring(classic_interface, std::string, MethodName, Get_MethodName, Set_MethodName);
%attributestring(classic_interface, std::string, MFPNumber, Get_MFPNumber, Set_MFPNumber);
%attribute(classic_interface, int, MFPStatus, Get_MFPStatus, Set_MFPStatus);
%attribute(classic_interface, int, MINValueOfField, Get_MINValueOfField);
%attribute(classic_interface, bool, MobilePayEnabled, Get_MobilePayEnabled, Set_MobilePayEnabled);
%attribute(classic_interface, int, ModelID, Get_ModelID, Set_ModelID);
%attribute(classic_interface, int, ModelIndex, Get_ModelIndex, Set_ModelIndex);
%attributestring(classic_interface, std::string, ModelNames, Get_ModelNames);
%attribute(classic_interface, int, ModelParamCount, Get_ModelParamCount);
%attributestring(classic_interface, std::string, ModelParamDescription, Get_ModelParamDescription);
%attribute(classic_interface, int, ModelParamIndex, Get_ModelParamIndex, Set_ModelParamIndex);
%attribute(classic_interface, int, ModelParamNumber, Get_ModelParamNumber, Set_ModelParamNumber);
%attribute(classic_interface, bool, ModelParamValue, ReadModelParamValue);
%attribute(classic_interface, int, ModelsCount, Get_ModelsCount);
%attribute(classic_interface, int, MultiplicationFont, Get_MultiplicationFont, Set_MultiplicationFont);
%attributestring(classic_interface, std::string, NameCashReg, Get_NameCashReg);
%attributestring(classic_interface, std::string, NameCashRegEx, Get_NameCashRegEx);
%attributestring(classic_interface, std::string, NameOperationReg, Get_NameOperationReg);
%attribute(classic_interface, int, NewPasswordTI, Get_NewPasswordTI, Set_NewPasswordTI);
%attribute(classic_interface, int, NewSCPassword, Get_NewSCPassword, Set_NewSCPassword);
%attribute(classic_interface, int, NumberOfCopies, Get_NumberOfCopies, Set_NumberOfCopies);
%attribute(classic_interface, bool, OFDTicketReceived, Get_OFDTicketReceived, Set_OFDTicketReceived);
%attribute(classic_interface, int, OPBarcodeInputType, Get_OPBarcodeInputType, Set_OPBarcodeInputType);
%attribute(classic_interface, int, OpenDocumentNumber, Get_OpenDocumentNumber);
%attribute(classic_interface, int, OperationBlockFirstString, Get_OperationBlockFirstString, Set_OperationBlockFirstString);
%attribute(classic_interface, int, OperationNameFont, Get_OperationNameFont, Set_OperationNameFont);
%attribute(classic_interface, int, OperationNameOffset, Get_OperationNameOffset, Set_OperationNameOffset);
%attribute(classic_interface, int, OperationNameStringNumber, Get_OperationNameStringNumber, Set_OperationNameStringNumber);
%attribute(classic_interface, int, OperatorNumber, Get_OperatorNumber);
%attribute(classic_interface, int, OperationType, Get_OperationType, Set_OperationType);
%attributestring(classic_interface, std::string, OPIdPayment, Get_OPIdPayment, Set_OPIdPayment);
%attribute(classic_interface, int, OPRequisiteNumber, Get_OPRequisiteNumber, Set_OPRequisiteNumber);
%attributestring(classic_interface, std::string, OPRequisiteValue, Get_OPRequisiteValue, Set_OPRequisiteValue);
%attribute(classic_interface, int, OPSystem, Get_OPSystem, Set_OPSystem);
%attribute(classic_interface, int, OPTransactionStatus, Get_OPTransactionStatus, Set_OPTransactionStatus);
%attribute(classic_interface, int, OPTransactionType, Get_OPTransactionType, Set_OPTransactionType);
%attributestring(classic_interface, std::string, ParameterValue, Get_ParameterValue, Set_ParameterValue);
%attribute(classic_interface, int, ParentWnd, Get_ParentWnd, Set_ParentWnd);
%attribute(classic_interface, int, Password, Get_Password, Set_Password);
%attribute(classic_interface, int, PayDepartment, Get_PayDepartment, Set_PayDepartment);
%attribute(classic_interface, int, PaymentItemSign, Get_PaymentItemSign, Set_PaymentItemSign);
%attribute(classic_interface, int, PaymentTypeSign, Get_PaymentTypeSign, Set_PaymentTypeSign);
%attribute(classic_interface, int, PermitActivizationCode, Get_PermitActivizationCode, Set_PermitActivizationCode);
%attribute(classic_interface, int, PingResult, Get_PingResult, Set_PingResult);
%attribute(classic_interface, int, PingTime, Get_PingTime, Set_PingTime);
%attribute(classic_interface, bool, PointPosition, Get_PointPosition, Set_PointPosition);
%attribute(classic_interface, int, Poll1, Get_Poll1);
%attribute(classic_interface, int, Poll2, Get_Poll2);
%attributestring(classic_interface, std::string, PosControlReceiptSeparator, Get_PosControlReceiptSeparator, Set_PosControlReceiptSeparator);
%attribute(classic_interface, bool, PortLocked, Get_PortLocked);
%attribute(classic_interface, int, PortNumber, Get_PortNumber, Set_PortNumber);
%attributestring(classic_interface, double, PowerSourceVoltage, Get_PowerSourceVoltage);
%attribute(classic_interface, int, PrepareActivizationRemainCount, Get_PrepareActivizationRemainCount, Set_PrepareActivizationRemainCount);
%attribute(classic_interface, bool, PresenterIn, Get_PresenterIn);
%attribute(classic_interface, bool, PresenterOut, Get_PresenterOut);
%attribute(classic_interface, int64_t, Price, Get_Price, Set_Price);
%attribute(classic_interface, int, PriceFont, Get_PriceFont, Set_PriceFont);
%attribute(classic_interface, int, PriceSymbolNumber, Get_PriceSymbolNumber, Set_PriceSymbolNumber);
%attribute(classic_interface, int, PrintBarcodeText, Get_PrintBarcodeText, Set_PrintBarcodeText);
%attribute(classic_interface, int, PrintBufferFormat, Get_PrintBufferFormat, Set_PrintBufferFormat);
%attribute(classic_interface, int, PrintBufferLineNumber, ReadPrintBufferLineNumber);
%attribute(classic_interface, int, PrintingAlignment, Get_PrintingAlignment, Set_PrintingAlignment);
%attribute(classic_interface, bool, PrintJournalBeforeZReport, Get_PrintJournalBeforeZReport, Set_PrintJournalBeforeZReport);
%attribute(classic_interface, int, PrintWidth, Get_PrintWidth);
%attributestring(classic_interface, std::string, PropertyName, Get_PropertyName, Set_PropertyName);
%attribute(classic_interface, int, ProtocolType, Get_ProtocolType, Set_ProtocolType);
%attribute(classic_interface, double, Quantity, Get_Quantity,Set_Quantity);
%attribute(classic_interface, int, QuantityFont, Get_QuantityFont, Set_QuantityFont);
%attribute(classic_interface, int, QuantityFormat, Get_QuantityFormat, Set_QuantityFormat);
%attribute(classic_interface, int, QuantityOffset, Get_QuantityOffset, Set_QuantityOffset);
%attribute(classic_interface, int, QuantityOfOperations, Get_QuantityOfOperations);
%attribute(classic_interface, bool, QuantityPointPosition, Get_QuantityPointPosition);
%attribute(classic_interface, int, QuantityStringNumber, Get_QuantityStringNumber, Set_QuantityStringNumber);
%attribute(classic_interface, int, QuantitySymbolNumber, Get_QuantitySymbolNumber, Set_QuantitySymbolNumber);
%attribute(classic_interface, int, RealPayDepartment, Get_RealPayDepartment, Set_RealPayDepartment);
%attribute(classic_interface, int, ReceiptNumber, Get_ReceiptNumber, Set_ReceiptNumber);
%attribute(classic_interface, int, ReceiptOutputType, Get_ReceiptOutputType, Set_ReceiptOutputType);
%attribute(classic_interface, bool, ReceiptRibbonIsPresent, Get_ReceiptRibbonIsPresent);
%attribute(classic_interface, bool, ReceiptRibbonLever, Get_ReceiptRibbonLever);
%attribute(classic_interface, bool, ReceiptRibbonOpticalSensor, Get_ReceiptRibbonOpticalSensor);
%attribute(classic_interface, bool, ReconnectPort, Get_ReconnectPort, Set_ReconnectPort);
%attribute(classic_interface, int, RecordCount, Get_RecordCount);
%attribute(classic_interface, int64_t, RegBuyRec, Get_RegBuyRec);
%attribute(classic_interface, int64_t, RegBuyReturnRec, Get_RegBuyReturnRec);
%attribute(classic_interface, int64_t, RegBuyReturnSession, Get_RegBuyReturnSession);
%attribute(classic_interface, int64_t, RegBuySession, Get_RegBuySession);
%attribute(classic_interface, int, RegisterNumber, Get_RegisterNumber, Set_RegisterNumber);
%attribute(classic_interface, int, RegistrationNumber, Get_RegistrationNumber, Set_RegistrationNumber);
%attribute(classic_interface, int, RegistrationReasonCode, Get_RegistrationReasonCode, Set_RegistrationReasonCode);
%attribute(classic_interface, int64_t, RegSaleRec, Get_RegSaleRec);
%attribute(classic_interface, int64_t, RegSaleReturnRec, Get_RegSaleReturnRec);
%attribute(classic_interface, int64_t, RegSaleReturnSession, Get_RegSaleReturnSession);
%attribute(classic_interface, int64_t, RegSaleSession, Get_RegSaleSession);
%attribute(classic_interface, bool, ReportType, Get_ReportType, Set_ReportType);
%attribute(classic_interface, int, ReportTypeInt, Get_ReportTypeInt, Set_ReportTypeInt);
%attribute(classic_interface, bool, RequestErrorDescription, Get_RequestErrorDescription, Set_RequestErrorDescription);
%attribute(classic_interface, int, RequestType, Get_RequestType, Set_RequestType);
%attribute(classic_interface, int, ResultCode, Get_ResultCode);
%attributestring(classic_interface, std::string, ResultCodeDescription, Get_ResultCodeDescription);
%attributestring(classic_interface, std::string, RNM, Get_RNM, Set_RNM);
%attribute(classic_interface, int, RoundingSumm, Get_RoundingSumm, Set_RoundingSumm);
%attribute(classic_interface, int, RowNumber, Get_RowNumber, Set_RowNumber);
%attribute(classic_interface, int, RunningPeriod, Get_RunningPeriod, Set_RunningPeriod);
%attribute(classic_interface, bool, SaleError, Get_SaleError, Set_SaleError);
%attribute(classic_interface, int, SaveSettingsType, Get_SaveSettingsType, Set_SaveSettingsType);
%attribute(classic_interface, int, SCPassword, Get_SCPassword, Set_SCPassword);
%attribute(classic_interface, int, SearchTimeout, Get_SearchTimeout, Set_SearchTimeout);
%attributestring(classic_interface, std::string, SerialNumber, Get_SerialNumber, Set_SerialNumber);
%attribute(classic_interface, int, SerialNumberAsInteger, Get_SerialNumberAsInteger);
%attribute(classic_interface, bool, ServerConnected, Get_ServerConnected);
%attributestring(classic_interface, std::string, ServerVersion, Get_ServerVersion);
%attribute(classic_interface, int, SessionNumber, Get_SessionNumber, Set_SessionNumber);
%attribute(classic_interface, bool, ShowProgress, Get_ShowProgress, Set_ShowProgress);
%attribute(classic_interface, bool, ShowTagNumber, Get_ShowTagNumber, Set_ShowTagNumber);
%attribute(classic_interface, int, SKNOError, Get_SKNOError, Set_SKNOError);
%attributestring(classic_interface, std::string, SKNOIdentifier, Get_SKNOIdentifier, Set_SKNOIdentifier);
%attribute(classic_interface, int, SKNOStatus, Get_SKNOStatus, Set_SKNOStatus);
%attribute(classic_interface, bool, SlipDocumentIsMoving, Get_SlipDocumentIsMoving);
%attribute(classic_interface, bool, SlipDocumentIsPresent, Get_SlipDocumentIsPresent);
%attribute(classic_interface, int, SlipDocumentLength, Get_SlipDocumentLength, Set_SlipDocumentLength);
%attribute(classic_interface, int, SlipDocumentWidth, Get_SlipDocumentWidth, Set_SlipDocumentWidth);
%attribute(classic_interface, int, SlipEqualStringIntervals, Get_SlipEqualStringIntervals, Set_SlipEqualStringIntervals);
%attribute(classic_interface, int, SlipStringInterval, Get_SlipStringInterval, Set_SlipStringInterval);
%attributestring(classic_interface, std::string, SlipStringIntervals, Get_SlipStringIntervals, Set_SlipStringIntervals);
%attributestring(classic_interface, std::string, StringForPrinting, Get_StringForPrinting, Set_StringForPrinting);
%attribute(classic_interface, int, StringNumber, Get_StringNumber, Set_StringNumber);
%attribute(classic_interface, int, StringQuantity, Get_StringQuantity, Set_StringQuantity);
%attribute(classic_interface, int, StringQuantityInOperation, Get_StringQuantityInOperation, Set_StringQuantityInOperation);
%attribute(classic_interface, int, SubTotalFont, Get_SubTotalFont, Set_SubTotalFont);
%attribute(classic_interface, int, SubTotalOffset, Get_SubTotalOffset, Set_SubTotalOffset);
%attribute(classic_interface, int, SubTotalStringNumber, Get_SubTotalStringNumber, Set_SubTotalStringNumber);
%attribute(classic_interface, int, SubTotalSumFont, Get_SubTotalSumFont, Set_SubTotalSumFont);
%attribute(classic_interface, int, SubTotalSumOffset, Get_SubTotalSumOffset, Set_SubTotalSumOffset);
%attribute(classic_interface, int, SubTotalSymbolNumber, Get_SubTotalSymbolNumber, Set_SubTotalSymbolNumber);
%attribute(classic_interface, int64_t, Summ1, Get_Summ1, Set_Summ1);
%attribute(classic_interface, int, Summ1Font, Get_Summ1Font, Set_Summ1Font);
%attribute(classic_interface, int, Summ1NameFont, Get_Summ1NameFont, Set_Summ1NameFont);
%attribute(classic_interface, int, Summ1NameOffset, Get_Summ1NameOffset, Set_Summ1NameOffset);
%attribute(classic_interface, int, Summ1Offset, Get_Summ1Offset, Set_Summ1Offset);
%attribute(classic_interface, int, Summ1StringNumber, Get_Summ1StringNumber, Set_Summ1StringNumber);
%attribute(classic_interface, int, Summ1SymbolNumber, Get_Summ1SymbolNumber, Set_Summ1SymbolNumber);
%attribute(classic_interface, int64_t, Summ2, Get_Summ2, Set_Summ2);
%attribute(classic_interface, int, Summ2Font, Get_Summ2Font, Set_Summ2Font);
%attribute(classic_interface, int, Summ2NameFont, Get_Summ2NameFont, Set_Summ2NameFont);
%attribute(classic_interface, int, Summ2NameOffset, Get_Summ2NameOffset, Set_Summ2NameOffset);
%attribute(classic_interface, int, Summ2Offset, Get_Summ2Offset, Set_Summ2Offset);
%attribute(classic_interface, int, Summ2StringNumber, Get_Summ2StringNumber, Set_Summ2StringNumber);
%attribute(classic_interface, int, Summ2SymbolNumber, Get_Summ2SymbolNumber, Set_Summ2SymbolNumber);
%attribute(classic_interface, int64_t, Summ3, Get_Summ3, Set_Summ3);
%attribute(classic_interface, int, Summ3Font, Get_Summ3Font, Set_Summ3Font);
%attribute(classic_interface, int, Summ3NameFont, Get_Summ3NameFont, Set_Summ3NameFont);
%attribute(classic_interface, int, Summ3NameOffset, Get_Summ3NameOffset, Set_Summ3NameOffset);
%attribute(classic_interface, int, Summ3Offset, Get_Summ3Offset, Set_Summ3Offset);
%attribute(classic_interface, int, Summ3StringNumber, Get_Summ3StringNumber, Set_Summ3StringNumber);
%attribute(classic_interface, int, Summ3SymbolNumber, Get_Summ3SymbolNumber, Set_Summ3SymbolNumber);
%attribute(classic_interface, int64_t, Summ4, Get_Summ4, Set_Summ4);
%attribute(classic_interface, int, Summ4Font, Get_Summ4Font, Set_Summ4Font);
%attribute(classic_interface, int, Summ4NameFont, Get_Summ4NameFont, Set_Summ4NameFont);
%attribute(classic_interface, int, Summ4NameOffset, Get_Summ4NameOffset, Set_Summ4NameOffset);
%attribute(classic_interface, int, Summ4Offset, Get_Summ4Offset, Set_Summ4Offset);
%attribute(classic_interface, int, Summ4StringNumber, Get_Summ4StringNumber, Set_Summ4StringNumber);
%attribute(classic_interface, int, Summ4SymbolNumber, Get_Summ4SymbolNumber, Set_Summ4SymbolNumber);
%attribute(classic_interface, int64_t, Summ5, Get_Summ5, Set_Summ5);
%attribute(classic_interface, int64_t, Summ6, Get_Summ6, Set_Summ6);
%attribute(classic_interface, int64_t, Summ7, Get_Summ7, Set_Summ7);
%attribute(classic_interface, int64_t, Summ8, Get_Summ8, Set_Summ8);
%attribute(classic_interface, int64_t, Summ9, Get_Summ9, Set_Summ9);
%attribute(classic_interface, int64_t, Summ10, Get_Summ10, Set_Summ10);
%attribute(classic_interface, int64_t, Summ11, Get_Summ11, Set_Summ11);
%attribute(classic_interface, int64_t, Summ12, Get_Summ12, Set_Summ12);
%attribute(classic_interface, int64_t, Summ13, Get_Summ13, Set_Summ13);
%attribute(classic_interface, int64_t, Summ14, Get_Summ14, Set_Summ14);
%attribute(classic_interface, int64_t, Summ15, Get_Summ15, Set_Summ15);
%attribute(classic_interface, int64_t, Summ16, Get_Summ16, Set_Summ16);
%attribute(classic_interface, int, SummFont, Get_SummFont, Set_SummFont);
%attribute(classic_interface, int, SummOffset, Get_SummOffset, Set_SummOffset);
%attribute(classic_interface, int, SummStringNumber, Get_SummStringNumber, Set_SummStringNumber);
%attribute(classic_interface, int, SummSymbolNumber, Get_SummSymbolNumber, Set_SummSymbolNumber);
%attribute(classic_interface, int, SwapBytesMode, Get_SwapBytesMode, Set_SwapBytesMode);
%attribute(classic_interface, int, SyncTimeout, Get_SyncTimeout, Set_SyncTimeout);
%attribute(classic_interface, int, SysAdminPassword, Get_SysAdminPassword, Set_SysAdminPassword);
%attributestring(classic_interface, std::string, TableName, Get_TableName);
%attribute(classic_interface, int, TableNumber, Get_TableNumber, Set_TableNumber);
%attributestring(classic_interface, std::string, TagDescription, Get_TagDescription, Set_TagDescription);
%attribute(classic_interface, int, TagID, Get_TagID, Set_TagID);
%attribute(classic_interface, int, TagType, Get_TagType, Set_TagType);
%attribute(classic_interface, int, TagNumber, Get_TagNumber, Set_TagNumber);
%attributestring(classic_interface, std::string, TagValueBin, Get_TagValueBin, Set_TagValueBin);
%attribute(classic_interface, std::time_t, TagValueDateTime, Get_TagValueDateTime, Set_TagValueDateTime);
%attribute(classic_interface, int64_t, TagValueFVLN, Get_TagValueFVLN, Set_TagValueFVLN);
%attribute(classic_interface, int, TagValueLength, Get_TagValueLength, Set_TagValueLength);
%attribute(classic_interface, int, TagValueInt, Get_TagValueInt, Set_TagValueInt);
%attributestring(classic_interface, std::string, TagValueStr, Get_TagValueStr, Set_TagValueStr);
%attribute(classic_interface, int64_t, TaxValue1, Get_TaxValue1, Set_TaxValue1);
%attribute(classic_interface, int64_t, TaxValue2, Get_TaxValue2, Set_TaxValue2);
%attribute(classic_interface, int64_t, TaxValue3, Get_TaxValue3, Set_TaxValue3);
%attribute(classic_interface, int64_t, TaxValue4, Get_TaxValue4, Set_TaxValue4);
%attribute(classic_interface, int64_t, TaxValue5, Get_TaxValue5, Set_TaxValue5);
%attribute(classic_interface, int64_t, TaxValue6, Get_TaxValue6, Set_TaxValue6);
%attribute(classic_interface, int, TaxValue1Enabled, Get_TaxValue1Enabled, Set_TaxValue1Enabled);
%attribute(classic_interface, int, Tax1, Get_Tax1, Set_Tax1);
%attribute(classic_interface, int, Tax1NameFont, Get_Tax1NameFont, Set_Tax1NameFont);
%attribute(classic_interface, int, Tax1NameOffset, Get_Tax1NameOffset, Set_Tax1NameOffset);
%attribute(classic_interface, int, Tax1NameSymbolNumber, Get_Tax1NameSymbolNumber, Set_Tax1NameSymbolNumber);
%attribute(classic_interface, int, Tax1RateFont, Get_Tax1RateFont, Set_Tax1RateFont);
%attribute(classic_interface, int, Tax1RateOffset, Get_Tax1RateOffset, Set_Tax1RateOffset);
%attribute(classic_interface, int, Tax1RateSymbolNumber, Get_Tax1RateSymbolNumber, Set_Tax1RateSymbolNumber);
%attribute(classic_interface, int, Tax1SumFont, Get_Tax1SumFont, Set_Tax1SumFont);
%attribute(classic_interface, int, Tax1SumOffset, Get_Tax1SumOffset, Set_Tax1SumOffset);
%attribute(classic_interface, int, Tax1SumStringNumber, Get_Tax1SumStringNumber, Set_Tax1SumStringNumber);
%attribute(classic_interface, int, Tax1SumSymbolNumber, Get_Tax1SumSymbolNumber, Set_Tax1SumSymbolNumber);
%attribute(classic_interface, int, Tax1TurnOverOffset, Get_Tax1TurnOverOffset, Set_Tax1TurnOverOffset);
%attribute(classic_interface, int, Tax1TurnOverStringNumber, Get_Tax1TurnOverStringNumber, Set_Tax1TurnOverStringNumber);
%attribute(classic_interface, int, Tax2, Get_Tax2, Set_Tax2);
%attribute(classic_interface, int, Tax2NameFont, Get_Tax2NameFont, Set_Tax2NameFont);
%attribute(classic_interface, int, Tax2NameOffset, Get_Tax2NameOffset, Set_Tax2NameOffset);
%attribute(classic_interface, int, Tax2NameSymbolNumber, Get_Tax2NameSymbolNumber, Set_Tax2NameSymbolNumber);
%attribute(classic_interface, int, Tax2RateFont, Get_Tax2RateFont, Set_Tax2RateFont);
%attribute(classic_interface, int, Tax2RateOffset, Get_Tax2RateOffset, Set_Tax2RateOffset);
%attribute(classic_interface, int, Tax2RateSymbolNumber, Get_Tax2RateSymbolNumber, Set_Tax2RateSymbolNumber);
%attribute(classic_interface, int, Tax2SumFont, Get_Tax2SumFont, Set_Tax2SumFont);
%attribute(classic_interface, int, Tax2SumOffset, Get_Tax2SumOffset, Set_Tax2SumOffset);
%attribute(classic_interface, int, Tax2SumStringNumber, Get_Tax2SumStringNumber, Set_Tax2SumStringNumber);
%attribute(classic_interface, int, Tax2SumSymbolNumber, Get_Tax2SumSymbolNumber, Set_Tax2SumSymbolNumber);
%attribute(classic_interface, int, Tax2TurnOverOffset, Get_Tax2TurnOverOffset, Set_Tax2TurnOverOffset);
%attribute(classic_interface, int, Tax2TurnOverOffset, Get_Tax2TurnOverOffset, Set_Tax2TurnOverOffset);
%attribute(classic_interface, int, Tax2TurnOverStringNumber, Get_Tax2TurnOverStringNumber, Set_Tax2TurnOverStringNumber);
%attribute(classic_interface, int, Tax2TurnOverSymbolNumber, Get_Tax2TurnOverSymbolNumber, Set_Tax2TurnOverSymbolNumber);
%attribute(classic_interface, int, Tax3, Get_Tax3, Set_Tax3);
%attribute(classic_interface, int, Tax3NameFont, Get_Tax3NameFont, Set_Tax3NameFont);
%attribute(classic_interface, int, Tax3NameOffset, Get_Tax3NameOffset, Set_Tax3NameOffset);
%attribute(classic_interface, int, Tax3NameSymbolNumber, Get_Tax3NameSymbolNumber, Set_Tax3NameSymbolNumber);
%attribute(classic_interface, int, Tax3RateFont, Get_Tax3RateFont, Set_Tax3RateFont);
%attribute(classic_interface, int, Tax3RateOffset, Get_Tax3RateOffset, Set_Tax3RateOffset);
%attribute(classic_interface, int, Tax3RateSymbolNumber, Get_Tax3RateSymbolNumber, Set_Tax3RateSymbolNumber);
%attribute(classic_interface, int, Tax3SumFont, Get_Tax3SumFont, Set_Tax3SumFont);
%attribute(classic_interface, int, Tax3SumOffset, Get_Tax3SumOffset, Set_Tax3SumOffset);
%attribute(classic_interface, int, Tax3SumStringNumber, Get_Tax3SumStringNumber, Set_Tax3SumStringNumber);
%attribute(classic_interface, int, Tax3SumSymbolNumber, Get_Tax3SumSymbolNumber, Set_Tax3SumSymbolNumber);
%attribute(classic_interface, int, Tax3TurnOverOffset, Get_Tax3TurnOverOffset, Set_Tax3TurnOverOffset);
%attribute(classic_interface, int, Tax3TurnOverOffset, Get_Tax3TurnOverOffset, Set_Tax3TurnOverOffset);
%attribute(classic_interface, int, Tax3TurnOverStringNumber, Get_Tax3TurnOverStringNumber, Set_Tax3TurnOverStringNumber);
%attribute(classic_interface, int, Tax3TurnOverSymbolNumber, Get_Tax3TurnOverSymbolNumber, Set_Tax3TurnOverSymbolNumber);
%attribute(classic_interface, int, Tax4, Get_Tax4, Set_Tax4);
%attribute(classic_interface, int, Tax4NameFont, Get_Tax4NameFont, Set_Tax4NameFont);
%attribute(classic_interface, int, Tax4NameOffset, Get_Tax4NameOffset, Set_Tax4NameOffset);
%attribute(classic_interface, int, Tax4NameSymbolNumber, Get_Tax4NameSymbolNumber, Set_Tax4NameSymbolNumber);
%attribute(classic_interface, int, Tax4RateFont, Get_Tax4RateFont, Set_Tax4RateFont);
%attribute(classic_interface, int, Tax4RateOffset, Get_Tax4RateOffset, Set_Tax4RateOffset);
%attribute(classic_interface, int, Tax4RateSymbolNumber, Get_Tax4RateSymbolNumber, Set_Tax4RateSymbolNumber);
%attribute(classic_interface, int, Tax4SumFont, Get_Tax4SumFont, Set_Tax4SumFont);
%attribute(classic_interface, int, Tax4SumOffset, Get_Tax4SumOffset, Set_Tax4SumOffset);
%attribute(classic_interface, int, Tax4SumStringNumber, Get_Tax4SumStringNumber, Set_Tax4SumStringNumber);
%attribute(classic_interface, int, Tax4SumSymbolNumber, Get_Tax4SumSymbolNumber, Set_Tax4SumSymbolNumber);
%attribute(classic_interface, int, Tax4TurnOverOffset, Get_Tax4TurnOverOffset, Set_Tax4TurnOverOffset);
%attribute(classic_interface, int, Tax4TurnOverOffset, Get_Tax4TurnOverOffset, Set_Tax4TurnOverOffset);
%attribute(classic_interface, int, Tax4TurnOverStringNumber, Get_Tax4TurnOverStringNumber, Set_Tax4TurnOverStringNumber);
%attribute(classic_interface, int, Tax4TurnOverSymbolNumber, Get_Tax4TurnOverSymbolNumber, Set_Tax4TurnOverSymbolNumber);
%attribute(classic_interface, int, TaxType, Get_TaxType, Set_TaxType);
%attribute(classic_interface, int, TCPConnectionTimeout, Get_TCPConnectionTimeout, Set_TCPConnectionTimeout);
%attribute(classic_interface, int, TCPPort, Get_TCPPort, Set_TCPPort);
%attributestring(classic_interface, std::string, TextBlock, Get_TextBlock, Set_TextBlock);
%attribute(classic_interface, int, TextBlockNumber, Get_TextBlockNumber, Set_TextBlockNumber);
%attribute(classic_interface, int, TextFont, Get_TextFont, Set_TextFont);
%attribute(classic_interface, int, TextOffset, Get_TextOffset, Set_TextOffset);
%attribute(classic_interface, int, TextStringNumber, Get_TextStringNumber, Set_TextStringNumber);
%attribute(classic_interface, int, TextSymbolNumber, Get_TextSymbolNumber, Set_TextSymbolNumber);
%attribute(classic_interface, std::time_t, Time, Get_Time, Set_Time);
%attribute(classic_interface, std::time_t, Time2, Get_Time2, Set_Time2);
%attribute(classic_interface, int, Timeout, Get_Timeout, Set_Timeout);
%attribute(classic_interface, int, TimeoutsUsing, Get_TimeoutsUsing, Set_TimeoutsUsing);
%attributestring(classic_interface, std::string, TimeStr, Get_TimeStr, Set_TimeStr);
%attributeval(classic_interface, std::vector<uint8_t>, TLVData, Get_TLVData, Set_TLVData);
%attributestring(classic_interface, std::string, TLVDataHex, Get_TLVDataHex, Set_TLVDataHex);
%attributestring(classic_interface, std::string, Token, Get_Token, Set_Token);
%attribute(classic_interface, int, TotalFont, Get_TotalFont, Set_TotalFont);
%attribute(classic_interface, int, TotalOffset, Get_TotalOffset, Set_TotalOffset);
%attribute(classic_interface, int, TotalStringNumber, Get_TotalStringNumber, Set_TotalStringNumber);
%attribute(classic_interface, int, TotalSumFont, Get_TotalSumFont, Set_TotalSumFont);
%attribute(classic_interface, int, TotalSumOffset, Get_TotalSumOffset, Set_TotalSumOffset);
%attribute(classic_interface, int, TotalSymbolNumber, Get_TotalSymbolNumber, Set_TotalSymbolNumber);
%attributestring(classic_interface, std::string, TransferBytes, Get_TransferBytes, Set_TransferBytes);
%attribute(classic_interface, bool, TranslationEnabled, Get_TranslationEnabled, Set_TranslationEnabled);
%attribute(classic_interface, int, TransmitDocumentNumber, Get_TransmitDocumentNumber);
%attribute(classic_interface, int, TransmitQueueSize, Get_TransmitQueueSize);
%attribute(classic_interface, int, TransmitSessionNumber, Get_TransmitSessionNumber);
%attribute(classic_interface, int, TransmitStatus, Get_TransmitStatus);
%attribute(classic_interface, bool, TypeOfLastEntryFM, Get_TypeOfLastEntryFM);
%attribute(classic_interface, int, TypeOfLastEntryFMEx, Get_TypeOfLastEntryFMEx);
%attribute(classic_interface, bool, TypeOfSumOfEntriesFM, Get_TypeOfSumOfEntriesFM, Set_TypeOfSumOfEntriesFM);
%attribute(classic_interface, int, UCodePage, Get_UCodePage);
%attributestring(classic_interface, std::string, UCodePageText, Get_UCodePageText);
%attributestring(classic_interface, std::string, UDescription, Get_UDescription);
%attribute(classic_interface, int, UMajorProtocolVersion, Get_UMajorProtocolVersion);
%attribute(classic_interface, int, UMajorType, Get_UMajorType);
%attribute(classic_interface, int, UMinorProtocolVersion, Get_UMinorProtocolVersion);
%attribute(classic_interface, int, UMinorType, Get_UMinorType);
%attribute(classic_interface, int, UModel, Get_UModel);
%attributestring(classic_interface, std::string, URL, Get_URL, Set_URL);
%attribute(classic_interface, bool, UseCommandTimeout, Get_UseCommandTimeout, Set_UseCommandTimeout);
%attribute(classic_interface, bool, UseIPAddress, Get_UseIPAddress, Set_UseIPAddress);
%attribute(classic_interface, bool, UseJournalRibbon, Get_UseJournalRibbon, Set_UseJournalRibbon);
%attribute(classic_interface, bool, UseReceiptRibbon, Get_UseReceiptRibbon, Set_UseReceiptRibbon);
%attribute(classic_interface, bool, UseSlipCheck, Get_UseSlipCheck, Set_UseSlipCheck);
%attribute(classic_interface, bool, UseSlipDocument, Get_UseSlipDocument, Set_UseSlipDocument);
%attribute(classic_interface, bool, UseTaxDiscountBel, Get_UseTaxDiscountBel, Set_UseTaxDiscountBel);
%attribute(classic_interface, bool, UseWareCode, Get_UseWareCode, Set_UseWareCode);
%attribute(classic_interface, int, ValueOfFieldInteger, Get_ValueOfFieldInteger, Set_ValueOfFieldInteger);
%attributestring(classic_interface, std::string, ValueOfFieldString, Get_ValueOfFieldString, Set_ValueOfFieldString);
%attribute(classic_interface, int, VertScale, Get_VertScale, Set_VertScale);
%attribute(classic_interface, int, WaitForPrintingDelay, Get_WaitForPrintingDelay, Set_WaitForPrintingDelay);
%attribute(classic_interface, int, WareCode, Get_WareCode, Set_WareCode);
%attribute(classic_interface, bool, SkipPrint, Get_SkipPrint, Set_SkipPrint);
%attributestring(classic_interface, std::string, DigitalSign, Get_DigitalSign, Set_DigitalSign);
%attribute(classic_interface, int, DeviceFunctionNumber, Get_DeviceFunctionNumber, Set_DeviceFunctionNumber);
%attribute(classic_interface, int, ValueOfFunctionInteger, Get_ValueOfFunctionInteger, Set_ValueOfFunctionInteger);
%attributestring(classic_interface, std::string, ValueOfFunctionString, Get_ValueOfFunctionString, Set_ValueOfFunctionString);
%attribute(classic_interface, bool, EnableCashcoreMarkCompatibility, Get_EnableCashcoreMarkCompatibility, Set_EnableCashcoreMarkCompatibility);
%attribute(classic_interface, int, MarkingType, Get_MarkingType, Set_MarkingType);
%attribute(classic_interface, int, MarkingTypeEx, Get_MarkingTypeEx, Set_MarkingTypeEx);
%attribute(classic_interface, int, DataBlockSize, Get_DataBlockSize, Set_DataBlockSize);
%attribute(classic_interface, int64_t, MessageNumber, Get_MessageNumber, Set_MessageNumber);
%attribute(classic_interface, int, CheckItemLocalError, Get_CheckItemLocalError, Set_CheckItemLocalError);
%attribute(classic_interface, int, MeasureUnit, Get_MeasureUnit, Set_MeasureUnit);
%attribute(classic_interface, bool, DivisionalQuantity, Get_DivisionalQuantity, Set_DivisionalQuantity);
%attribute(classic_interface, uint64_t, Numerator, Get_Numerator, Set_Numerator);
%attribute(classic_interface, uint64_t, Denominator, Get_Denominator, Set_Denominator);
%attribute(classic_interface, int, FreeMemorySize, Get_FreeMemorySize, Set_FreeMemorySize);
%attribute(classic_interface, int, MCCheckStatus, Get_MCCheckStatus, Set_MCCheckStatus);
%attribute(classic_interface, int, MCNotificationStatus, Get_MCNotificationStatus, Set_MCNotificationStatus);
%attribute(classic_interface, int, MCCommandFlags, Get_MCCommandFlags, Set_MCCommandFlags);
%attribute(classic_interface, int, MCCheckResultSavedCount, Get_MCCheckResultSavedCount, Set_MCCheckResultSavedCount);
%attribute(classic_interface, int, MCRealizationCount, Get_MCRealizationCount, Set_MCRealizationCount);
%attribute(classic_interface, int, MCStorageSize, Get_MCStorageSize, Set_MCStorageSize);
%attribute(classic_interface, uint64_t, CheckSum, Get_CheckSum, Set_CheckSum);
%attribute(classic_interface, int, NotificationCount, Get_NotificationCount, Set_NotificationCount);
%attribute(classic_interface, int64_t, NotificationNumber, Get_NotificationNumber, Set_NotificationNumber);
%attribute(classic_interface, int, NotificationSize, Get_NotificationSize, Set_NotificationSize);
%attribute(classic_interface, int, DataOffset, Get_DataOffset, Set_DataOffset);
%attribute(classic_interface, int, MarkingType2, Get_MarkingType2, Set_MarkingType2);
%attributeval(classic_interface, std::vector<uint8_t>, RandomSequence, Get_RandomSequence, Set_RandomSequence);
%attributestring(classic_interface, std::string, RandomSequenceHex, Get_RandomSequenceHex, Set_RandomSequenceHex);
%attributeval(classic_interface, std::vector<uint8_t>, AuthData, Get_AuthData, Set_AuthData);
%attribute(classic_interface, int, ItemStatus, Get_ItemStatus, Set_ItemStatus);
%attribute(classic_interface, int, CheckItemMode, Get_CheckItemMode, Set_CheckItemMode);
%attribute(classic_interface, int, CheckItemLocalResult, Get_CheckItemLocalResult, Set_CheckItemLocalResult);
%attribute(classic_interface, int, KMServerErrorCode, Get_KMServerErrorCode, Set_KMServerErrorCode);
%attribute(classic_interface, int, KMServerCheckingStatus, Get_KMServerCheckingStatus, Set_KMServerCheckingStatus);
%attributestring(classic_interface, std::string, LoaderVersion, Get_LoaderVersion);
%attribute(classic_interface, int, LastDocumentNumber, Get_LastDocumentNumber, Set_LastDocumentNumber);
%attribute(classic_interface, int, FirstDocumentNumber, Get_FirstDocumentNumber, Set_FirstDocumentNumber);
%attribute(classic_interface, int, FNArchiveType, Get_FNArchiveType, Set_FNArchiveType);
%attribute(classic_interface, bool, MarkingOnly, Get_MarkingOnly, Set_MarkingOnly);
%attributestring(classic_interface, std::string, FontHashHex, Get_FontHashHex);
%attributestring(classic_interface, std::string, DataBlockHex, Get_DataBlockHex);
%attributestring(classic_interface, std::string, DeclarativeEndpointPath, Get_DeclarativeEndpointPath, Set_DeclarativeEndpointPath);
%attributestring(classic_interface, std::string, DeclarativeOutput, Get_DeclarativeOutput, Set_DeclarativeOutput);
%attributestring(classic_interface, std::string, DeclarativeInput, Get_DeclarativeInput, Set_DeclarativeInput);
%attribute(classic_interface, int64_t, WaitForPrintingTimeout, Get_WaitForPrintingTimeout, Set_WaitForPrintingTimeout);
%attributestring(classic_interface, std::string, UserAttributeValue, Get_UserAttributeValue, Set_UserAttributeValue);
%attributestring(classic_interface, std::string, UserAttributeName, Get_UserAttributeName, Set_UserAttributeName);

#endif //SWIGPYTHON

%include <classic_interface.h>
