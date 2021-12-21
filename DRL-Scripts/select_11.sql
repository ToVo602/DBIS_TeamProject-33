alter session set nls_date_format = 'DD.MM.YYYY';

select fewo.wohnungsid, count(bel.belegungsnummer) as Wohungsbelegungen
from    ferienwohnungen fewo left outer join belegungen bel on fewo.wohnungsid = bel.wohnungsid
group by fewo.wohnungsid;



select res.wohnungsid, Wohnungsreservierungen, Wohnungsbuchungen
from
    (select     fewo.wohnungsid, count(bel.belegungsnummer) as Wohnungsreservierungen
    from        ferienwohnungen fewo left outer join belegungen bel on fewo.wohnungsid = bel.wohnungsid and bel.statusflag = 'Reservierung'
    group by    fewo.wohnungsid) res,

    (select     fewo.wohnungsid, count(bel.belegungsnummer) as Wohnungsbuchungen
    from        ferienwohnungen fewo left outer join belegungen bel on fewo.wohnungsid = bel.wohnungsid and bel.statusflag = 'Buchung'
    group by    fewo.wohnungsid) buch

where res.wohnungsid = buch.wohnungsid;






