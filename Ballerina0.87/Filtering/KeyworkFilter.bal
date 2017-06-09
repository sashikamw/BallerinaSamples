package Filtering;

import ballerina.net.http;
import ballerina.lang.messages;
import ballerina.lang.xmls;
import ballerina.lang.strings;

@http:BasePath{value: "/keyworkbasedfilter"}
service KeywordFilterService {

    @http:POST{}
    resource KeywordFilterResource(message m) {
        http:ClientConnector stockEP = create http:ClientConnector("http://localhost:9000/services/SimpleStockQuoteService");
        xml incomingPayload = messages:getXmlPayload(m);
        map namespace = {"ser":"http://services.samples","xsd":"http://services.samples/xsd"};
        string stockquote = xmls:getString(incomingPayload, "//ser:getQuote/ser:request/xsd:symbol", namespace);
        string stockexists = strings:contains(stockquote, "IBM");
        message response = {};

        if (stockexists == "true") {
            response = http:ClientConnector.post(stockEP, "/", m);
        } else {
            string errorpayload = "Message do not meet the filter criteria";
            messages:setStringPayload(response, errorpayload);
        }

        reply response;
    }
}

@http:BasePath{value: "/prefixbasedfilter"}
service PrefixFilterService {

    @http:POST{}
    resource PrefixFilterResource(message m) {
        http:ClientConnector stockEP = create http:ClientConnector("http://localhost:9000/services/SimpleStockQuoteService");
        xml incomingPayload = messages:getXmlPayload(m);
        map namespace = {"ser":"http://services.samples","xsd":"http://services.samples/xsd"};
        string stockquote = xmls:getString(incomingPayload, "//ser:getQuote/ser:request/xsd:symbol/text()", namespace);
        string stockexists = strings:hasPrefix(stockquote, "IB");
        message response = {};

        if (stockexists == "true") {
            response = http:ClientConnector.post(stockEP, "/", m);
        } else {
            string errorpayload = "Message do not meet the filter criteria";
            messages:setStringPayload(response, errorpayload);
        }

        reply response;
    }
}

@http:BasePath{value: "/suffixbasedfilter"}
service SuffixFilterService {

    @http:POST{}
    resource SuffixFilterResource(message m) {
        http:ClientConnector stockEP = create http:ClientConnector("http://localhost:9000/services/SimpleStockQuoteService");
        xml incomingPayload = messages:getXmlPayload(m);
        map namespace = {"ser":"http://services.samples","xsd":"http://services.samples/xsd"};
        string stockquote = xmls:getString(incomingPayload, "//ser:getQuote/ser:request/xsd:symbol/text()", namespace);
        string stockexists = strings:hasSuffix(stockquote, "BM");
        message response = {};

        if (stockexists == "true") {
            response = http:ClientConnector.post(stockEP, "/", m);
        } else {
            string errorpayload = "Message do not meet the filter criteria";
            messages:setStringPayload(response, errorpayload);
        }

        reply response;
    }
}
