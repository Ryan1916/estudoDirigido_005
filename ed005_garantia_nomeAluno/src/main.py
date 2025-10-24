from database import Database
from models.equipamento import Equipamento
from datetime import date

def main():
    db = Database()
    
    query = """
    SELECT 
        e.id_equip, e.produto, e.data_da_compra, e.preco, e.n_de_serie, e.id_loja, e.id_user,
        g.inicio, g.fim
    FROM 
        equipamentos e
    JOIN 
        garantia g ON e.id_equip = g.id_equip;
    """

    resultados = db.executar_consulta(query)

    if resultados:
        print(f"{'STATUS':<25} | {'PRODUTO':<20} | {'COMPRA':<10} | {'TÉRMINO DA GARANTIA':<20}")
        print("-" * 78)
        for row in resultados:
            e_id, e_prod, e_data, e_preco, e_serie, e_loja, e_user, g_inicio, g_fim = row
            equipamento = Equipamento(e_id, e_prod, e_data, e_preco, e_serie, e_loja, e_user)
            hoje = date.today()
            status = "VENCIDA" if g_fim < hoje else "ALERTA (30 DIAS)" if (g_fim-hoje).days<=30 else "ATIVA"
            print(f"{status:<25} | {equipamento.produto:<20} | {equipamento.data_compra} | {g_fim}")
    else:
        print("Nenhum equipamento com garantia encontrado.")

    db.fechar()

if __name__ == "__main__":
    main()
