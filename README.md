# grpc-simple-mock-for-ruby

## Run the mock server
```
bundle install
ruby -I lib/auto_generated/grpc mock_server.rb
```

## Execute the APIs with [grpcurl](https://github.com/fullstorydev/grpcurl)
Need to download proto file. (https://github.com/grpc/grpc/tree/master/examples/protos)
```
# GetFeature
grpcurl -plaintext -import-path path/to/proto/dir -proto route_guide.proto -d '{"latitude": 409146138, "longitude": -746188906}' localhost:50051 routeguide.RouteGuide/GetFeature

# ListFeatures
grpcurl -plaintext -import-path path/to/proto/dir -proto route_guide.proto -d '{"lo": {"latitude": 409146138, "longitude": -746188906}, "hi":{"latitude": 409146138, "longitude": -746188906}}' localhost:50051 routeguide.RouteGuide/ListFeatures

# RecordRoute
grpcurl -plaintext -import-path path/to/proto/dir -proto route_guide.proto -d @ localhost:50051 routeguide.RouteGuide/RecordRoute < request_record_route.json

# RouteChat
grpcurl -plaintext -import-path path/to/proto/dir -proto route_guide.proto -d @ localhost:50051 routeguide.RouteGuide/RouteChat < request_route_chat.json
```