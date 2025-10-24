import psycopg2

class Database:
    def __init__(self):
        try:
            self.conn = psycopg2.connect(
                dbname="app_garantia",
                user="postgres",
                password="teste123321",
                host="localhost",
                port="5432"
            )
        except Exception as e:
            print("Erro ao conectar ao banco de dados:", e)
            self.conn = None

    def executar_consulta(self, query, params=None):
        if not self.conn:
            return []
        cur = None
        try:
            cur = self.conn.cursor()
            cur.execute(query, params)
            return cur.fetchall()
        except Exception as e:
            print("Erro na consulta:", e)
            return []
        finally:
            if cur:
                cur.close()

    def fechar(self):
        if self.conn:
            self.conn.close()
