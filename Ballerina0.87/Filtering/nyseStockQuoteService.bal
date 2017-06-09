package Filtering;

import ballerina.net.http;
import ballerina.lang.messages;

@http:BasePath {value:"/nyseStocks"}
service nyseStockQuote {
    
    @http:POST{}
    resource stocks (message m) {
        message response = {};
        json payload = {"exchange":"nyse", "name":"IBM", "value":"127.50"};
        messages:setJsonPayload(response, payload);
        reply response;
        
    }
    
}
