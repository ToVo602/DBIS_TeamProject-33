alter session set nls_date_format = 'DD.MM.YYYY';

select lae.name, count(bel.belegungsnummer) as AnzahlBelegungen
from    laender lae left outer join orte on lae.isocode = orte.isocode
        left outer join adressen ad on orte.ortsid = ad.ortsid
        left outer join ferienwohnungen fewo on fewo.adressid = ad.adressid
        left outer join belegungen bel on bel.wohnungsid = fewo.wohnungsid
group by lae.name;
