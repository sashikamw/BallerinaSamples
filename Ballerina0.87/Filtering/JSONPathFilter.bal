package Filtering;

import ballerina.net.http;
import ballerina.lang.jsons;
import ballerina.lang.messages;

@http:BasePath {value:"/jsonpathfilter"}
service JSONPathFilter {
    
    @http:POST{}
    resource JSONPathResource (message m) {
        http:ClientConnector nyseEP = create http:ClientConnector("http://localhost:9090/nyseStocks");
        string nyseString = "nyse";
        json jsonMsg = messages:getJsonPayload(m);
        string nameString = jsons:getString(jsonMsg, "$.name");
        message response = {};
        
        // If name is 'nyse' then message routed to the backend, if not message discarded
        if (nameString == nyseString) {
            response = http:ClientConnector.post(nyseEP, "/", m);
            
        }
        reply response;
        
    }
    
}
