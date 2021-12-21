alter session set nls_date_format = 'DD.MM.YYYY';


select      fewo.wohnungsid, flughausl.iatacodeflughafen, flugge.iatacode
from        ferienwohnungen fewo, adressen adfewo, orte ortfewo, flughaefen flughfewo,
            fluggesellschaften flugge, anfliegen, orte ortflugh, adressen adflugh, flughaefen flughausl
where       fewo.wohnungsid = '&wohnungsid'
            and
            fewo.adressid = adfewo.adressid
            and
            adfewo.ortsid = ortfewo.ortsid
            and
            ortfewo.iatacodeflughafen = flughfewo.iatacodeflughafen
            and 
            flughfewo.iatacodeflughafen = anfliegen.zielflughafen
            and
            flugge.iatacode = anfliegen.iatacodegesellschaft
            and
            flughausl.adressid = adflugh.adressid
            and
            adflugh.ortsid = ortflugh.ortsid
            and
            flughausl.iatacodeflughafen = anfliegen.startflughafen
            and
            ortfewo.isocode <> ortflugh.isocode;
            
            
            




