printclass Person:
    def __init__( self, name, age):
        if age < 1:
            raise Exception("Age criteria is invalid.")
        self.name = name
        self.age = age
    
    def get_fname(self):
        return self.name.split(" ")[0]
    
    def get_lname(self):
        return self.name.split(" ")[-1]

    def get_age(self):
        return self.age

    def get_age_category(self):
        if self.age < 18:
            return 'CHILD'
        elif self.age > 18 and self.age < 60:
            return 'ADULT'
        else:
             return 'SENIOR CITIZEN'( " Again basic of class and objects, dated 23 Jan 2023")



# name = input('Enter name: ')
# while(1):
#     try:
#         age = int( input('Enter age: '))
#         if age < 1:
#             print('Negitive age')
#             raise Exception('Negitive age')
#         p = person( name, age)
#         print( p.get_fname(), p.get_age())
#         break
#     except:
#         print("Pls, enter a valid age!")

# p1 = person('Parv middle s', 24)
# p2 = person('rk ku chaudry', 26)

# print( p1.get_fname())
# print( p2.get_lname())

# find age category; age < 18 : child, >=18 - >60: adult, senior

# p3 = person( name, age)
# print( p3.get_fname(), ' is ', p3.get_age_category())


# dob as ip

### INHERITANCE

class Patient( Person):
    def __init__(self, name, age, ssn):
        super().__init__(name, age)
        self.ssn = ssn
    
    def get_ssn(self):
        return self.ssn

p1 = Patient( 'ram valli', 54, 1001)
p1.get_fname()
p1.get_ssn()












