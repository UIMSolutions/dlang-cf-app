import vibe.http.server;
import vibe.http.router;
import vibe.core.core : runApplication;
import std.process : environment;
import std.conv : to;

void handleRequest(HTTPServerRequest req, HTTPServerResponse res)
{
    res.writeBody("Hallo Dlang on SAP BTP Cloud Foundry!", "text/plain; charset=UTF-8");
}

void handleRequestOzan  (HTTPServerRequest req, HTTPServerResponse res)
{
    res.writeBody("Hallo Ozan!", "text/plain; charset=UTF-8");
}

void main()
{
    auto settings = new HTTPServerSettings;
    
    // Cloud Foundry Port dynamisch auslesen
    ushort port = environment.get("PORT", "8080").to!ushort;
    settings.port = port;
    settings.bindAddresses = ["0.0.0.0"];

    auto router = new URLRouter;
    router.get("/", &handleRequest);
    router.get("/ozan", &handleRequestOzan);

    listenHTTP(settings, router);
    runApplication();
}
