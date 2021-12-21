alter session set nls_date_format = 'DD.MM.YYYY'; 

/*
select tmp.wohnungsid
from
    (select *
    from    ferienwohnungen fewo left outer join belegungen bel on fewo.wohnungsid = bel.wohnungsid and statusflag = 'Reservierung'
            left outer join bietet on bietet.wohnungsid = fewo.wohnungsid
            left outer join adressen ad on fewo.adressid = ad.adressid
            left outer join orte on ad.ortsid = orte.ortsid
            left outer join laender lae on orte.isocode = lae.isocode
    where   bietet.name = 'Schwimmbad' and
            lae.name = 'Frankreich') tmp
where   tmp.statusflag is null;
*/

select fewo.*
from ferienwohnungen fewo, bietet, adressen ad, orte, laender lae
where   lae.name = 'Frankreich'
        and
        lae.isocode = orte.isocode
        and
        orte.ortsid = ad.ortsid
        and
        ad.adressid = fewo.adressid
        and
        fewo.wohnungsid = bietet.wohnungsid
        and
        bietet.name = 'Schwimmbad'
        and
        fewo.wohnungsid not in(
            select bel.wohnungsid
            from belegungen bel
            where statusflag = 'Reservierung');
    
