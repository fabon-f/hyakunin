class Hyakunin
  def initialize(path)
    require "csv"
    @data = CSV.read(path)
    @order = (0..99).to_a
  end

  def shuffle
    @order.shuffle!
  end

  def play
    loop do
      puts "モードを選択してください", "一回づつ回る:a", "完全ランダム:b", "やめる:c"
      case gets.chomp
      when "a"
        mode_a
      when "b"
        mode_b
      when "c"
        return
      else
        puts "aかbかcか選択してください"
      end
    end
  end

  def mode_a
    shuffle
    puts "確認:a","時間:b"
    loop do
      case gets.chomp
      when "a"
        puts "quit,exit,endで終了"
        @order.each do |n|
          print "#{@data[n][0]} "
          return if /\A(quit|exit|end)\z/ =~ gets.chomp
          print "#{@data[n][1]} "
          return if /\A(quit|exit|end)\z/ =~ gets.chomp
        end
        break
      when "b"
        time = 0.0
        loop do
          puts "0.0秒以上の間隔を設定してください(単位:秒、小数点以下も可)"
          time = gets.chomp.to_f
          break if time != 0.0
        end
        @order.each do |n|
          puts @data[n][0]
          sleep time
          puts @data[n][1]
          sleep time
        end
        break
      else
        puts "aかbか選択してください"
      end
    end
  end

  def mode_b
    puts "quit,exit,endで終了"
    loop do
      question = @data[rand 100]
      print "#{question[0]} "
      return if /\A(quit|exit|end)\z/ =~ gets.chomp
      print "#{question[1]} "
      return if /\A(quit|exit|end)\z/ =~ gets.chomp
    end
  end
end

hyakunin = Hyakunin.new("data.csv")
hyakunin.play