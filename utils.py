import mysql.connector
import os

class MysqlConnector:
    def __init__(self):
        self.connection = mysql.connector.connect(user=os.environ['MYSQL_USER'],
                                    password=os.environ['MYSQL_PASSWORD'],
                                    host=os.environ['MYSQL_HOST'],
                                    database=os.environ['MYSQL_DATABASE'],
                                    auth_plugin='mysql_native_password')

    def execute(self, query):
        cursor = self.connection.cursor()
        cursor.execute(query)
        self.connection.commit()
        cursor.close()

    def execute_many(self, query, values):
        cursor = self.connection.cursor()
        cursor.executemany(query, values)
        self.connection.commit()
        cursor.close()

    def fetch(self, query):
        cursor = self.connection.cursor()
        cursor.execute(query)
        result = cursor.fetchall()
        self.connection.commit()
        cursor.close()
        return result

    def batch_insert(self, table, columns, values):
        query = f'INSERT INTO {table} ({", ".join(columns)}) VALUES ({", ".join(["%s"] * len(columns))})'
        self.execute_many(query, values)