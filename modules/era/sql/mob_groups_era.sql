-- ---------------------------------------------------------------------------
--  Notes: Reverts mob levels to original 75 cap levels
-- Format: (groupid,poolid,zoneid,name,respawntime,spawntype,dropid,HP,MP,minLevel,maxLevel,allegiance)
-- ---------------------------------------------------------------------------

-- ------------------------------------------------------------
-- Add content_tag to zones
-- ------------------------------------------------------------

ALTER TABLE `mob_groups`
    ADD COLUMN IF NOT EXISTS `content_tag` varchar(14) DEFAULT NULL AFTER `allegiance`;

UPDATE mob_groups SET content_tag='COP' WHERE zoneid='1' OR zoneid='2' OR zoneid='3' OR zoneid='4' OR zoneid='5'
                  OR zoneid='6' OR zoneid='7' OR zoneid='8' OR zoneid='7' OR zoneid='8' OR zoneid='9' OR zoneid='10'
                  OR zoneid='11' OR zoneid='12' OR zoneid='13' OR zoneid='16' OR zoneid='17' OR zoneid='18' OR zoneid='19'
                  OR zoneid='20' OR zoneid='21' OR zoneid='22' OR zoneid='23' OR zoneid='24' OR zoneid='25' OR zoneid='26'
                  OR zoneid='27' OR zoneid='28' OR zoneid='29' OR zoneid='30' OR zoneid='31' OR zoneid='32' OR zoneid='33'
                  OR zoneid='34' OR zoneid='35' OR zoneid='36' OR zoneid='37' OR zoneid='38';

UPDATE mob_groups SET content_tag='TOAU' WHERE zoneid='46' OR zoneid='47' OR zoneid='48' OR zoneid='49' OR zoneid='50' OR zoneid='51'
                  OR zoneid='52' OR zoneid='53' OR zoneid='54' OR zoneid='55' OR zoneid='56' OR zoneid='57' OR zoneid='58' OR zoneid='59'
                  OR zoneid='60' OR zoneid='61' OR zoneid='62' OR zoneid='63' OR zoneid='64' OR zoneid='65' OR zoneid='66' OR zoneid='67'
                  OR zoneid='68' OR zoneid='69' OR zoneid='70' OR zoneid='71' OR zoneid='72' OR zoneid='73' OR zoneid='74' OR zoneid='75'
                  OR zoneid='76' OR zoneid='77' OR zoneid='78' OR zoneid='79';

UPDATE mob_groups SET content_tag='WOTG' WHERE zoneid='80' OR zoneid='81' OR zoneid='82' OR zoneid='83' OR zoneid='84' OR zoneid='85'
                  OR zoneid='86' OR zoneid='87' OR zoneid='88' OR zoneid='89' OR zoneid='90' OR zoneid='91' OR zoneid='92' OR zoneid='93'
                  OR zoneid='94' OR zoneid='95' OR zoneid='96' OR zoneid='97' OR zoneid='98' OR zoneid='99' OR zoneid='136' OR zoneid='137'
                  OR zoneid='138' OR zoneid='155' OR zoneid='156' OR zoneid='164' OR zoneid='171' OR zoneid='175' OR zoneid='182';

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE zoneid='15' OR zoneid='45' OR zoneid='132' OR zoneid='215' OR zoneid='216'
                  OR zoneid='217' OR zoneid='218' OR zoneid='253' OR zoneid='254' OR zoneid='255' OR zoneid='13' OR zoneid='44'
                  OR zoneid='183' OR zoneid='287';

UPDATE mob_groups SET content_tag='SOA' WHERE zoneid='258' OR zoneid='259' OR zoneid='260' OR zoneid='261' OR zoneid='262' OR zoneid='263'
                  OR zoneid='262' OR zoneid='263' OR zoneid='264' OR zoneid='265' OR zoneid='266' OR zoneid='267' OR zoneid='268' OR zoneid='269'
                  OR zoneid='270' OR zoneid='271' OR zoneid='272' OR zoneid='273' OR zoneid='274' OR zoneid='275' OR zoneid='276' OR zoneid='277'
                  OR zoneid='278' OR zoneid='279' OR zoneid='280' OR zoneid='281' OR zoneid='282' OR zoneid='283' OR zoneid='284' OR zoneid='285'
                  OR zoneid='286' OR zoneid='287';

UPDATE mob_groups SET content_tag='ROV' WHERE zoneid='288' OR zoneid='289' OR zoneid='290' OR zoneid='291' OR zoneid='292' OR zoneid='293'
                  OR zoneid='294' OR zoneid='295' OR zoneid='296' OR zoneid='297' OR zoneid='298';

