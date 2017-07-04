test_folder = File.dirname(File.expand_path(__FILE__))

Dir.glob(File.join(test_folder, '*_test.rb')).each do |file|
  load file
end