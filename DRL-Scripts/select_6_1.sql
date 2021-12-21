alter session set nls_date_format = 'DD.MM.YYYY';

select distinct fewo.*
from ferienwohnungen fewo, bietet, adressen ad, orte, laender lea, belegungen bel
where   bietet.name = 'Schwimmbad'
        and
        bietet.wohnungsid = fewo.wohnungsid
        and
        fewo.adressid = ad.adressid
        and
        ad.ortsid = orte.ortsid
        and
        orte.isocode = lea.isocode
        and
        lea.name = 'Frankreich'
        and
        bel.wohnungsid = fewo.wohnungsid
        and
        bel.statusflag = 'Reservierung';



        