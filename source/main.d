module app;
import grpc.core;
import core.thread;
import grpc.server;
import grpc.server.builder;
import helloworld.helloworld;
import google.rpc.status;
import core.atomic;
debug import grpc.logger : gLogger, Verbosity;

__gshared Server server;

extern(C) void handler(int num) nothrow @nogc @system
{
    server.shutdown();
}

class HelloWorldServer : Greeter {
    private {
        shared int count;
    }

    Status SayHello(HelloRequest req, ref HelloReply reply) {
        import std.conv : to;
        Status t;
	reply.message = "grpc-d-core: Hello, " ~ req.name;
        return t;
    }

    this() {

    }

    ~this() {

    }
}

import std.stdio;
import core.sys.posix.signal;
void main() {
    signal(SIGINT, &handler);
	
    debug gLogger.minVerbosity = Verbosity.Debug;

    ServerBuilder builder = new ServerBuilder();

    builder.port = 50051;

    server = builder.build();
    builder.register!(HelloWorldServer)(server);

    server.run();
    
    server.wait();
}
