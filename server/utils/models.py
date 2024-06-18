import db
from flask import current_app

    ##################### USER CLASS #####################

class User():
    
    """
    Represents a user in the system.

    Attributes:
        __id (int): The user's ID.
        __username (str): The username of user  
        __hashPassword (str): The hashed password of the user.
    """

    def __init__(self, id: int, username: str, hashPassword: str) -> None:
    
        self.__id = id
        self.__username = username
        self.__hashPassword = hashPassword


    def get_id(self) -> int: 
        return self.__id
    
    def get_username(self) -> str: 
        return self.__username
    
    def get_hashPassword(self) -> str: 
        return self.__hashPassword

    ################## END OF USER CLASS ##################




    #################### USER MANAGER #####################    
class UserManager():
    
    @staticmethod
    def resultRowToUser(res: tuple) -> User:    
        return User(res[0], res[1], res[2]) # id, username, password


    @staticmethod
    def get(id: int | str) -> User | None:  #Retrieves a user by their ID.

        try:
            conn = db.getConnection(current_app)
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM users WHERE id = %s", (id, ))
            res = cursor.fetchone()
            if res:
                return UserManager.resultRowToUser(res)
        except Exception as e:
            current_app.logger.error(f"Error fetching user by ID: {e}")
        finally:
            cursor.close()
        
        return None
        
    @staticmethod
    def getByUsername(username: str) -> User | None:    #Retrieves a user by their email.

        conn = db.getConnection(current_app)
        cursor = conn.cursor()
        
        try:
            cursor.execute("SELECT * FROM users WHERE username = %s", (username, ))
            res = cursor.fetchone()
            if res:
                return UserManager.resultRowToUser(res)
        except Exception as e:
            current_app.logger.error(f"Error fetching user by ID: {e}")
        finally:
            cursor.close()
        
        return None

    @staticmethod
    def addUser(username: str, hashPassword: str) -> User:  #Adds a new user to the database.


        conn = db.getConnection(current_app)
        cursor = conn.cursor()
            
        try:
            if UserManager.getByUsername(username):
                return None

            cursor.execute("INSERT INTO users (username, password) VALUES (%s, %s)", (username, hashPassword, ))
            conn.commit()
            added_user = UserManager.getByUsername(username)
            assert added_user != None
            return added_user
        
        except Exception as e:
            current_app.logger.error(f"Error fetching user by ID: {e}")
        finally:
            cursor.close()
        
        return None
    
    ################## END OF USER MANAGER ##################