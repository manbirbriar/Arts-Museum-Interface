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

def artpiece(cur): 
    while True:
        search = input("Input ID of Art Piece Required or input 'A' for all artpieces: ")

        if search.lower() == 'a':
            instruction = "SELECT * FROM art_objects"
            cur.execute(instruction)

            col_names = cur.column_names
            search_result = cur.fetchall()
            display(col_names, search_result)

        else:
            instruction = "SELECT * FROM art_objects WHERE Id_no = %(oid)s"
            cur.execute(instruction, {'oid': search})
        
            col_names = cur.column_names
            search_result = cur.fetchall()
            display(col_names, search_result)

            next = input("Would you like more info on this Art? (Y/N): ").lower()
            if next == 'y':
                art_type = search_result[0][7] 
                
                if art_type == 'Painting':
                    painting_info(cur, search)
                elif art_type == 'Sculpture' or art_type == 'Statue':
                    sculpture_info(cur, search)
                elif art_type == 'Other':
                    other_info(cur, search)

        leave = input("Return to the previous menu? ('yes' to stay): ").lower()
        if 'yes' not in leave:
            print("Returning to previous menu.")
            break

def painting_info(cur, search): 
    paintingq = "SELECT * FROM painting WHERE Id_no = %(oid)s"
    cur.execute(paintingq, {'oid': search})
    painting_result = cur.fetchall()

    col_names = cur.column_names
    display(col_names, painting_result)

def sculpture_info(cur, search): 
    sculptureq = "SELECT * FROM sculpture WHERE Id_no = %(oid)s"
    cur.execute(sculptureq, {'oid': search})
    sculpture_result = cur.fetchall()

    col_names = cur.column_names
    display(col_names, sculpture_result)

def other_info(cur, search): 
    otherq = "SELECT * FROM other WHERE Id_no = %(oid)s"
    cur.execute(otherq, {'oid': search})
    other_result = cur.fetchall()

    col_names = cur.column_names
    display(col_names, other_result)

def artist(cur): 
    while True:
        search = input("Insert Last Name of Artist Required or input A for all artists: ")
        if search.lower() == 'a':
            instruction = "SELECT * FROM artist"
            cur.execute(instruction)
        else:
            instruction = "SELECT * FROM artist WHERE lName = %(oid)s"
            cur.execute(instruction, {'oid': search})

        col_names = cur.column_names
        search_result = cur.fetchall()
        display(col_names, search_result)

        leave = input("Return to the previous menu? ('yes' to stay): ").lower()
        if 'yes' not in leave:
            print("Returning to previous menu.")
            break

def exhibits(cur): 
    while True:
        search = input("What is the name of Exhibit or input A for all Exhibitions: ")
        if search.lower() == 'a':
            instruction = "SELECT * FROM exhibitions"
            cur.execute(instruction)
        else:
            instruction = "SELECT * FROM exhibitions WHERE EName = %(oid)s"
            cur.execute(instruction, {'oid': search})

        col_names = cur.column_names
        search_result = cur.fetchall()
        display(col_names, search_result)

        leave = input("Return to the previous menu? ('yes' to stay): ").lower()
        if 'yes' not in leave:
            print("Returning to previous menu.")
            break

def collections(cur): 
    while True:
        search = input("Insert Name of Collection Required or input A for all Collections: ")
        if search.lower() == 'a':
            instruction = "SELECT * FROM collections"
            cur.execute(instruction)
        else:
            instruction = "SELECT * FROM collections WHERE CName = %(oid)s"
            cur.execute(instruction, {'oid': search})

        col_names = cur.column_names
        search_result = cur.fetchall()
        display(col_names, search_result)

        leave = input("Return to the previous menu? ('yes' to stay): ").lower()
        if 'yes' not in leave:
            print("Returning to previous menu.")
            break

def permanent(cur):
    while True:
        search = input("Insert ID of Art Required or input A for all artists: ")
        if search.lower() == 'a':
            instruction = "SELECT * FROM permanent_collection"
            cur.execute(instruction)
        else:
            instruction = "SELECT * FROM permanent_collection WHERE id_no = %(oid)s"
            cur.execute(instruction, {'oid': search})

        col_names = cur.column_names
        search_result = cur.fetchall()
        display(col_names, search_result)
        
        leave = input("Return to the previous menu? ('yes' to stay): ").lower()
        if 'yes' not in leave:
            print("Returning to previous menu.")
            break

def borrowed(cur):
    while True:
        search = input("Insert ID of Art Required or input A for all artists: ")
        if search.lower() == 'a':
            instruction = "SELECT * FROM borrowed"
            cur.execute(instruction)
        else:
            instruction = "SELECT * FROM borrowed WHERE id_no = %(oid)s"
            cur.execute(instruction, {'oid': search})

        col_names = cur.column_names
        search_result = cur.fetchall()
        display(col_names, search_result)

        leave = input("Return to the previous menu? ('yes' to stay): ").lower()
        if 'yes' not in leave:
            print("Returning to previous menu.")
            break
