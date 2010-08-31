require 'yaml'

class Scrabbler

  def initialize(list_file)
    @entries = File.read(list_file).split(/\n/).map(&:downcase)
    @people = @entries.dup
  end

  def start
    result = {}
    while !@people.empty? do
      actual = choose_random!(@people)
      result[actual] = choose_random!(@entries, actual)
    end
    r_string = YAML.dump(result).unpack("H*")
    File.open("result.txt", "w") { |f| f.puts(r_string) }
  end

  def choose_random!(from, exclude = nil)
    from.shuffle!(&:rand) while from.first == exclude
    from.shift
  end

  def decrypt(something)
    [ something ].pack("H*")
  end
end

if __FILE__ == $0
  app = Scrabbler.new("people.txt")
  app.start
end
