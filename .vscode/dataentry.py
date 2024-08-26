import os
 
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

def lookup_information(cur):
    try:
        table_name = input("Enter the name of the table to lookup information: ").upper()

        if table_name not in ["EXHIBITIONS", "ARTIST", "ART_OBJECTS", "PAINTING", "SCULPTURE_STATUE", "OTHER", "PERMANENT_COLLECTION", "COLLECTIONS", "BORROWED"]:
            print("Invalid table name.")
            return
        search_field = input("Enter the name of the search field: ")
        search_value = input(f"Enter the value to search for. Make sure to include =, >, < before!!!!: ")

        instruction = f"SELECT * FROM {table_name} WHERE {search_field} {search_value}"
        cur.execute(instruction)

        col_names = cur.column_names
        search_result = cur.fetchall()

        if not search_result:
            print(f"No entries found in the {table_name} table with {search_field} = {search_value}")
        else:
            display(col_names, search_result)

    except Exception as err:
        print(f"Error in retrieving requested data - {err}")


def insert_tuples(cur, cnx):
    table_name = input("Enter the name of the table to insert tuples: ").upper()

    if table_name not in ["EXHIBITIONS", "ARTIST", "ART_OBJECTS", "PAINTING", "SCULPTURE_STATUE", "OTHER", "PERMANENT_COLLECTION", "COLLECTIONS", "BORROWED"]:
        print("Invalid table name.")
        return

    insertion_type = input("Choose insertion method file or manual: ").lower()

    if insertion_type == 'file':
        file_path = input("Enter the path of the file with tuple entries (or Q to return): ")
        if file_path == 'Q':
            return
        while not os.path.isfile(file_path):
            file_path = input("No such file path. Please enter the name file path you'd like to use.")
            if file_path == 'Q':
                return
        execute_sql_file(file_path, cnx, cur)
        
    elif insertion_type == 'manual':
        insert_tuples_manually(cur, cnx, table_name)
    else:
        print("Invalid insertion method.")



def execute_sql_file(filename, cnx, cur):
    fd = open(filename, 'r')
    sqlFile = fd.read()
    fd.close()
    sqlCommands = sqlFile.split(';')

    for command in sqlCommands:
        print(command)
        try:
            cur.execute(command)
            cnx.commit()
        except Exception as e:
            print(f"Error inserting tuple: {e}")
    print("Complete")

def insert_tuples_manually(cur, cnx, table_name):
    while True:
        values ={}


        cur.execute(f"DESCRIBE {table_name}")


        columns = [col[0] for col in cur.fetchall()]

        for col in columns:
            value = input(f"Enter value for {col} (press Enter to skip): ")
            values[col] = value

        print(values)

        try:
            placeholders = ', '.join(values.keys())

            columns = ', '.join(values.keys())

            instruction = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"
            print(instruction)
            cur.execute(instruction, values)
            cnx.commit()
            print("Tuple inserted successfully.")
        except Exception as e:
            print(f"Error inserting tuple: {e}")

        another_entry = input("Do you want to enter another tuple? (Y/N): ").lower()
        if another_entry != 'y':
            break

    print("Manual insertion completed successfully.")




def update_or_delete_tuples(cur, cnx):
    table_name = input("Enter the name of the table to update or delete tuples: ").upper()
    search_field = input("Enter the name of the search field: ")
    search_value = input(f"Enter the value for {search_field}: ")

    instruction = f"SELECT * FROM {table_name} WHERE {search_field} = %(value)s"
    
    try:
        cur.execute(instruction, {'value': search_value})

        col_names = cur.column_names
        search_result = cur.fetchall()
        display(col_names, search_result)

        action = input("Choose action (update/delete): ").lower()

        if action == 'update':
            update_tuple(cur, cnx, table_name, col_names, search_value)
        elif action == 'delete':
            delete_tuple(cur, cnx, table_name, search_field, search_value)
        else:
            print("Invalid action.")
    except:
        print(f"No entries found in the {table_name} table with {search_field} = {search_value}")

def update_tuple(cur, cnx, table_name, col_names, search_value):
    try:
        update_values = {}
        for col in col_names:
            new_value = input(f"Enter new value for {col} (leave blank to keep current value): ")
            if new_value:
                update_values[col] = new_value

        if update_values:
            set_clause = ', '.join([f"{col} = %({col})s" for col in update_values])
            instruction = f"UPDATE {table_name} SET {set_clause} WHERE {col_names[0]} = %(value)s"
            update_values['value'] = search_value

            cur.execute(instruction, update_values)
            cnx.commit()

            print("Update successful.")
        else:
            print("No updates provided.")

    except Exception as err:
        print(f"Error during update: {err}")

def delete_tuple(cur, cnx, table_name, search_field, search_value):
    try:
        instruction = f"DELETE FROM {table_name} WHERE {search_field} = %(value)s"
        cur.execute(instruction, {'value': search_value})
        cnx.commit()

        print("Deletion was successful.")

    except Exception as err:     
        print(f"Error during deletion: {err}")