UPDATE mob_groups SET content_tag='NEODYNA' WHERE zoneid='39' OR zoneid='40' OR zoneid='41' OR zoneid='42' OR zoneid='134' OR zoneid='135'
                  OR zoneid='185' OR zoneid='186' OR zoneid='187' OR zoneid='188';

-- ------------------------------------------------------------
-- Carpenters_Landing (Zone 2)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Tempest_Tigon' AND groupid='31' AND zoneid='2';

-- ------------------------------------------------------------
-- Bibiki_Bay (Zone 4)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Shankha' AND groupid='17' AND zoneid='4';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Splacknuck' AND groupid='37' AND zoneid='4';

-- ------------------------------------------------------------
-- Uleguerand_Range (Zone 5)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Magnotaur' AND groupid='39' AND zoneid='5';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Skvader' AND groupid='11' AND zoneid='5';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Frost_Flambeau' AND groupid='49' AND zoneid='5';

-- ------------------------------------------------------------
-- Attohwa_Chasm (Zone 7)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Sekhmet' AND groupid='12' AND zoneid='7';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Sargas' AND groupid='32' AND zoneid='7';

-- ------------------------------------------------------------
-- Oldton_Movalpolos (Zone 11)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Bugbear_Muscleman' AND groupid='18' AND zoneid='11';

-- ------------------------------------------------------------
-- Newton_Movalpolos (Zone 12)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Sword_Sorcerer_Solisoq' AND groupid='36' AND zoneid='12';

-- ------------------------------------------------------------
-- Promyvion-Holla (Zone 16)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='22',maxLevel='33' WHERE name='Idle_Wanderer' AND groupid='3' AND zoneid='16';
UPDATE mob_groups SET minLevel='24',maxLevel='35' WHERE name='Livid_Seether' AND groupid='22' AND zoneid='16';
UPDATE mob_groups SET minLevel='30',maxLevel='37' WHERE name='Woeful_Weeper' AND groupid='23' AND zoneid='16';

-- ------------------------------------------------------------
-- Promyvion-Dem (Zone 18)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='22',maxLevel='33' WHERE name='Idle_Wanderer' AND groupid='3' AND zoneid='18';
UPDATE mob_groups SET minLevel='24',maxLevel='35' WHERE name='Livid_Seether' AND groupid='22' AND zoneid='18';
UPDATE mob_groups SET minLevel='30',maxLevel='37' WHERE name='Woeful_Weeper' AND groupid='23' AND zoneid='18';

-- ------------------------------------------------------------
-- Promyvion-Mea (Zone 20)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='22',maxLevel='33' WHERE name='Idle_Wanderer' AND groupid='3' AND zoneid='20';
UPDATE mob_groups SET minLevel='24',maxLevel='35' WHERE name='Livid_Seether' AND groupid='22' AND zoneid='20';
UPDATE mob_groups SET minLevel='30',maxLevel='37' WHERE name='Woeful_Weeper' AND groupid='23' AND zoneid='20';

-- ------------------------------------------------------------
-- Promyvion-Vahzl (Zone 22)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='46',maxLevel='52' WHERE name='Idle_Wanderer' AND groupid='7' AND zoneid='22';
UPDATE mob_groups SET minLevel='52',maxLevel='56' WHERE name='Livid_Seether' AND groupid='37' AND zoneid='22';
UPDATE mob_groups SET minLevel='48',maxLevel='54' WHERE name='Woeful_Weeper' AND groupid='38' AND zoneid='22';

-- ------------------------------------------------------------
-- Lufaise_Meadows (Zone 24)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Flockbock' AND groupid='32' AND zoneid='24';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Sengann' AND groupid='79' AND zoneid='24';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Yal-un_Eke' AND groupid='82' AND zoneid='24';

-- ------------------------------------------------------------
-- Misareaux_Coast (Zone 25)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Goaftrap' AND groupid='9' AND zoneid='25';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Okyupete' AND groupid='47' AND zoneid='25';

-- ------------------------------------------------------------
-- Phomiuna_Aqueducts (Zone 27)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='40',maxLevel='44' WHERE name='Aqueduct_Spider' AND groupid='44' AND zoneid='27';

-- ------------------------------------------------------------
-- Sacrarium (Zone 28)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='52',maxLevel='56' WHERE name='Aqueduct_Spider' AND groupid='41' AND zoneid='28';

-- ------------------------------------------------------------
-- West_Ronfaure (Zone 100)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Amanita' AND groupid='16' AND zoneid='100';

