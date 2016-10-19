def greeting
    array = ARGV
    say = array.delete_at(0)
    array.each { |arg| puts "#{say} #{arg}"}
end

greeting