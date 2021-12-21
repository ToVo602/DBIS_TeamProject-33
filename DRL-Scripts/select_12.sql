alter session set nls_date_format = 'DD.MM.YYYY';

select      fewo.wohnungsid, count(*) as Wohnungsbelegungen
from        ferienwohnungen fewo, adressen ad, orte, laender lae, belegungen bel
where       bel.wohnungsid = fewo.wohnungsid
            and
            fewo.adressid = ad.adressid
            and
            ad.ortsid = orte.ortsid
            and
            orte.isocode = lae.isocode
            and
            lae.name = 'Frankreich'
group by    fewo.wohnungsid
having      count(*)
            >
            (select     count(*) as deutscheFerienwohnungen
            from        ferienwohnungen fewo, adressen ad, orte, laender lae
            where       fewo.adressid = ad.adressid
                        and
                        ad.ortsid = orte.ortsid
                        and
                        orte.isocode = lae.isocode
                        and
                        lae.name = 'Deutschland');





