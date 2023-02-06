/*Exercício 3 somente */

set search_path = exercicio
-- (a) Listar o nome de todos os fornecedores que estejam em cidades que comecem com a letra "L";

select sname
from fornecedor
where city like 'L%'

select sname
from fornecedor
where city not like 'L%'

%: qualquer coisa, inclusive nada.
_ : um caractere somente

-- (b) Listar o nome de todos os fornecedores que estejam em cidades que comecem com a letra "L" ou em cidades que terminem com o termo "ris";

select sname
from fornecedor
where city like 'L%' or city like '%ris'

-- (c) Listar as peças que estejam em cidades com exatamente 6 letras;

select *
from peca
where city like '______'

select *
from peca
where length(city) = 6

--select sname
--from fornecedor
--where city like 'L\%%' escape '\'

--select * from fornecedor
--insert into fornecedor values ('S6', 'Teste', '30', 'L%123')

-- (d) Listar a quantidade total de peças expedidas pelo fornecedor "Jones";
select sum(e.qty) as total
from fornecedor f, expedicao e
where f.cods = e.cods and lower(f.sname) = 'jones'

-- (e) Listar a média total de peças expedidas pelo fornecedor "Jones";
select round(avg(e.qty), 2) as total
from fornecedor f inner join expedicao e on f.cods = e.cods
where upper(f.sname) = 'JONES'

-- (f) Listar a quantidade total de peças expedidas por fornecedores da cidade de "Londres";
select sum(e.qty) as total
from fornecedor f inner join expedicao e on f.cods = e.cods
where lower(f.city) = 'london'

-- (g) Listar a quantidade total de peças fornecidas, agrupando por nome de fornecedor;
select f.sname, sum(e.qty) as total
from fornecedor f inner join expedicao e on f.cods = e.cods
group by f.sname
order by total desc

-- (h) Listar a quantidade total de peças fornecidas, agrupando por nome de fornecedor, mas mostrar somente aqueles 
-- fornecedores que expediram mais de 300 peças; 

select f.sname, sum(e.qty) as total
from fornecedor f inner join expedicao e on f.cods = e.cods
group by f.sname
having sum(e.qty) > 300

-- (i) Quais peças (código e nome) possuem a mesma cor da peça P1 (considerando que ninguém sabe a cor da peça P1);
select codp, pname
from peca
where color = (select color
from peca
where codp = 'P1')

select p2.codp, p2.pname 
from peca p1, peca p2
where p1.color = p2.color
and
p1.codp = 'P1'

select codp, pname
from peca
where color in (select color
from peca
where codp = 'P1' or codp = 'P2')

select codp, pname, color
from peca
where color not in (select color
from peca
where codp = 'P1' or codp = 'P2')

-- (j) Listar, usando o conceito de subconsulta, o código das peças vermelhas que foram expedidas.

select codp
from expedicao
where codp in (select codp
				from peca
				where lower(color) = 'red')
				
select e.codp
from expedicao e, peca p
where e.codp = p.codp
and 
lower(p.color) = 'red'