-- ------------------------------------------------------------
-- East_Ronfaure (Zone 101)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Rambukk' AND groupid='20' AND zoneid='101';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yilbegan' AND groupid='45' AND zoneid='101';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Krabkatoa' AND groupid='46' AND zoneid='101';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yacumama' AND groupid='47' AND zoneid='101';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Capricornus' AND groupid='48' AND zoneid='101';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Quagmire_Pugil' AND groupid='49' AND zoneid='101';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Sunderclaw' AND groupid='50' AND zoneid='101';

-- ------------------------------------------------------------
-- La_Theine_Plateau (Zone 102)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Slumbering_Samwell' AND groupid='37' AND zoneid='102';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yilbegan' AND groupid='49' AND zoneid='102';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Dawon' AND groupid='50' AND zoneid='102';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Tammuz' AND groupid='51' AND zoneid='102';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Chesma' AND groupid='52' AND zoneid='102';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Void_Hare' AND groupid='53' AND zoneid='102';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Prickly_Sheep' AND groupid='54' AND zoneid='102';

-- ------------------------------------------------------------
-- Valkurm_Dunes (Zone 103)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Metal_Shears' AND groupid='17' AND zoneid='103';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Hippomaritimus' AND groupid='29' AND zoneid='103';

-- ------------------------------------------------------------
-- Jugner_Forest (Zone 104)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Supplespine_Mujwuj' AND groupid='41' AND zoneid='104';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Sappy_Sycamore' AND groupid='43' AND zoneid='104';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yilbegan' AND groupid='73' AND zoneid='104';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Krabkatoa' AND groupid='74' AND zoneid='104';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yacumama' AND groupid='75' AND zoneid='104';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Capricornus' AND groupid='76' AND zoneid='104';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Quagmire_Pugil' AND groupid='77' AND zoneid='104';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Sunderclaw' AND groupid='78' AND zoneid='104';

-- ------------------------------------------------------------
-- Batallia_Downs (Zone 105)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Skirling_Liger' AND groupid='25' AND zoneid='105';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Eyegouger' AND groupid='38' AND zoneid='105';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Prankster_Maverix' AND groupid='40' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yilbegan' AND groupid='50' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Verthandi' AND groupid='51' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Urd' AND groupid='52' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Skuld' AND groupid='53' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Aither' AND groupid='54' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Deorc' AND groupid='55' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Eorthe' AND groupid='56' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Puretos' AND groupid='57' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Pruina' AND groupid='58' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Beorht' AND groupid='59' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Thunor' AND groupid='60' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Lacus' AND groupid='61' AND zoneid='105';

-- ------------------------------------------------------------
-- North_Gustaberg (Zone 106)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Bedrock_Barry' AND groupid='26' AND zoneid='106';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yilbegan' AND groupid='55' AND zoneid='106';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Blobdingnag' AND groupid='56' AND zoneid='106';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Septic_Boil' AND groupid='57' AND zoneid='106';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Shoggoth' AND groupid='58' AND zoneid='106';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Lamprey_Lord' AND groupid='59' AND zoneid='106';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Ground_Guzzler' AND groupid='60' AND zoneid='106';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Globster' AND groupid='61' AND zoneid='106';

-- ------------------------------------------------------------
-- South_Gustaberg (Zone 107)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Tococo' AND groupid='28' AND zoneid='107';

-- ------------------------------------------------------------
-- Konschtat_Highlands (Zone 108)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Ghillie_Dhu' AND groupid='8' AND zoneid='108';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Highlander_lizard' AND groupid='26' AND zoneid='108';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yilbegan' AND groupid='38' AND zoneid='108';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Dawon' AND groupid='39' AND zoneid='108';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Tammuz' AND groupid='40' AND zoneid='108';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Chesma' AND groupid='41' AND zoneid='108';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Void_Hare' AND groupid='42' AND zoneid='108';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Prickly_Sheep' AND groupid='43' AND zoneid='108';

-- ------------------------------------------------------------
-- Pashhow_Marshlands (Zone 109)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='NiZho_Bladebender' AND groupid='28' AND zoneid='109';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Toxic_Tamlyn' AND groupid='38' AND zoneid='109';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yilbegan' AND groupid='65' AND zoneid='109';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Blobdingnag' AND groupid='66' AND zoneid='109';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Septic_Boil' AND groupid='67' AND zoneid='109';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Shoggoth' AND groupid='68' AND zoneid='109';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Lamprey_Lord' AND groupid='69' AND zoneid='109';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Ground_Guzzler' AND groupid='70' AND zoneid='109';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Globster' AND groupid='71' AND zoneid='109';

