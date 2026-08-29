-- Envoie toutes les zones de type « city » vers le processus xi_map
-- qui ecoute sur le port 54232 (service « map-cities »).
-- Liste generee depuis data/zones/*/zone.yaml (type: [city]).

UPDATE zone_settings SET zoneport = 54232 WHERE zoneid IN (
     26, --  Tavnazian_Safehold
     32, --  Sealions_Den
     48, --  Al_Zahbi
     50, --  Aht_Urhgan_Whitegate
     70, --  Chocobo_Circuit
     71, --  The_Colosseum
     80, --  Southern_San_dOria_[S]
     87, --  Bastok_Markets_[S]
     94, --  Windurst_Waters_[S]
    189, --  Outer_RaKaznar_[U3]
    199, --  Residential_Area_199
    214, --  Residential_Area_214
    219, --  Residential_Area_219
    230, --  Southern_San_dOria
    231, --  Northern_San_dOria
    232, --  Port_San_dOria
    233, --  Chateau_dOraguille
    234, --  Bastok_Mines
    235, --  Bastok_Markets
    236, --  Port_Bastok
    237, --  Metalworks
    238, --  Windurst_Waters
    239, --  Windurst_Walls
    240, --  Port_Windurst
    241, --  Windurst_Woods
    242, --  Heavens_Tower
    243, --  RuLude_Gardens
    244, --  Upper_Jeuno
    245, --  Lower_Jeuno
    246, --  Port_Jeuno
    247, --  Rabao
    248, --  Selbina
    249, --  Mhaura
    250, --  Kazham
    251, --  Hall_of_the_Gods
    252, --  Norg
    256, --  Western_Adoulin
    257, --  Eastern_Adoulin
    280, --  Mog_Garden
    284, --  Celennia_Memorial_Library
    285  --  Feretory
);

SELECT zoneport, COUNT(*) AS zones FROM zone_settings GROUP BY zoneport;
