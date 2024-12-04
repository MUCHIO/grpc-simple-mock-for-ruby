require 'grpc'
require_relative 'lib/auto_generated/grpc/route_guide_pb.rb'
require_relative 'lib/auto_generated/grpc/route_guide_services_pb.rb'

class RouteGuideImpl < Routeguide::RouteGuide::Service
  def get_feature(request, _)
    puts request
    Routeguide::Feature.new(name: "Dummy feature", location: request)
  end

  def list_features(request, _)
    puts request
    [Routeguide::Feature.new(name: "Dummy feature", location: Routeguide::Point.new(latitude: 123456, longitude: 654321))]
  end
  
  def record_route(call)
    call.each_remote_read do |point| puts point end
    Routeguide::RouteSummary.new(point_count: 1, feature_count: 1, distance: 100, elapsed_time: 1234)
  end
  
  def route_chat(call)
    call.each_entry do |note| puts note end
    [Routeguide::RouteNote.new(message: "Dummy message", location: Routeguide::Point.new(latitude: 0, longitude: 0))]
  end
end

server = GRPC::RpcServer.new
server.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
server.handle(RouteGuideImpl.new)
server.run_till_terminated