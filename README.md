# PostgreSQL
### Repositório com scripts feitos em PLpg/SQL

<br>
<br>

## Função Matador
>Função para Truncar todas as tabelas que não são nativas do PostgreSQL.

## Função Ilike In Tables
>Função para procurar conteudo expecifico em determinada coluna de uma tabela.
Exemplo: Quero procurar em que tabelas tem colunas que possui o valor 'João' no SCHEMA public : 

```
SELECT fn_ilike_in_tables('João', 'public')
```
