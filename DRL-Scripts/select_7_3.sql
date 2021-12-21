/*
select *
from ferienwohnungen fewo
where fewo.wohnungsid
    not in(
        select wohnungsid
        from belegungen);
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
            from belegungen bel);