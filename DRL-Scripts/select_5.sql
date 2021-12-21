alter session set nls_date_format = 'DD.MM.YYYY';

select fewo.*, orfewo.name as Ort, entf.entfernung as Entf_Disneyl
from ferienwohnungen fewo, adressen adfewo, orte orfewo, laender lae, touristenattraktionen tour, adressen adtour, orte ortour, istentfernt entf
where   fewo.adressid = adfewo.adressid
        and
        adfewo.ortsid = orfewo.ortsid
        and
        orfewo.isocode = lae.isocode
        and
        lae.name = 'Frankreich'
        and
        tour.adressid = adtour.adressid
        and
        adtour.ortsid = ortour.ortsid
        and
        tour.name = 'Disneyland'
        and
                ((orfewo.ortsid = entf.startort
                and
                ortour.ortsid = entf.zielort)
            or
                (orfewo.ortsid = entf.zielort
                and
                ortour.ortsid = entf.startort))
        and
        entf.entfernung <= 100

union all

select fewo.*, orfewo.name as Ort, 0 as Entf_Disneyl
from ferienwohnungen fewo, adressen adfewo, orte orfewo, touristenattraktionen tour, adressen adtour, orte ortour
where   fewo.adressid = adfewo.adressid
        and
        adfewo.ortsid = orfewo.ortsid
        and
        tour.name = 'Disneyland'
        and
        tour.adressid = adtour.adressid
        and
        adtour.ortsid = ortour.ortsid
        and
        orfewo.ortsid = ortour.ortsid;

-- Land Frankreich muss in unterer Angabe ergänzt werden




        
        
        
        