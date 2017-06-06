package Passtrough;

import ballerina.lang.messages;
import ballerina.net.http;

@http:BasePath{value:"/passthrough"} 
service SoapPassthroughService {
    
	@http:POST{}
    @http:Path {value:"/"} 
	resource PassthroughXml( message m) {
		xml incomingPayload = messages:getXmlPayload(m);
		http:ClientConnector stockEP = create http:ClientConnector("http://localhost:9000/services/SimpleStockQuoteService");
		messages:setXmlPayload(m, incomingPayload);
		messages:removeHeader(m, "Content-Type");
		messages:addHeader(m, "Content-Type", "text/xml;charset=UTF-8");
		message reponse = http:ClientConnector.post(stockEP, "", m);
		reply reponse;
		
	}
	
}



