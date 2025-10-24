from datetime import date

class Equipamento:
    def __init__(self, id_equip, produto, data_da_compra, preco, n_de_serie, id_loja, id_user):
        self.id = id_equip
        self.produto = produto
        self.data_compra = data_da_compra
        self.preco = preco
        self.n_de_serie = n_de_serie
        self.id_loja = id_loja
        self.id_user = id_user

    def __str__(self):
        return f"Equipamento ID {self.id} | {self.produto} (S/N: {self.n_de_serie}) | R${self.preco:,.2f} | Compra: {self.data_compra}"
