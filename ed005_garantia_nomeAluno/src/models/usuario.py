class Usuario:
    def __init__(self, id_user, nome, cpf, tel, email, senha, status=True):
        self.id_user = id_user
        self.nome = nome
        self.cpf = cpf
        self.tel = tel
        self.email = email
        self.senha = senha
        self.status = status

    def __str__(self):
        return f"Usuario ID {self.id_user} | {self.nome} | CPF: {self.cpf} | Status: {'Ativo' if self.status else 'Inativo'}"
