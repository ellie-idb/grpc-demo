
protos:
	python -m grpc_tools.protoc -I. --python_out=py --grpc_python_out=py ./helloworld.proto
	protoc --dart_out=grpc:dart -I. ./helloworld.proto
	protoc --plugin=protoc-gen-grpc=$(HOME)/project/contrib/grpc-d-compiler/protoc-gen-grpc-d helloworld.proto --grpc_out=./source  # --d_opt=message-as-struct

setup:
	sudo apt install libgrpc-dev
	dart pub global activate protoc_plugin
	export PATH="$PATH:$HOME/.pub-cache/bin"

