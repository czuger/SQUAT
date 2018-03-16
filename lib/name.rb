class Name
  @@names_list = []
  @@names_used = []

  def self.get
    if @@names_list.empty?
      File.open( './lib/names.txt', 'r' ) do |f|
        f.readlines.each do |line|
          @@names_list += line.chomp.split
        end
      end
    end

    choosed_name = (@@names_list - @@names_used).sample
    @@names_used << choosed_name
    choosed_name
  end

end