-- ------------------------------------------------------------
-- Rolanberry_Fields (Zone 110)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Ravenous_Crawler' AND groupid='36' AND zoneid='110';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Eldritch_Edge' AND groupid='38' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yilbegan' AND groupid='45' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Verthandi' AND groupid='46' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Urd' AND groupid='47' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Skuld' AND groupid='48' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Aither' AND groupid='49' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Deorc' AND groupid='50' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Eorthe' AND groupid='51' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Puretos' AND groupid='52' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Pruina' AND groupid='53' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Beorht' AND groupid='54' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Thunor' AND groupid='55' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Lacus' AND groupid='56' AND zoneid='110';

-- ------------------------------------------------------------
-- Beaucedine_Glacier (Zone 111)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Humbaba' AND groupid='32' AND zoneid='111';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Calcabrina' AND groupid='33' AND zoneid='111';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yilbegan' AND groupid='52' AND zoneid='111';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Lord_Ruthven' AND groupid='53' AND zoneid='111';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Feuerunke' AND groupid='54' AND zoneid='111';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Erebus' AND groupid='55' AND zoneid='111';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Gjenganger' AND groupid='56' AND zoneid='111';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Gorehound' AND groupid='57' AND zoneid='111';

-- ------------------------------------------------------------
-- Xarcabard (Zone 112)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Barbaric_Weapon' AND groupid='11' AND zoneid='112';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Duke_Focalor' AND groupid='21' AND zoneid='112';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Timeworn_Warrior' AND groupid='12' AND zoneid='112';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yilbegan' AND groupid='48' AND zoneid='112';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Lord_Ruthven' AND groupid='49' AND zoneid='112';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Feuerunke' AND groupid='50' AND zoneid='112';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Erebus' AND groupid='51' AND zoneid='112';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Gjenganger' AND groupid='52' AND zoneid='112';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Gorehound' AND groupid='53' AND zoneid='112';

-- ------------------------------------------------------------
-- Cape_Teriggan (Zone 113)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Killer_Johnny' AND groupid='20' AND zoneid='113';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Tegmine' AND groupid='23' AND zoneid='113';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Zmey_Gorynych' AND groupid='24' AND zoneid='113';

-- ------------------------------------------------------------
-- Eastern_Altepa_Desert (Zone 114)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Donnergugi' AND groupid='16' AND zoneid='114';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Nandi' AND groupid='34' AND zoneid='114';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Sabotender_Corrido' AND groupid='25' AND zoneid='114';

-- ------------------------------------------------------------
-- West_Sarutabaruta (Zone 115)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Numbing_Norman' AND groupid='27' AND zoneid='115';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yilbegan' AND groupid='36' AND zoneid='115';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Orcus' AND groupid='37' AND zoneid='115';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Farruca_Fly' AND groupid='38' AND zoneid='115';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Jyeshtha' AND groupid='39' AND zoneid='115';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Rummager_Beetle' AND groupid='40' AND zoneid='115';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Raker_Bee' AND groupid='41' AND zoneid='115';

-- ------------------------------------------------------------
-- East_Sarutabaruta (Zone 116)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Duke_Decapod' AND groupid='25' AND zoneid='116';

-- ------------------------------------------------------------
-- Tahrongi_Canyon (Zone 117)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Habrok' AND groupid='8' AND zoneid='117';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Herbage_Hunter' AND groupid='30' AND zoneid='117';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yilbegan' AND groupid='36' AND zoneid='117';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Dawon' AND groupid='37' AND zoneid='117';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Tammuz' AND groupid='38' AND zoneid='117';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Chesma' AND groupid='39' AND zoneid='117';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Void_Hare' AND groupid='40' AND zoneid='117';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Prickly_Sheep' AND groupid='41' AND zoneid='117';

-- ------------------------------------------------------------
-- Buburimu_Peninsula (Zone 118)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Wake_Warder_Wanda' AND groupid='22' AND zoneid='118';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Backoo' AND groupid='55' AND zoneid='118';

-- ------------------------------------------------------------
-- Meriphataud_Mountains (Zone 119)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Chonchon' AND groupid='19' AND zoneid='119';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Naa_Zeku_the_Unwaiting' AND groupid='29' AND zoneid='119';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Patripatan' AND groupid='37' AND zoneid='119';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yilbegan' AND groupid='64' AND zoneid='119';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Orcus' AND groupid='65' AND zoneid='119';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Farruca_Fly' AND groupid='66' AND zoneid='119';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Jyeshtha' AND groupid='67' AND zoneid='119';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Rummager_Beetle' AND groupid='68' AND zoneid='119';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Raker_Bee' AND groupid='69' AND zoneid='119';

