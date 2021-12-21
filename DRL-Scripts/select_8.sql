alter session set nls_date_format = 'DD.MM.YYYY';

select distinct fewo.*
from ferienwohnungen fewo, bietet, adressen ad, orte, laender lea, belegungen bel
where   bietet.name = 'Schwimmbad'
        and
        bietet.wohnungsid = fewo.wohnungsid
        and
        bel.wohnungsid = fewo.wohnungsid
        and
        fewo.adressid = ad.adressid
        and
        ad.ortsid = orte.ortsid
        and
        orte.isocode = lea.isocode
        and
        lea.name = 'Tuerkei'
        and
        (
        (bel.anreisetermin between '01.05.2016' and '21.05.2016')
        or
        (bel.abreisetermin between '01.05.2016' and '21.05.2016')
        or
        (bel.anreisetermin < '01.05.2016'
        and
        bel.abreisetermin > '21.05.2021')
        );



        