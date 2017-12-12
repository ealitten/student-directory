=begin
Exercises (done):

1. print(students) includes the number of the student
2. print_spec_letter only prints students beginning with specific letter
3. print_spec_length only prints students with names of specific length
4. print_without_each prints student names without using .each() method
5. Added hobbies & height, and print_expanded method to include them
6. print_expanded uses ljust() to display student info prettyfied
7. Modified input_students to take cohort too. Pressing enter twice still quits (unless cohort not yet entered)
8. 
9. Both input_student and footer adjust student(s) depending on # of students
10. Changed input_students to use delete.("\n") instead of chomp
11.
12. Won't print footer if there are no students (printing empty list in print_names doesn't matter)
=end

students = [
    {name: "Dr. Hannibal Lecter", cohort: :november, hobbies: "Cannibalism", height: "1.8m"},
    {name: "Darth Vader", cohort: :november, hobbies: "Ruling the galaxy", height: "1.9m"},
    {name: "Nurse Ratched", cohort: :november, hobbies: "Scheming", height: "1.65m"},
    {name: "Michael Corleone", cohort: :november, hobbies: "Organised crime", height: "1.7m"},
    {name: "Alex DeLarge", cohort: :november, hobbies: "Ultraviolence", height: "1.75m"},
    {name: "The Wicked Witch of the West", cohort: :november, hobbies: "Witchcraft", height: "1.5m"},
    {name: "Terminator", cohort: :november, hobbies: "Time travel", height: "1.9m"},
    {name: "Freddy Krueger", cohort: :november, hobbies: "Oneirology", height: "1.7m"},
    {name: "The Joker", cohort: :november, hobbies: "Practical jokes", height: "1.85m"},
    {name: "Joffrey Baratheon", cohort: :november, hobbies: "Cruelty", height: "1.6m"},
    {name: "Norman Bates", cohort: :november, hobbies: "Dissociative identities", height: "1.75m"}
  ]
      

def input_students
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
    students =[]
    
    while true
        print "Name: "
        name = gets.delete("\n")
        break if name.empty?
        print "Cohort: "
        cohort = gets.delete("\n").to_sym
        students << {name: name, cohort: cohort}
        puts "Now we have #{students.count} student#{students.count > 1 ? "s" : ""}"
    end
    students
end

def print_header
    puts "The students of Villains Academy"
    puts "-------------"
end

def print_names(students)
    students.each_with_index { |student,i| puts "#{i+1}. #{student[:name]} (#{student[:cohort]} cohort)" }
end

def print_spec_letter(students,letter)
    puts "Students beginning with the letter #{letter.upcase}:"
    students.each{ |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:name].slice(0).downcase == letter.downcase}
end

def print_spec_length(students,length)
    puts "Students beginning with a name #{length} characters long:"
    students.each{ |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:name].length == length}
end

def print_without_each(students)
    i = 0 
    while i < students.length
        puts "#{students[i][:name]} (#{students[i][:cohort]} cohort)"
        i += 1
    end
end

def print_expanded(students)
    students.each { |student,i| 
        puts "#{student[:name]} (#{student[:cohort]} cohort)".ljust(50) + "Likes: #{student[:hobbies]}".ljust(40) + "#{student[:height]} tall".ljust(20) }
end


def print_footer(students)
    puts "Overall we have #{students.count} great student#{students.count > 1 ? "s" : ""}" unless students.length == 0
end

students = input_students

print_header
print_names(students)
#print_spec_letter(students,"t")
#print_spec_length(students,12)
#print_without_each(students)
#print_expanded(students)
print_footer(students)