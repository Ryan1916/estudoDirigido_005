from datetime import date

class Garantia:
    def __init__(self, id_garantia, inicio, fim, tipo_garantia, id_loja, id_equip):
        self.id_garantia = id_garantia
        self.inicio = inicio
        self.fim = fim
        self.tipo_garantia = tipo_garantia
        self.id_loja = id_loja
        self.id_equip = id_equip

    def status(self):
        hoje = date.today()
        if self.fim < hoje:
            return "VENCIDA"
        elif (self.fim - hoje).days <= 30:
            return "ALERTA (30 DIAS)"
        else:
            return "ATIVA"

    def __str__(self):
        return f"Garantia ID {self.id_garantia} | {self.tipo_garantia} | {self.inicio} → {self.fim} | Status: {self.status()}"
