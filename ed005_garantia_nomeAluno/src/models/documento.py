class Documento:
    def __init__(self, id_doc, url_doc, tipo_doc, num_doc, data_emissao, id_loja=None, id_user=None, id_equip=None, id_garantia=None):
        self.id_doc = id_doc
        self.url_doc = url_doc
        self.tipo_doc = tipo_doc
        self.num_doc = num_doc
        self.data_emissao = data_emissao
        self.id_loja = id_loja
        self.id_user = id_user
        self.id_equip = id_equip
        self.id_garantia = id_garantia

    def __str__(self):
        return f"Documento ID {self.id_doc} | {self.tipo_doc} | {self.num_doc} | Emissão: {self.data_emissao}"
