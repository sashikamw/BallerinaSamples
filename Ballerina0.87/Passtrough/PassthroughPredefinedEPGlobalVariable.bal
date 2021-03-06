package Passtrough;

import ballerina.lang.messages;
import ballerina.net.http;

@http:BasePath{value:"/ptpredefinedEPGlobVar"} 
service PassthroughGlobalService {
     
	@http:POST{}
    @http:Path {value:"/"} 
	resource PassthroughXml( message m) {
		xml incomingPayload = messages:getXmlPayload(m);
		http:ClientConnector stockEP = create http:ClientConnector(stockEPurl);
		messages:setXmlPayload(m, incomingPayload);
		messages:removeHeader(m, "Content-Type");
		messages:addHeader(m, "Content-Type", "text/xml;charset=UTF-8");
		message reponse = http:ClientConnector.post(stockEP, "", m);
		reply reponse;
		
	}
	
}