-- ------------------------------------------------------------
-- Sauromugue_Champaign (Zone 120)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Bashe' AND groupid='68' AND zoneid='120';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Thunderclaw_Thuban' AND groupid='333' AND zoneid='120';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Blighting_Brand' AND groupid='38' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Yilbegan' AND groupid='46' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Verthandi' AND groupid='47' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Urd' AND groupid='48' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Skuld' AND groupid='49' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Aither' AND groupid='50' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Deorc' AND groupid='51' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Eorthe' AND groupid='52' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Puretos' AND groupid='53' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Pruina' AND groupid='54' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Beorht' AND groupid='55' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Thunor' AND groupid='56' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWALKER' WHERE name='Lacus' AND groupid='57' AND zoneid='120';

-- ------------------------------------------------------------
-- The_Sanctuary_of_ZiTah (Zone 121)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Elusive_Edwin' AND groupid='15' AND zoneid='121';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Huwasi' AND groupid='20' AND zoneid='121';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Bastet' AND groupid='34' AND zoneid='121';

-- ------------------------------------------------------------
-- RoMaeve (Zone 122)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Rogue_Receptacle' AND groupid='15' AND zoneid='122';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Martinet' AND groupid='12' AND zoneid='122';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Nargun' AND groupid='16' AND zoneid='122';

-- ------------------------------------------------------------
-- Yuhtunga_Jungle (Zone 123)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Koropokkur' AND groupid='9' AND zoneid='123';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Pyuu_the_Spatemaker' AND groupid='25' AND zoneid='123';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Bayawak' AND groupid='30' AND zoneid='123';

-- ------------------------------------------------------------
-- Yhoator_Jungle (Zone 124)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Powderer_Penny' AND groupid='25' AND zoneid='124';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Acolnahuacatl' AND groupid='27' AND zoneid='124';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Hoar-knuckled_Rimberry' AND groupid='32' AND zoneid='124';

-- ------------------------------------------------------------
-- Western_Altepa_Desert (Zone 125)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Calchas' AND groupid='23' AND zoneid='125';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Dahu' AND groupid='37' AND zoneid='125';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Picolaton' AND groupid='38' AND zoneid='125';

-- ------------------------------------------------------------
-- Qufim_Island (Zone 126)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Slippery_Sucker' AND groupid='23' AND zoneid='126';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Qoofim' AND groupid='28' AND zoneid='126';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Atkorkamuy' AND groupid='25' AND zoneid='126';

-- ------------------------------------------------------------
-- Fort_Ghelsba (Zone 141)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Kegpaunch_Doshgnosh' AND groupid='20' AND zoneid='141';

-- ------------------------------------------------------------
-- Palborough_Mines (Zone 143)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='QuVho_Deathhurler' AND groupid='10' AND zoneid='143';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='BeHya_Hundredwall' AND groupid='22' AND zoneid='143';

-- ------------------------------------------------------------
-- Giddeus (Zone 145)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Quu_Xijo_the_Illusory' AND groupid='20' AND zoneid='145';

-- ------------------------------------------------------------
-- Castle_Oztroja (Zone 151)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Saa_Doyi_the_Fervid' AND groupid='5' AND zoneid='151';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Lii_Jixa_the_Somnolist' AND groupid='21' AND zoneid='151';

-- ------------------------------------------------------------
-- The_Boyahda_Tree (Zone 153)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='72',maxLevel='75' WHERE name='Mourning_Crawler' AND groupid='25' AND zoneid='153';
UPDATE mob_groups SET minLevel='72',maxLevel='75' WHERE name='Snaggletooth_Peapuk' AND groupid='26' AND zoneid='153';
UPDATE mob_groups SET minLevel='72',maxLevel='74' WHERE name='Viseclaw' AND groupid='27' AND zoneid='153';

-- ------------------------------------------------------------
-- Upper_Delkfutts_Tower (Zone 158)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Mimas' AND groupid='9' AND zoneid='158';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Autarch' AND groupid='25' AND zoneid='158';

-- ------------------------------------------------------------
-- Castle_Zvahl_Baileys (Zone 161)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Likho' AND groupid='7' AND zoneid='161';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Marquis_Naberius' AND groupid='36' AND zoneid='161';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Marquis_Sabnock' AND groupid='37' AND zoneid='161';

