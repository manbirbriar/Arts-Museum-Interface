import mysql.connector
from dataentry import *
from gueststuff import *

def display(col_names, search_result): 
    print("Search Successful, {} Entry(s) Found\n".format(len(search_result)))
    header_size = len(col_names)
    for i in range(header_size):
        print("{:<15s}".format(col_names[i]), end=' ')
    print()
    print(15 * header_size * '-')
    for row in search_result:
        for val in row:
            if isinstance(val, str): 
                val = val[:10] + "..." if len(val) > 10 else val 
            print("{:<15s}".format(str(val)), end=' ')
        print()
        
    print()
    print()

def admin_consol():

    print("Welcome to admin controls")

    while True:
        print("What would you like to do as admin")
        print()
        print("1- Enter an SQL qeury")
        print("2- Run an sql query file")
        print("4- quit")

        selection = input(" 1 , 2, 3 or 4 : ")

        print()

        if selection == "1":
            #opening again in case another file was opened
            cur = cnx.cursor()
            fd = open('museum database.sql', 'r')
            sqlFile = fd.read()
            fd.close()
            sqlCommands = sqlFile.split(';')

            for command in sqlCommands:
                try:
                    if command.strip() != '':
                        cur.execute(command)
                except (IOError, msg):
                    print("Command Skipped: ", msg) #######

            instruction = input("Enter your SQL Query: ")
            try:
                cur.execute(instruction)
                col_names = cur.column_names
                search_result = cur.fetchall()
                display(col_names, search_result)

            except Exception as e:
                print("\nError executing the query, Please try again\n")

        elif selection == "2":      
            path = input("Enter your SQL Path: ")

            cur = cnx.cursor() 

            try:
                fd = open(path, 'r')


                sqlFile = fd.read()
                fd.close()
                sqlCommands = sqlFile.split(';')

                for command in sqlCommands:
                    try:
                        if command.strip() != '':
                            cur.execute(command)

                        if command.upper().startswith("SELECT"):
                            col_names = cur.column_names
                            search_result = cur.fetchall()
                            display(col_names, search_result)

                    except Exception as e:
                        print(f"Command Skipped. Error: {str(e)}")

                cnx.commit()

                cur.close()
            except Exception:
                print("\nError processing the SQL file\n")
        elif selection == "4":
            break
        else:
            print("invalid input")



def data_entry():
    cur = cnx.cursor() #opening again in case another file was opened
    fd = open('museum database.sql', 'r')
    sqlFile = fd.read()
    fd.close()
    sqlCommands = sqlFile.split(';')

    for command in sqlCommands:
        try:
            if command.strip() != '':
                cur.execute(command)
        except (IOError, msg):
            print("Command Skipped: ", msg) #######

    while True:
        print("What would you like to do?")
        print("1 - Lookup Database Information")
        print("2 - Insert New Tuples Into Existing Tables")
        print("3 - Update or Delete Tuples From Existing Tables")
        print("4 - Quit")

        selection = input("Choose what to do: ")

        if selection == '1':
            lookup_information(cur)
        elif selection == '2':
            insert_tuples(cur, cnx)
        elif selection == '3':
            update_or_delete_tuples(cur, cnx)
        elif selection == '4':
            return
        else:
            print("Invalid input")

        


def guest_view():
        # opening again in case another file was opened
    cur = cnx.cursor()
    fd = open('museum database.sql', 'r')
    sqlFile = fd.read()
    fd.close()
    sqlCommands = sqlFile.split(';')

    for command in sqlCommands:
        try:
            if command.strip() != '':
                cur.execute(command)
        except (IOError, msg):
            print("Command Skipped: ", msg) #######

    while True:
        print("\nEnter Number of Info Needed:")
        print("1 - Art Pieces")
        print("2 - Artists")
        print("3 - Exhibitions")
        print("4 - Collections")
        print("5 - Permanant Art")
        print("6 - Borrowed Art")
        print("7 - Quit")

        selection = input("Choose what to do with a nunmber: ")

        if selection == '1':
            artpiece(cur)
            break
        elif selection == '2':
            artist(cur)
            break
        elif selection == '3':
            exhibits(cur)
            break
        elif selection == '4':
            collections(cur)
            break
        elif selection == '5':
            permanent(cur)
            break
        elif selection == '6':
            borrowed(cur)
            break
        elif selection == '7':
            break
        else:
            print("Invalid input")

def login(selection):
    if selection == '1':
        user = input("User name please: ")
        code = input("Password please: ")
        if user == 'user' and code == 'user':
            print()
            print()
            admin_consol()

    
    elif selection == '2':
        user = input("User name please: ")
        code = input("Password please: ")
        if user == 'employee' and code == 'data':
            print()
            print()
            data_entry()   
        


if __name__ == "__main__":
    cnx = mysql.connector.connect(               
    host='127.0.0.1',
    port = 3306,
    user = 'root',
    password = '11699', 
    #database = 'museum'
    )
        
    cur = cnx.cursor() #opening again in case another file was opened
    fd = open('museum database.sql', 'r')
    sqlFile = fd.read()
    fd.close()
    sqlCommands = sqlFile.split(';')
    
    for command in sqlCommands:
        try:
            if command.strip() != '':
                cur.execute(command)
        except (IOError, msg):
            print("Command Skipped: ", msg) #######




    print("Welcome to our Museum's Database:")

    while True:
        print()
        print()
        print("MAIN MENU")
        print()
        print("In order to proceed please select your role from the list below:")
        print("1 - Admin")
        print("2 - Data Entry")
        print("3 - Browse as guest")
        print("4 - Quit")

        selection = input("please type 1, 2, or 3 to select your role: ")

        if selection == "1":
            print()
            login(selection)


        elif selection == "2":
            print()
            login(selection)  


        elif selection == "3":
            print()
            guest_view()

        elif selection == "4":
            break
        else:
            print("Invalid input")


cnx.close()
