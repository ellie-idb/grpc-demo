module app;
import grpc.core;
import core.thread;
import grpc.server;
import grpc.server.builder;
import helloworld.helloworld;
import google.rpc.status;

Server server;

extern(C) void handler(int num) nothrow @nogc @system
{
    server.run_ = false;
}

class HelloWorldServer : Greeter {
    private {
        int count;
    }

    Status SayHello(HelloRequest req, ref HelloReply reply) {
        import std.conv : to;
        count++;
        Status t;
        reply.message = "You are lucky visitor number #" ~ to!string(count) ~ " today!";
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

    grpc.core.init();
    scope(exit) { grpc.core.shutdown(); }

    ServerBuilder builder = new ServerBuilder();

    builder.port = 50051;

    server = builder.build();
    builder.register!(HelloWorldServer)();

    server.finish();

    server.run();
    
    server.wait();
}