-- ------------------------------------------------------------
-- Ranguemont_Pass (Zone 166)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='42',maxLevel='44' WHERE name='Hovering_Oculus' AND groupid='20' AND zoneid='166';
UPDATE mob_groups SET minLevel='25',maxLevel='28' WHERE name='Bilesucker' AND groupid='21' AND zoneid='166';
UPDATE mob_groups SET minLevel='26',maxLevel='30' WHERE name='Goblin_Hoodoo' AND groupid='22' AND zoneid='166';
UPDATE mob_groups SET minLevel='26',maxLevel='30' WHERE name='Goblin_Artificer' AND groupid='23' AND zoneid='166';
UPDATE mob_groups SET minLevel='26',maxLevel='30' WHERE name='Goblin_Tanner' AND groupid='24' AND zoneid='166';
UPDATE mob_groups SET minLevel='26',maxLevel='30' WHERE name='Goblin_Chaser' AND groupid='25' AND zoneid='166';
UPDATE mob_groups SET minLevel='24',maxLevel='26' WHERE name='Goblins_Bats' AND groupid='26' AND zoneid='166';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Gloom_Eye' AND groupid='13' AND zoneid='166';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Mucoid_Mass' AND groupid='19' AND zoneid='166';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Hyakume' AND groupid='31' AND zoneid='166';

-- ------------------------------------------------------------
-- Bostaunieux_Oubliette (Zone 167)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='55',maxLevel='59' WHERE name='Blind_Bat' AND groupid='14' AND zoneid='167';
UPDATE mob_groups SET minLevel='60',maxLevel='68' WHERE name='Panna_Cotta' AND groupid='15' AND zoneid='167';
UPDATE mob_groups SET minLevel='68',maxLevel='70' WHERE name='Nachtmahr' AND groupid='16' AND zoneid='167';
UPDATE mob_groups SET minLevel='64',maxLevel='66' WHERE name='Dabilla' AND groupid='17' AND zoneid='167';
UPDATE mob_groups SET minLevel='69',maxLevel='74' WHERE name='Wurdalak' AND groupid='18' AND zoneid='167';

-- ------------------------------------------------------------
-- Toraimarai_Canal (Zone 169)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='57',maxLevel='59' WHERE name='Blackwater_Pugil' AND groupid='21' AND zoneid='169';
UPDATE mob_groups SET minLevel='60',maxLevel='62' WHERE name='Plunderer_Crab' AND groupid='22' AND zoneid='169';
UPDATE mob_groups SET minLevel='58',maxLevel='60' WHERE name='Deviling_Bats' AND groupid='25' AND zoneid='169';
UPDATE mob_groups SET minLevel='65',maxLevel='67' WHERE name='Sodden_Bones' AND groupid='26' AND zoneid='169';
UPDATE mob_groups SET minLevel='65',maxLevel='67' WHERE name='Drowned_Bones' AND groupid='27' AND zoneid='169';
UPDATE mob_groups SET minLevel='65',maxLevel='67' WHERE name='Starborer' AND groupid='28' AND zoneid='169';
UPDATE mob_groups SET minLevel='65',maxLevel='67' WHERE name='Rapier_Scorpion' AND groupid='29' AND zoneid='169';
UPDATE mob_groups SET minLevel='66',maxLevel='69' WHERE name='Poroggo_Excavator' AND groupid='32' AND zoneid='169';
UPDATE mob_groups SET minLevel='64',maxLevel='67' WHERE name='Flume_Toad' AND groupid='33' AND zoneid='169';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Canal_Moocher' AND groupid='21' AND zoneid='169';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Konjac' AND groupid='27' AND zoneid='169';

-- ------------------------------------------------------------
-- Zeruhn_Mines (Zone 172)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='2',maxLevel='4' WHERE name='Burrower_Worm' AND groupid='2' AND zoneid='172';
UPDATE mob_groups SET minLevel='2',maxLevel='4' WHERE name='Colliery_Bat' AND groupid='3' AND zoneid='172';
UPDATE mob_groups SET minLevel='3',maxLevel='5' WHERE name='Soot_Crab' AND groupid='4' AND zoneid='172';
UPDATE mob_groups SET minLevel='3',maxLevel='6' WHERE name='Veindigger_Leech' AND groupid='6' AND zoneid='172';

-- ------------------------------------------------------------
-- Korroloka_Tunnel (Zone 173)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='29',maxLevel='32' WHERE name='Lacerator' AND groupid='18' AND zoneid='173';
UPDATE mob_groups SET minLevel='28',maxLevel='31' WHERE name='Spool_Leech' AND groupid='19' AND zoneid='173';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Thoon' AND groupid='27' AND zoneid='173';

