=begin
Exercises (done):

1. print(students) includes the number of the student
2. print_spec_letter only prints students beginning with specific letter
3. print_spec_length only prints students with names of specific length
4. print_without_each prints student names without using .each() method
5. Added hobbies & height, and print_expanded method to include them
6. print_expanded uses ljust() to display student info prettyfied
7. Modified input_students to take cohort too. Pressing enter twice still quits (unless cohort not yet entered)
8. print_by_cohort sorts students by cohort and outputs result
9. Both input_student and footer adjust student(s) depending on # of students
10. Changed input_students to use delete.("\n") instead of chomp
11. Typos.rb added
12. Won't print footer if there are no students (printing empty list in print_names doesn't matter)
=end

#Pre-made array of students for testing
=begin
@students = [
    {name: "Dr. Hannibal Lecter", cohort: :november, hobbies: "Cannibalism", height: "1.8m"},
    {name: "Darth Vader", cohort: :november, hobbies: "Ruling the galaxy", height: "1.9m"},
    {name: "Nurse Ratched", cohort: :october, hobbies: "Scheming", height: "1.65m"},
    {name: "Michael Corleone", cohort: :november, hobbies: "Organised crime", height: "1.7m"},
    {name: "Alex DeLarge", cohort: :october, hobbies: "Ultraviolence", height: "1.75m"},
    {name: "The Wicked Witch of the West", cohort: :november, hobbies: "Witchcraft", height: "1.5m"},
    {name: "Terminator", cohort: :november, hobbies: "Time travel", height: "1.9m"},
    {name: "Freddy Krueger", cohort: :november, hobbies: "Oneirology", height: "1.7m"},
    {name: "The Joker", cohort: :december, hobbies: "Practical jokes", height: "1.85m"},
    {name: "Joffrey Baratheon", cohort: :november, hobbies: "Cruelty", height: "1.6m"},
    {name: "Norman Bates", cohort: :november, hobbies: "Dissociative identities", height: "1.75m"}
  ]
=end     

@students = []


def interactive_menu
    loop do
        print_menu
        selection = gets.chomp
        case selection
            when "1" then input_students
            when "2" then show_students
            when "3" then save_students
            when "4" then load_students
            when "9" then exit # this will cause the program to terminate
            else
                puts "I don't know what you meant, try again"
        end        
    end
end

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"    
    puts "4. Load the list from students.csv"    
    puts "9. Exit" 
end

def input_students
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
    while true
        print "Name: "
        name = gets.delete("\n")
        break if name.empty?
        print "Cohort: "
        cohort = gets.delete("\n").to_sym
        @students << {name: name, cohort: cohort}
        puts "Now we have #{@students.count} student#{@students.count > 1 ? "s" : ""}"
    end
end

def show_students
    print_header
    print_names
    print_footer
  end

def save_students
    file = File.open("students.csv","w")
    @students.each { |student| file.puts [student[:name],student[:cohort]].join(",") }
    file.close
end

def load_students
    file = File.open("students.csv","r")
    file.readlines.each { |line|
        name, cohort = line.chomp.split(",")
        @students << {name: name, cohort: cohort.to_sym}
    }
    file.close
end

def print_header
    puts "The students of Villains Academy"
    puts "-------------"
end

def print_names
    @students.each_with_index { |student,i| puts "#{i+1}. #{student[:name]} (#{student[:cohort]} cohort)" }
end

def print_spec_letter(letter)
    puts "Students beginning with the letter #{letter.upcase}:"
    @students.each{ |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:name].slice(0).downcase == letter.downcase}
end

def print_spec_length(length)
    puts "Students beginning with a name #{length} characters long:"
    @students.each{ |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:name].length == length}
end

def print_without_each
    i = 0 
    while i < @students.length
        puts "#{@students[i][:name]} (#{@students[i][:cohort]} cohort)"
        i += 1
    end
end

def print_expanded
    @students.each { |student,i| 
        puts "#{student[:name]} (#{student[:cohort]} cohort)".ljust(50) + "Likes: #{student[:hobbies]}".ljust(40) + "#{student[:height]} tall".ljust(20) }
end

def print_by_cohort
    sorted_by_cohort = {}
    @students.each {|student|
        cohort = student[:cohort]
        sorted_by_cohort[cohort] = [] if sorted_by_cohort[cohort].nil?
        sorted_by_cohort[cohort] << student[:name]
        }
    sorted_by_cohort.each {|k,v| puts "#{k} cohort:"; puts v}   
end

def print_footer
    puts "Overall we have #{@students.count} great student#{@students.count > 1 ? "s" : ""}" unless @students.length == 0
end

interactive_menu
