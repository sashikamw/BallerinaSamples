 import ballerina.lang.messages;
import ballerina.net.http;

@http:BasePath{value:"/passthroughxml"} 
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


@http:BasePath{value:"/passthroughjson"} 
service JsonPassthrough {
	@http:GET {} 
	resource passthroughJson( message m) {
		http:ClientConnector nyseEP = create http:ClientConnector("http://localhost:9090");
		message response = http:ClientConnector.get(nyseEP, "/nyseStock", m);
		reply response;
		
	}
	
}

@http:BasePath{value:"/nyseStock"} 
service nyseStockQuote {
	@http:GET {} 
	resource stocks( message m) {
		json payload = ` {
			"exchange":"nyse", "name":"IBM", "value":"127.50"
		}
		`;
		message response = {};
		messages:setJsonPayload(response, payload);
		reply response;
		
	}
	
}