-- ------------------------------------------------------------
-- Lower_Delkfutts_Tower (Zone 184)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Tyrant' AND groupid='14' AND zoneid='184';

-- ------------------------------------------------------------
-- King_Ranperres_Tomb (Zone 190)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='58',maxLevel='60' WHERE name='Tomb_Worm' AND groupid='26' AND zoneid='190';
UPDATE mob_groups SET minLevel='62',maxLevel='64' WHERE name='Ogre_Bat' AND groupid='27' AND zoneid='190';
UPDATE mob_groups SET minLevel='63',maxLevel='65' WHERE name='Cutlass_Scorpion' AND groupid='28' AND zoneid='190';
UPDATE mob_groups SET minLevel='64',maxLevel='66' WHERE name='Bonnet_Beetle' AND groupid='36' AND zoneid='190';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Gwyllgi' AND groupid='17' AND zoneid='190';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Ankou' AND groupid='21' AND zoneid='190';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Barbastelle' AND groupid='22' AND zoneid='190';

-- ------------------------------------------------------------
-- Dangruf_Wadi (Zone 191)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Goblin_Brigand' AND groupid='19' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Goblin_Headsman' AND groupid='20' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Goblin_Healer' AND groupid='21' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Witchetty_Grub' AND groupid='22' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Couloir_Leech' AND groupid='23' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Prim_Pika' AND groupid='24' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Natty_Gibbon' AND groupid='25' AND zoneid='191';
UPDATE mob_groups SET minLevel='16',maxLevel='20' WHERE name='Trimmer' AND groupid='26' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Fume_Lizard' AND groupid='27' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Goblin_Conjurer' AND groupid='28' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Goblin_Bladesmith' AND groupid='29' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Goblin_Bushwhacker' AND groupid='30' AND zoneid='191';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Teporingo' AND groupid='10' AND zoneid='191';

-- ------------------------------------------------------------
-- Inner_Horutoto_Ruins (Zone 192)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='12',maxLevel='15' WHERE name='Troika_Bats' AND groupid='6' AND zoneid='192';
UPDATE mob_groups SET minLevel='11',maxLevel='16' WHERE name='Deathwatch_Beetle' AND groupid='7' AND zoneid='192';
UPDATE mob_groups SET minLevel='20',maxLevel='23' WHERE name='Goblin_Flesher' AND groupid='8' AND zoneid='192';
UPDATE mob_groups SET minLevel='20',maxLevel='23' WHERE name='Goblin_Metallurgist' AND groupid='9' AND zoneid='192';
UPDATE mob_groups SET minLevel='20',maxLevel='23' WHERE name='Goblin_Lurcher' AND groupid='10' AND zoneid='192';
UPDATE mob_groups SET minLevel='25',maxLevel='28' WHERE name='Skinnymalinks' AND groupid='11' AND zoneid='192';
UPDATE mob_groups SET minLevel='25',maxLevel='28' WHERE name='Skinnymajinx' AND groupid='12' AND zoneid='192';
UPDATE mob_groups SET minLevel='17',maxLevel='20' WHERE name='Covin_Bat' AND groupid='13' AND zoneid='192';
UPDATE mob_groups SET minLevel='20',maxLevel='23' WHERE name='Goblin_Trailblazer' AND groupid='14' AND zoneid='192';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Nocuous_Weapon' AND groupid='25' AND zoneid='192';

-- ------------------------------------------------------------
-- Ordelles_Caves (Zone 193)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='23',maxLevel='26' WHERE name='Buds_Bunny' AND groupid='18' AND zoneid='193';
UPDATE mob_groups SET minLevel='25',maxLevel='27' WHERE name='Bilis_Leech' AND groupid='19' AND zoneid='193';
UPDATE mob_groups SET minLevel='27',maxLevel='29' WHERE name='Swagger_Spruce' AND groupid='24' AND zoneid='193';
UPDATE mob_groups SET minLevel='29',maxLevel='31' WHERE name='Targe_Beetle' AND groupid='25' AND zoneid='193';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Donggu' AND groupid='14' AND zoneid='193';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Agar_Agar' AND groupid='23' AND zoneid='193';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Bombast' AND groupid='44' AND zoneid='193';

-- ------------------------------------------------------------
-- Outer_Horutoto_Ruins (Zone 194)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='15',maxLevel='18' WHERE name='Fetor_Bats' AND groupid='8' AND zoneid='194';
UPDATE mob_groups SET minLevel='23',maxLevel='25' WHERE name='Fuligo' AND groupid='9' AND zoneid='194';
UPDATE mob_groups SET minLevel='20',maxLevel='23' WHERE name='Thorn_Bat' AND groupid='14' AND zoneid='194';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Desmodont' AND groupid='5' AND zoneid='194';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Legalox_Heftyhind' AND groupid='7' AND zoneid='194';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Ah_Puch' AND groupid='13' AND zoneid='194';

