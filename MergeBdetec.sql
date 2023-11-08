MERGE tb3ano dest
Using tb2A ori
on ori.RM = dest.RM
when NOT MATCHED and ori.statusAluno = 'Aprovado' then
INSERT values (ori.RM, ori.nomeAluno, ori.statusAluno);

MERGE tb3ano dest
Using tb2B ori
on ori.RM = dest.RM
when NOT MATCHED and ori.statusAluno = 'Aprovado' then
INSERT values (ori.RM, ori.nomeAluno, ori.statusAluno);