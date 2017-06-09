##### **Description**
Sample scenarios related to message filtering / routing based on following criteria;
1. based on the JSONPath - JSONPathFilter.bal
2. based on the XPath - XPathFilter.bal
3. based on a key word - KeyworkFilter.bal
4. based on any of the maching xpath criteria - AnyMatchingXPathFilter.bal

##### **How to run this sample**

Download the ballerina0.87 samples and go to "Ballerina0.87" directory. Then execute "<Ballerina_HOME>/bin/ballerina run service Filtering/"


##### **Invoking the services**

###### **Service 01** - JSONPathFilter.bal
If name is "nyse" then message goes to the BE, else message dropped
> _Request_ - http://localhost:9090/jsonpathfilter 
_Payload_ - {"name" : "nyse"}

###### **Service 02** - XPathFilter.bal
If symbol is "IBM" then message goes to the BE, else message dropped

> _Request_ - http://localhost:9090/xpathfilter 
_Header_ - SOAPAction:urn:getQuote , Content-Type:text/xml;charset=UTF-8
_Payload_ - 

> <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:getQuote>
         <!--Optional:-->
         <ser:request>
            <!--Optional:-->
            <xsd:symbol>IBM</xsd:symbol>
         </ser:request>
      </ser:getQuote>
   </soapenv:Body>
</soapenv:Envelope>

###### **Service 03** - KeyworkFilter.bal
3.1) If the symbol contains "_IBM_" then message goes to the BE, else message dropped
3.2) If the prefix of the symbol contains '_IB_' then message goes to the BE, else message dropped
3.3) If the suffix of the symbol contains '_BM_' then message goes to the BE, else message dropped
> _Request_ - (3.1) http://localhost:9090/keyworkbasedfilter (3.2) http://localhost:9090/prefixbasedfilter (3.3) http://localhost:9090/suffixbasedfilter
_Header_ - SOAPAction:urn:getQuote , Content-Type:text/xml;charset=UTF-8


> _Payload_ - 
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:getQuote>
         <!--Optional:-->
         <ser:request>
            <!--Optional:-->
            <xsd:symbol>IBM</xsd:symbol>
         </ser:request>
      </ser:getQuote>
   </soapenv:Body>
</soapenv:Envelope> 

###### **Service 04** - AnyMatchingXPathFilter.bal
If 'ID' of the given xml equals to '990' then message processed, else message dropped
> _Request_ - http://localhost:9090/anymatchingxpathfiltertest 



> _Payload_ - 
```
(1) 
<EmployeePersonalDetails>
<ID>990</ID>
<Name>Peter</Name>
<Age>27</Age>
<City>Colombo</City>
</EmployeePersonalDetails>
(2) 
<EmployeeDepartmentInfo>
<ID>990</ID>
<Team>EI</Team>
<SubTeam>EE</SubTeam>
</EmployeeDepartmentInfo>```
