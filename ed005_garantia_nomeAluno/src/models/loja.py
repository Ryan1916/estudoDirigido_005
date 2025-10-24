class Loja:
    def __init__(self, id_loja, nome, cnpj, endereco, tel, email, id_user):
        self.id_loja = id_loja
        self.nome = nome
        self.cnpj = cnpj
        self.endereco = endereco
        self.tel = tel
        self.email = email
        self.id_user = id_user

    def __str__(self):
        return f"Loja ID {self.id_loja} | {self.nome} | CNPJ: {self.cnpj}"
