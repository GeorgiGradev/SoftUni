﻿using System;
using System.Collections.Generic;
using System.Linq;

namespace _05._Students
{
    class Program
    {
        class Student
        {
            public string FirstName { get; set; }
            public string LastName { get; set; }
            public string Age { get; set; }
            public string Town { get; set; }
        }
        static void Main(string[] args)
        {
            string command = Console.ReadLine();
            List<Student> output = new List<Student>();
   
            while (command != "end")
            {
                List<string> input = command.Split().ToList();
                string firstName = input[0];
                string lastName = input[1];
                string age = input[2];
                string town = input[3];

                Student student = new Student();

                student.FirstName = firstName;
                student.LastName = lastName;
                student.Age = age;
                student.Town = town;

                output.Add(student);

                command = Console.ReadLine();
            }
            string nameOfCity = Console.ReadLine();

            foreach (Student student in output)
            {
                if (nameOfCity == student.Town)
                {
                    Console.WriteLine($"{student.FirstName} {student.LastName} is {student.Age} years old.");
                }
            }
        }
    }
}
