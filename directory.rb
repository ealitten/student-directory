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

More exercises (done):

1. Refactoring
2. Program loads students.csv by default if no arguments
3. Refactoring
4. Added feedback for loading & saving students
5. Added methods to get filenames for saving & loading
6. Opens fles with a block in load & save methods
7. Use CSV library rather than File to read/write to files
8. Created write_self.rb
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

#for specific exercises
=begin
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
=end

require 'csv'

@students = []


def interactive_menu
    loop do
        print_menu
        process(STDIN.gets.chomp)
    end
end

def process(selection)
    case selection
        when "1" then input_students
        when "2" then show_students
        when "3" then get_filename(:save)
        when "4" then get_filename(:load)
        when "5" then print_spec_letter
        when "6" then print_spec_length
        when "7" then print_by_cohort
        when "9" then exit
        else puts "I don't know what you meant, try again"
    end
end 

def print_menu
    puts "1. Input students"
    puts "2. Show the students"
    puts "3. Save the list to a file"    
    puts "4. Load the list from a file"
    puts "5. Show students with name beginning with a specific letter"
    puts "6. Show students with name of specific length"
    puts "7. Show students sorted by cohort"    
    puts "9. Exit" 
end

def input_students
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
    while true
        print "Name: "
        name = STDIN.gets.delete("\n") #doesn't use chomp due to earlier exercise
        break if name.empty?
        print "Cohort: "
        cohort = STDIN.gets.delete("\n")
        @students << {name: name, cohort: cohort.to_sym}
        puts "Now we have #{@students.count} student#{@students.count > 1 ? "s" : ""}"
    end
end

def show_students
    print_header
    print_names
    print_footer
  end

def get_filename(action)
    puts "Which file to #{action.to_s}?"
    filename = STDIN.gets.chomp
    save_students(filename) if action == :save
    try_load_students(filename) if action == :load
end

def save_students(filename)
    CSV.open(filename,"w") { |file| 
        students_saved = 0
        @students.each { |student| 
            file << [student[:name],student[:cohort]].join(",")
            students_saved += 1 
        }
    }
    puts "Saved #{students_saved} students to #{filename}"
end

def load_students_startup
    ARGV.first.nil? ? filename = "students.csv" : filename = ARGV.first
    try_load_students(filename)
end

def try_load_students(filename)
    File.exist?(filename) ? load_students(filename) : puts("Sorry, #{filename} doesn't exist.")
end

def load_students(filename)
    students_loaded = 0
    CSV.foreach(filename) { |row|
        name, cohort = row
        @students << {name: name, cohort: cohort.to_sym}
        students_loaded += 1
    }
    puts "Loaded #{students_loaded} students from #{filename}"
end

def print_header
    puts "The students of Villains Academy"
    puts "-------------"
end

def print_names
    @students.each_with_index { |student,i| puts "#{i+1}. #{student[:name]} (#{student[:cohort]} cohort)" }
end

def print_spec_letter
    puts "Which letter?"
    letter = STDIN.gets.chomp
    puts "Students beginning with the letter #{letter.upcase}:"
    @students.each{ |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:name].slice(0).downcase == letter.downcase}
end

def print_spec_length
    puts "What length?"
    length = STDIN.gets.chomp.to_i
    puts "Students beginning with a name #{length} characters long:"
    @students.each{ |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:name].length == length}
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

load_students_startup
interactive_menu