-- ------------------------------------------------------------
-- The_Eldieme_Necropolis (Zone 195)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='60',maxLevel='63' WHERE name='Hellbound_Warrior' AND groupid='15' AND zoneid='195';
UPDATE mob_groups SET minLevel='60',maxLevel='63' WHERE name='Hellbound_Warlock' AND groupid='16' AND zoneid='195';
UPDATE mob_groups SET minLevel='53',maxLevel='55' WHERE name='Nekros_Hound' AND groupid='32' AND zoneid='195';

-- ------------------------------------------------------------
-- Gusgen_Mines (Zone 196)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='26',maxLevel='30' WHERE name='Accursed_Soldier' AND groupid='23' AND zoneid='196';
UPDATE mob_groups SET minLevel='23',maxLevel='27' WHERE name='Accursed_Sorcerer' AND groupid='24' AND zoneid='196';
UPDATE mob_groups SET minLevel='27',maxLevel='30' WHERE name='Madfly' AND groupid='25' AND zoneid='196';
UPDATE mob_groups SET minLevel='23',maxLevel='26' WHERE name='Rockmill' AND groupid='26' AND zoneid='196';

-- ------------------------------------------------------------
-- Crawlers_Nest (Zone 197)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='47',maxLevel='49' WHERE name='King_Crawler' AND groupid='16' AND zoneid='197';
UPDATE mob_groups SET minLevel='55',maxLevel='57' WHERE name='Vespo' AND groupid='17' AND zoneid='197';
UPDATE mob_groups SET minLevel='50',maxLevel='53' WHERE name='Dancing_Jewel' AND groupid='18' AND zoneid='197';
UPDATE mob_groups SET minLevel='51',maxLevel='54' WHERE name='Olid_Funguar' AND groupid='19' AND zoneid='197';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Dynast_Beetle' AND groupid='23' AND zoneid='197';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Aqrabuamelu' AND groupid='36' AND zoneid='197';

-- ------------------------------------------------------------
-- Maze_of_Shakhrami (Zone 198)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='24',maxLevel='28' WHERE name='Bleeder_Leech' AND groupid='18' AND zoneid='198';
UPDATE mob_groups SET minLevel='23',maxLevel='26' WHERE name='Chaser_Bats' AND groupid='21' AND zoneid='198';
UPDATE mob_groups SET minLevel='29',maxLevel='31' WHERE name='Crypterpillar' AND groupid='22' AND zoneid='198';
UPDATE mob_groups SET minLevel='26',maxLevel='29' WHERE name='Warren_Bat' AND groupid='23' AND zoneid='198';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Trembler_Tabitha' AND groupid='9' AND zoneid='198';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Gloombound_Lurker' AND groupid='26' AND zoneid='198';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Lesath' AND groupid='31' AND zoneid='198';

-- ------------------------------------------------------------
-- Garlaige_Citadel (Zone 200)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='53',maxLevel='55' WHERE name='Fortalice_Bats' AND groupid='15' AND zoneid='200';
UPDATE mob_groups SET minLevel='52',maxLevel='53' WHERE name='Kaboom' AND groupid='29' AND zoneid='200';
UPDATE mob_groups SET minLevel='56',maxLevel='58' WHERE name='Warden_Beetle' AND groupid='35' AND zoneid='200';
UPDATE mob_groups SET minLevel='53',maxLevel='55' WHERE name='Donjon_Bat' AND groupid='40' AND zoneid='200';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Hazmat' AND groupid='17' AND zoneid='200';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Hovering_Hotpot' AND groupid='34' AND zoneid='200';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Frogamander' AND groupid='39' AND zoneid='200';

-- ------------------------------------------------------------
-- FeiYin (Zone 204)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='55',maxLevel='57' WHERE name='Wekufe' AND groupid='16' AND zoneid='204';
UPDATE mob_groups SET minLevel='56',maxLevel='58' WHERE name='Sentient_Carafe' AND groupid='17' AND zoneid='204';
UPDATE mob_groups SET minLevel='51',maxLevel='54' WHERE name='Balayang' AND groupid='18' AND zoneid='204';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Mind_Hoarder' AND groupid='11' AND zoneid='204';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Sluagh' AND groupid='5' AND zoneid='204';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Jenglot' AND groupid='7' AND zoneid='204';
