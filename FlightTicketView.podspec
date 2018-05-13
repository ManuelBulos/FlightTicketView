Pod::Spec.new do |s|
s.name              = 'FlightTicketView'
s.version           = '1.0.0'
s.summary           = 'A simple library for Swift that makes UITableView resemble a flight ticket.'
s.homepage          = 'https://github.com/ManuelBulos/FlightTicket'

s.author            = { 'Manuel Bulos' => 'manuelbulos@gmail.com' }
s.license           = { :type => 'MIT', :file => 'LICENSE.md' }

s.platform          = :ios
s.source            = { :git => 'https://github.com/ManuelBulos/FlightTicket.git', :tag => '1.0.0' }

s.ios.deployment_target = '11.3'
s.source_files  = "FlightTicketView/*"
s.ios.framework = 'UIKit'
s.swift_version = '4.1'

end

