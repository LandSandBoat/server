----------------------------------------------------------------------------------------------------
--                                      Dynamis-Bastok                                            --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/bas.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/bas.html        --
--                       NOTE: Please refer to instructions for setup.                            --
----------------------------------------------------------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
----------------------------------------------------------------------------------------------------
--                                      Instructions                                              --
----------------------------------------------------------------------------------------------------
-- CAUTION: Wherever a value is skipped insert nil.
--
-- 1. MobIndex information is derrived from the group ID used in Enedin.
--    Note: All mob indexes should have a comment with the full group ID.
--    Ex. 001-G should be converted to 1.
--    Ex. 054-Q should be converted to 54.
--
-- 2. Setup wave spawning based on MobIndex where applicable. Wave 1 is always spawned at the start.
--    Ex. mobList[zone].waves = { MobIndex, MobIndex, MobIndex }
--    Ex. mobList[zone].waves2 = { 1, 7, 12 }
--
-- 3. Setup wave spawning requirements. This is handled through a localvar set on the zone based on
--    the onMobDeath() function of the NM. By default this will only be the MegaBoss.
--    mobList[zone].waveDefeatRequirements[2] = {zone:getLocalVar("MegaBoss_Killed") == 1}
--
-- 4. Setup mob positions for spawns. This is only required for statues and mobs that do not spawn
--    from a statue, NM, or nightmare mob.
--    Ex. mobList[zone][MobIndex].pos = {xpos, ypos, zpos, rot}
--
-- 5. mobList[zone][MobIndex].info should be used to indicate the mob type and name.
--    Mob type indicates spawning pattern used. Mob Name will replace the name dynamically.
--    Mob Family is only required for beastmen NMs. Main Job is only required for beastmen NMs.
--    NOTE: These should only be made for non-standard/zone specific mobs.
--    Statue Ex. mobList[zone][MobIndex].info = {"Statue", "Sergeant Tombstone", nil, nil, nil}
--    Nightmare Ex. mobList[zone][MobIndex].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil}
--    Non-beastman NM Ex. mobList[zone][MobIndex].info = {"NM", "Apocalyptic Beast", nil, nil, "Apocalyptic_Beast_killed"}
--    Beastmen NM Ex. mobList[zone][MobIndex].info = {"NM", "ElvaanSticker Bxafraff", "Orc", "DRG", "ElvaanSticker_Bxafraff_killed"}
--
-- 6. mobList[zone][MobIndex].mobchildren is used to determine the number of each job to spawn.
--    To spawn a certain job, just put in the number of that job in the order of the job list 1-15.
--    This system will automatically determine what family each of these jobs encode to.
--    For Nightmare mob spawns, simply encode the number of children in mobList[zone][MobIndex].mobchildren[1] (aka #WAR).
--    Ex. mobList[zone][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}
--    Ex. For 2 Wars: mobList[zone][MobIndex].mobchildren = {2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil}
--
-- 7.  mobList[zone][MobIndex].NMchildren is used to spawn specific NMs outlined in mobList[zone][MobIndex].info
--     MobIndex is the index of the mob spawning the NM, MobIndex(NM) points to which NM in .info it should spawn.
--     Ex. mobList[zone][MobIndex].NMchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
--
-- 8. mobList[zone][MobIndex].patrolPath is used to set a specific path for a mob, if left blank for that MobIndex,
--    the mob will not path on a predetermined course. If it is a statue, it will not path at all. You can add
--    as many triplets of coordinates as desired.
--    Ex. mobList[zone][MobIndex].patrolPath = {xpos1,ypos1,zpos1, xpos2,ypos2,zpos2,  xpos3,ypos3,zpos3}
--
-- 9. mobList[zone][MobIndex].eyes sets the eye color of the statue. Valid options are:
--    xi.dynamis.eyesEra.RED, xi.dynamis.eyesEra.BLUE, xi.dynamis.eyesEra.GREEN
--    Ex. mobList[zone][MobIndex].eyes = xi.dynamis.eyesEra.BLUE -- Flags for blue eyes. (HP)
--    Ex. mobList[zone][MobIndex].eyes = xi.dynamis.eyesEra.GREEN -- Flags for green eyes. (MP)
--    Ex. mobList[zone][MobIndex].eyes = xi.dynamis.eyesEra.RED -- Flags for red eyes. (TE)
--
-- 10. mobList[zone][MobIndex].timeExtension dictates the amount of time given for the TE.
--    Ex. mobList[zone][MobIndex].timeExtension = 15
--
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
--                               Dependency Setup Section (IGNORE)                                --
----------------------------------------------------------------------------------------------------
local zone = xi.zone.DYNAMIS_BASTOK
local i = 0
mobList = mobList or { }
mobList[zone] = { } -- Ignore me, I just start the table.
mobList[zone].zoneID = zone -- Ignore me, I just ensure .zoneID exists.
mobList[zone].waveDefeatRequirements = { } -- Ignore me, I just start the table.
mobList[zone].waveDefeatRequirements[1] = { } -- Ignore me, I just allow for wave 1 spawning.
mobList[zone].maxWaves = 3 -- Ignore me because Oph told me to

-- Used to populate mobList with dummy index values.
while i < 400 do
    table.insert(mobList[zone], i, { id = i})
    i = i + 1
end

----------------------------------------------------------------------------------------------------
--                                  Setup of Parent Spawning                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--               Mob Info               --
-- Note: Primarily used for mobs that   --
-- are NMs or parent mobs.              --
------------------------------------------
--mobList[zone][MobIndex].info = {"Statue/NM/Nightmare", "Mob Name", "Family", "Main Job", "MobLocalVarName"}

mobList[zone][1  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 001-Q(20)
mobList[zone][2  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 002-Q
mobList[zone][3  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 003-Q
mobList[zone][4  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 004-Q
mobList[zone][5  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 005-Q
mobList[zone][6  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 006-Q
mobList[zone][7  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 007-Q(HP)
mobList[zone][8  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 008-Q(HP)
mobList[zone][9  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 009-Q
mobList[zone][10 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 010-Q
mobList[zone][11 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 011-Q
mobList[zone][12 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 012-Q
mobList[zone][13 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 013-Q
mobList[zone][14 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 014-Q
mobList[zone][15 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 015-Q
mobList[zone][16 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 016-Q
mobList[zone][17 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 017-Q
mobList[zone][18 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 018-Q
mobList[zone][19 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 019-Q(20)
mobList[zone][20 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 020-Q
mobList[zone][21 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 021-Q
mobList[zone][22 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 022-Q
mobList[zone][23 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 023-Q
mobList[zone][24 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 024-Q
mobList[zone][25 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 025-Q(HP)
mobList[zone][26 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 026-Q(MP)
mobList[zone][27 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 027-Q
mobList[zone][28 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 028-Q
mobList[zone][29 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 029-Q
mobList[zone][30 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 030-Q
mobList[zone][31 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 031-Q(MP)
mobList[zone][32 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 032-Q
mobList[zone][33 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 033-Q
mobList[zone][34 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 034-Q
mobList[zone][35 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 035-Q
mobList[zone][36 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 036-Q
mobList[zone][37 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 037-Q
mobList[zone][38 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 038-Q(MP)
mobList[zone][39 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 039-Q(HP)
mobList[zone][40 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 040-Q
mobList[zone][41 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 041-Q(20)
mobList[zone][42 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 042-Q(HP)
mobList[zone][43 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 043-Q
mobList[zone][44 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 044-Q
mobList[zone][45 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 045-Q
mobList[zone][46 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 046-Q
mobList[zone][47 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 047-Q
mobList[zone][48 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 048-Q
mobList[zone][49 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 049-Q
mobList[zone][50 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 050-Q
mobList[zone][51 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 051-Q
mobList[zone][52 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 052-Q
mobList[zone][53 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 053-Q
mobList[zone][54 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 054-Q
mobList[zone][55 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 055-Q
mobList[zone][56 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 056-Q
mobList[zone][57 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 057-Q
mobList[zone][58 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 058-Q
mobList[zone][59 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 059-Q
mobList[zone][60 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 060-Q
mobList[zone][61 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 061-Q
mobList[zone][62 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 062-Q
mobList[zone][63 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 063-Q
mobList[zone][64 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 064-Q
mobList[zone][65 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 065-Q
mobList[zone][66 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 066-Q
mobList[zone][67 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 067-Q
mobList[zone][68 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 068-Q
mobList[zone][69 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 069-Q
mobList[zone][70 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 070-Q
mobList[zone][71 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 071-Q
mobList[zone][72 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 072-Q
mobList[zone][73 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 073-Q
mobList[zone][74 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 074-Q
mobList[zone][75 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 075-Q
mobList[zone][76 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 076-Q
mobList[zone][77 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 077-Q
mobList[zone][78 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 078-Q
mobList[zone][79 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 079-Q
mobList[zone][80 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 080-Q(MP)
mobList[zone][81 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 081-Q
mobList[zone][82 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 082-Q(HP)
mobList[zone][83 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 083-Q
mobList[zone][84 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 084-Q
mobList[zone][85 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 085-Q(HP)
mobList[zone][86 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 086-Q
mobList[zone][87 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 087-Q
mobList[zone][88 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 088-Q
mobList[zone][89 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 089-Q
mobList[zone][90 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 090-Q
mobList[zone][91 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 091-Q
mobList[zone][92 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 092-Q(HP)
mobList[zone][93 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 093-Q
mobList[zone][94 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 094-Q(HP)
mobList[zone][95 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 095-Q
mobList[zone][96 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 096-Q
mobList[zone][97 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 097-Q
mobList[zone][98 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 098-Q
mobList[zone][99 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 099-Q
mobList[zone][100].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 100-Q
mobList[zone][101].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 101-Q
mobList[zone][102].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 102-Q
mobList[zone][103].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 103-Q
mobList[zone][104].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 104-Q(MP)
mobList[zone][105].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 105-Q
mobList[zone][106].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 106-Q
mobList[zone][107].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 107-Q
mobList[zone][108].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 108-Q
mobList[zone][109].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 109-Q
mobList[zone][111].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 111-Q
mobList[zone][112].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 112-Q(HP)
mobList[zone][113].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 113-Q
mobList[zone][114].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 114-Q(MP)
mobList[zone][115].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 115-Q
mobList[zone][116].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 116-Q(HP)
mobList[zone][117].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 117-Q
mobList[zone][118].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 118-Q
mobList[zone][119].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 119-Q(HP)
mobList[zone][120].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 120-Q(HP)
mobList[zone][121].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 121-Q(MP)
mobList[zone][122].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 122-Q(HP)
mobList[zone][123].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 123-Q
mobList[zone][124].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 124-Q(HP)
mobList[zone][125].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 125-Q(MP)
mobList[zone][126].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 126-Q
mobList[zone][127].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 127-Q(MP)
mobList[zone][128].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 128-Q
mobList[zone][129].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 129-Q(MP)
mobList[zone][130].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 130-Q
mobList[zone][131].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 131-Q
mobList[zone][132].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 132-Q(HP)
mobList[zone][133].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 133-Q(HP)
mobList[zone][134].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 134-Q
mobList[zone][135].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 135-Q
mobList[zone][136].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 136-Q(MP)
mobList[zone][137].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 137-Q(MP)
mobList[zone][138].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 138-Q(HP)
mobList[zone][139].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 139-Q(HP)
mobList[zone][140].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 140-Q
mobList[zone][141].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 141-Q
mobList[zone][142].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- 142-Q

-- NM's and Megaboss Quadav
mobList[zone][110].info = {"NM", "Gu'Dha Effigy", nil, nil, "MegaBoss_Killed"} -- 110-Replica NM (Gu'Dha Effigy)(30)

mobList[zone][151].info = {"NM", "Aa'Nyu Dismantler",       "Quadav", "DRK", "AaNyu_killed"} -- Aa'Nyu Dismantler
mobList[zone][152].info = {"NM", "Be'Ebo Tortoisedriver",   "Quadav", "BST", "BeEbo_killed"} -- Be'Ebo Tortoisedriver
mobList[zone][153].info = {"NM", "Gi'Pha Manameister",      "Quadav", "BLM", "GiPha_killed"} -- Gi'Pha Manameister
mobList[zone][154].info = {"NM", "Gu'Nhi Noondozer",        "Quadav", "SMN", "GuNhi_killed"} -- Gu'Nhi Noondozer
mobList[zone][155].info = {"NM", "Ze'Vho Fallsplitter",     "Quadav", "DRK", "ZeVho_killed"} -- Ze'Vho Fallsplitter
mobList[zone][156].info = {"NM", "Ko'Dho Cannonball",       "Quadav", "MNK", "KoDho_killed"} -- Ko'Dho Cannonball

mobList[zone][157].info = {"NM", "Effigy Shield", "Quadav", "PLD", nil } -- Effigy Shield
mobList[zone][158].info = {"NM", "Effigy Shield", "Quadav", "NIN", nil } -- Effigy Shield
mobList[zone][159].info = {"NM", "Effigy Shield", "Quadav", "BRD", nil } -- Effigy Shield
mobList[zone][160].info = {"NM", "Effigy Shield", "Quadav", "DRK", nil } -- Effigy Shield
mobList[zone][161].info = {"NM", "Effigy Shield", "Quadav", "SAM", nil } -- Effigy Shield

mobList[zone][162].info = {nil, "Vanguard Vindicator", "Quadav", "WAR", nil } -- 10min TE
mobList[zone][163].info = {nil, "Vanguard Constable", "Quadav", "WHM", nil } -- 10min TE
mobList[zone][164].info = {nil, "Vanguard Militant", "Quadav", "MNK", nil } -- 10min TE


----------------------------------------------------------------------------------------------------
--                                    Setup of Wave Spawning                                      --
----------------------------------------------------------------------------------------------------

---------------------------------------------
--           Wave Defeat Reqs.          --
--------------------------------------------
--mobList[zone].waveDefeatRequirements[2] = {zone:getLocalVar("MegaBoss_Killed") == 1}
mobList[zone].waveDefeatRequirements[2] = { zone:getLocalVar("KoDho_killed") == 1, zone:getLocalVar("GiPha_killed") == 1, zone:getLocalVar("ZeVho_killed") == 1 } -- 3 NMS to spawn boss
mobList[zone].waveDefeatRequirements[3] = { zone:getLocalVar("MegaBoss_Killed") == 1 } -- Spawans wave after megaboss dies

------------------------------------------
--            Wave Spawning             --
-- Note: Wave 1 spawns at start.        --
------------------------------------------
--mobList[zone].wave# = { MobIndex#1, MobIndex#2, MobIndex#3 }

mobList[zone].wave1 = {
    1  , -- 001-G/R
    2  , -- 002-G/R(30)
    3  , -- 003-G/R
    4  , -- 004-G/R(30)
    5  , -- 005-G/R(HP)
    6  , -- 006-G/R
    7  , -- 007-G/R
    8  , -- 008-G/R
    9  , -- 009-G/R(MP)
    10 , -- 010-G/R
    11 , -- 011-G/R(HP)
    12 , -- 012-G/R(MP)
    13 , -- 013-G/R
    14 , -- 014-G/R
    15 , -- 015-G/R
    16 , -- 016-G/R(HP)
    17 , -- 017-G/R(MP)
    18 , -- 018-G/R
    19 , -- 019-G/R
    20 , -- 020-G/R
    21 , -- 021-G/R
    22 , -- 022-G/R
    23 , -- 023-G/R(HP)
    24 , -- 024-G/R(MP)
    25 , -- 025-G/R(MP)
    27 , -- 027-G/R
    28 , -- 028-G/R
    32 , -- 032-G/R
    33 , -- 033-G/R
    34 , -- 034-G/R
    35 , -- 035-G/R
    36 , -- 036-G/R
    37 , -- 037-G/R
    38 , -- 038-G/R
    39 , -- 039-G/R(MP)
    40 , -- 040-G/R(HP)
    41 , -- 041-G/R
    42 , -- 042-G/R
    43 , -- 043-G/R
    44 , -- 044-G/S(MP)
    45 , -- 045-G/R(30)
    46 , -- 046-G/R
    47 , -- 047-G/R
    48 , -- 048-G/R
    49 , -- 049-G/R
    50 , -- 050-G/R
    51 , -- 051-G/R
    52 , -- 052-G/R
    53 , -- 053-G/R
    55 , -- 055-G/R
    56 , -- 056-G/R(MP)
    57 , -- 057-G/R(HP)
    58 , -- 058-G/R
    59 , -- 059-G/R
    60 , -- 060-G/R
    61 , -- 061-G/R
    62 , -- 062-G/R(MP)
    63 , -- 063-G/R(HP)
    64 , -- 064-G/S(MP)
    65 , -- 065-G/R(HP)
    66 , -- 066-G/R
    67 , -- 067-G/R(MP)
    68 , -- 068-G/R(HP)
    69 , -- 069-G/R
    70 , -- 070-G/R
    71 , -- 071-G/R
    72 , -- 072-G/R
    73 , -- 073-G/R
    74 , -- 074-G/R
    75 , -- 075-G/R
    76 , -- 076-G/R(MP)
    77 , -- 077-G/R(HP)
    78 , -- 078-G/R(MP)
    79 , -- 079-G/R(HP)
    80 , -- 080-G/R(HP)
    81 , -- 081-G/R(MP)
    82 , -- 082-G/R(MP)
    83 , -- 083-G/R(HP)
    84 , -- 084-G/R(HP)
    85 , -- 085-G/R(MP)
    86 , -- 086-G/R
    87 , -- 087-G/R
    88 , -- 088-G/R
    90 , -- 090-G/R
    91 , -- 091-G/R
    93 , -- 093-G/R(HP)
    94 , -- 094-G/R(MP)
    95 , -- 095-G/R(MP)
    96 , -- 096-G/R
    97 , -- 097-G/R
    98 , -- 098-G/R
    99 , -- 099-G/R
    100, -- 100-G/R
    101, -- 101-G/R(MP)
    102, -- 102-G/R(HP)
    103, -- 103-G/R
    104, -- 104-G/R
    105, -- 105-G/R
    106, -- 106-G/R
    107, -- 107-G/R
    108, -- 108-G/R
    109  -- 109-G/R
}

mobList[zone].wave2 = {
    110, -- 110-G/R
    111  -- 111-G/R
}

mobList[zone].wave3 = {
    112, -- 112-G/R
    113, -- 113-Replica NM (Goblin Golem)(30)
    114, -- 114-G/R
    115, -- 115-G/R
    116, -- 116-G/R
    117, -- 117-G/R
    118, -- 118-G/R(MP)
    119, -- 119-G/R(HP)
    120, -- 120-G/R
    121, -- 121-G/R
    122, -- 122-G/R(MP)
    123, -- 123-G/R(HP)
    124, -- 124-G/R
    125, -- 125-G/R
    126, -- 126-G/R(HP)
    127, -- 127-G/R(MP)
    128, -- 128-G/R(HP)
    129, -- 129-G/R(MP)
    130, -- 130-G/R
    131, -- 131-G/R
    132, -- 132-G/R
    133, -- 133-G/R
    134, -- 134-G/R
    135, -- 135-G/R
    136, -- 136-G/R
    137, -- 137-G/R
    138, -- 138-G/R
    139, -- 139-G/R
    140, -- 140-G/R
    141, -- 141-G/R
    142  -- 142-G/R
}

----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- mobList[zone][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

mobList[zone][1  ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 BLM  1 NIN
mobList[zone][2  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil  }  -- 1 BRD  1 SAM
mobList[zone][3  ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 RDM
mobList[zone][4  ].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 THF
mobList[zone][5  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil  }  -- 1 BRD  1 DRG
mobList[zone][6  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  -- 2 BST
mobList[zone][7  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  -- 2 BST
mobList[zone][8  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  -- 2 BST
mobList[zone][9  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil  }  -- 1 BRD  1 SAM
mobList[zone][10 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil  }  -- 1 BRD  1 SAM
mobList[zone][11 ].mobchildren = {   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 WAR  1 BLM  1 NIN
mobList[zone][12 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil,   1, nil  }  -- 1 BRD  1 SAM  1 DRG
mobList[zone][13 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 WHM  1 NIN
mobList[zone][14 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 1 BLM  1 DRK
mobList[zone][16 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 RDM
mobList[zone][18 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 THF
mobList[zone][20 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil  }  -- 1 BLM  1 DRK  1 NIN
mobList[zone][21 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 RDM  1 DRG
mobList[zone][22 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil  }  -- 1 DRK  1 BRD
mobList[zone][23 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 BLM  1 SAM
mobList[zone][24 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }  -- 1 MNK  1 RNG
mobList[zone][25 ].mobchildren = {   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 WHM
mobList[zone][27 ].mobchildren = { nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 RDM  1 THF
mobList[zone][29 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 PLD  1 NIN
mobList[zone][30 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 WAR  1 SAM
mobList[zone][31 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  -- 1 BLM  1 BRD
mobList[zone][32 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil  }  -- 1 WHM  1 DRK  1 NIN
mobList[zone][33 ].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 THF
mobList[zone][34 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 WHM  1 SAM
mobList[zone][35 ].mobchildren = { nil,   1, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil  }  -- 1 MNK  1 PLD  1 BRD
mobList[zone][36 ].mobchildren = { nil,   1, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 MNK  1 RDM  1 PLD
mobList[zone][37 ].mobchildren = { nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 RDM  1 PLD  1 NIN
mobList[zone][40 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  }  -- 1 SMN
mobList[zone][42 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  -- 2 BST
mobList[zone][43 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 BLM  1 SAM
mobList[zone][45 ].mobchildren = {   1,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 MNK  1 RDM
mobList[zone][46 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 WAR  1 RDM  1 SAM
mobList[zone][47 ].mobchildren = { nil,   1, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 1 MNK  1 RDM  1 DRK
mobList[zone][48 ].mobchildren = { nil, nil, nil,   1, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 BLM  1 THF  1 PLD
mobList[zone][49 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 NIN
mobList[zone][50 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  -- 1 WAR  1 BRD
mobList[zone][51 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil  }  -- 1 RDM  1 NIN  1 DRG
mobList[zone][52 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil,   1, nil, nil, nil  }  -- 1 DRK  1 BRD  1 SAM
mobList[zone][53 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WHM
mobList[zone][55 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WHM
mobList[zone][56 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  }  -- 1 SMN
mobList[zone][57 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  }  -- 1 SMN
mobList[zone][58 ].mobchildren = {   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 MNK  1 WHM
mobList[zone][59 ].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 THF
mobList[zone][60 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 1 MNK  1 WHM  1 DRK
mobList[zone][61 ].mobchildren = { nil,   1,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 MNK  1 WHM  1 PLD
mobList[zone][62 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WHM
mobList[zone][63 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 MNK  1 WHM  1 DRG
mobList[zone][64 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil,   1  }  -- 1 DRK  1 BST  1 SMN
mobList[zone][65 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil  }  -- 1 MNK  1 DRK  1 BRD
mobList[zone][66 ].mobchildren = {   1, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 RDM  1 THF
mobList[zone][68 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 BLM  1 PLD  1 SAM
mobList[zone][69 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WHM
mobList[zone][70 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  }  -- 2 RNG
mobList[zone][71 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }  -- 1 RNG
mobList[zone][72 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 THF  1 DRG
mobList[zone][73 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil  }  -- 1 DRK  1 SAM
mobList[zone][75 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 PLD  1 NIN
mobList[zone][76 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  -- 1 WAR  1 BRD
mobList[zone][77 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 BLM  1 DRG
mobList[zone][78 ].mobchildren = { nil,   1, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 MNK  1 BLM  1 PLD
mobList[zone][79 ].mobchildren = { nil,   1, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 1 MNK  1 BLM  1 DRK
mobList[zone][82 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 NIN
mobList[zone][83 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 PLD  1 NIN
mobList[zone][86 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 WAR  1 NIN
mobList[zone][87 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil,   1, nil, nil, nil  }  -- 1 DRK  1 BRD  1 SAM
mobList[zone][88 ].mobchildren = { nil,   2, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 2 MNK  1 DRK
-- mobList[zone][89 ].mobchildren = {   1,   1,   1,   1, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  }  -- (1 WAR  1 MNK  1 WHM) These 3 are TEs  1 BLM  2 RNG
mobList[zone][89 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  }  -- 1 WAR  1 MNK  1 WHM  1 BLM  2 RNG
mobList[zone][90 ].mobchildren = { nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WHM  1 PLD
mobList[zone][91 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WHM
mobList[zone][93 ].mobchildren = { nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 MNK  1 THF  1 DRG
mobList[zone][95 ].mobchildren = { nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 THF  1 PLD
mobList[zone][96 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 RDM  1 NIN
mobList[zone][97 ].mobchildren = { nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 BLM  1 THF
mobList[zone][98 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil  }  -- 1 BRD  1 NIN
mobList[zone][99 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil  }  -- 1 DRK  1 BRD
mobList[zone][100].mobchildren = { nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 RDM  1 PLD
mobList[zone][101].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil  }  -- 1 SAM  1 DRG
mobList[zone][102].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 THF
mobList[zone][105].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 RDM  1 SAM
mobList[zone][106].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 BLM  1 NIN
mobList[zone][107].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 MNK  1 DRG
mobList[zone][108].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 RDM  1 DRG
mobList[zone][109].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 BLM  1 PLD
mobList[zone][112].mobchildren = {   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 3 WAR
mobList[zone][113].mobchildren = { nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 3 BLM
mobList[zone][114].mobchildren = { nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 3 MNK
mobList[zone][115].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil  }  -- 3 DRK
mobList[zone][116].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil  }  -- 3 RNG
mobList[zone][117].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil  }  -- 3 DRG
mobList[zone][118].mobchildren = { nil, nil, nil, nil, nil,   4, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 4 THF
mobList[zone][119].mobchildren = { nil, nil,   4, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 4 WHM
mobList[zone][120].mobchildren = { nil, nil, nil, nil, nil, nil,   4, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 4 PLD
mobList[zone][121].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3  }  -- 3 SMN
mobList[zone][122].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   4, nil, nil, nil  }  -- 4 SAM
mobList[zone][123].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   4, nil, nil, nil, nil, nil  }  -- 4 BRD
mobList[zone][124].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil  }  -- 3 NIN
mobList[zone][125].mobchildren = { nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 3 RDM
mobList[zone][126].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  -- 1 WAR  1 THF  1 BRD
mobList[zone][127].mobchildren = { nil, nil, nil,   1, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 1 BLM  1 PLD  1 DRK
mobList[zone][128].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }  -- 1 MNK  1 WHM  1 RNG
mobList[zone][129].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2  }  -- 2 SMN
mobList[zone][130].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 MNK  1 DRG
mobList[zone][131].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil  }  -- 1 RNG  1 DRG
mobList[zone][132].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil  }  -- 1 RNG  1 SAM  1 NIN
mobList[zone][133].mobchildren = { nil, nil, nil, nil,   1,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  -- 1 RDM  1 THF  1 BRD
mobList[zone][134].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 1 PLD  1 DRK
mobList[zone][135].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 1 PLD  1 DRK
mobList[zone][136].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil  }  -- 1 WHM  1 SAM  1 DRG
mobList[zone][137].mobchildren = {   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 WAR  1 BLM  1 DRG
mobList[zone][138].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  -- 1 THF  1 BRD
mobList[zone][139].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil  }  -- 1 RNG  1 NIN
mobList[zone][140].mobchildren = {   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 WAR  1 MNK  1 SAM
mobList[zone][141].mobchildren = { nil, nil,   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WHM  1 BLM  1 RDM
mobList[zone][142].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil  }  -- 3 BST

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- mobList[zone][MobIndex].NMchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

mobList[zone][25 ].specificChildren = { true, 26 }
mobList[zone][28 ].specificChildren = { true, 29, 30, 31 }
mobList[zone][42 ].specificChildren = { true, 152 } -- Be'Ebo Tortoisedriver (BST)
mobList[zone][53 ].specificChildren = { true, 54, 153 } -- Gi'Pha Manameister (BLM)
mobList[zone][55 ].specificChildren = { true, 154 } -- Gu'Nhi Noondozer (SMN)
mobList[zone][62 ].specificChildren = { true, 151 } -- Aa'Nyu Dismantler (DRK)
mobList[zone][69 ].specificChildren = { true, 156 } -- Ke'Dhe Cannonball (MNK)
mobList[zone][88 ].specificChildren = { true, 89 }
mobList[zone][89 ].specificChildren = { true, 162, 163, 164 } -- Vanguard Vindicator/Constable/Militant (2x 10min TEs)
mobList[zone][91 ].specificChildren = { true, 92, 155 } -- Ze'Vho Fallsplitter (DRK)
mobList[zone][110].specificChildren = { true, 111, 157, 158, 159, 160, 161 } -- Boss spawns 5 NMs (Effigy Shields) and 1 statue

------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- mobList[zone][MobIndex].pos = {xpos, ypos, zpos, rot}

mobList[zone][1  ].pos = { 81.7644, 0.0000, -71.8662, 0   } -- W1 Mog C
mobList[zone][2  ].pos = { 76.1541, 0.0000, -66.1046, 10  } -- W1 Mog N
mobList[zone][3  ].pos = { 60.4041, 0.0000, -81.5565, 8   } -- W1 Mog S
mobList[zone][4  ].pos = { 42.8057, 0.0000, -56.8658, 80  } -- W1 AH E.Alley S
mobList[zone][5  ].pos = { 38.2376, 0.0000, -42.7884, 75  } -- W1 AH E.Alley C
mobList[zone][6  ].pos = { 39.9337, 0.7986, -88.8102, 192 } -- W1 Choc C
mobList[zone][7  ].pos = { 49.9168, 0.8720, -90.7635, 182 } -- W1 Choc E
mobList[zone][8  ].pos = { 28.6896, 0.8720, -91.7210, 202 } -- W1 Choc W
mobList[zone][9  ].pos = { 19.0447, 0.0000, -71.2227, 45  } -- W1 AH EE
mobList[zone][10 ].pos = { 10.7120, 0.0000, -78.6646, 53  } -- W1 AH E
mobList[zone][11 ].pos = {  7.0503, 0.0000,-100.7739, 192 } -- W1 W of Choc
mobList[zone][12 ].pos = {  0.0159, 0.0000, -73.3527, 61  } -- W1 AH C
mobList[zone][13 ].pos = { -9.0602, 0.0000, -78.5527, 69  } -- W1 AH W
mobList[zone][14 ].pos = {-18.9468, 0.0000, -71.3164, 77  } -- W1 AH WW
mobList[zone][15 ].pos = { 16.3665,-3.0000, -54.6565, 175 } -- W1 AHtop EE
mobList[zone][16 ].pos = {  8.4347,-3.0000, -56.4465, 183 } -- W1 AHtop E
mobList[zone][17 ].pos = { -0.0019,-3.0000, -57.3668, 191 } -- W1 AHtop C
mobList[zone][18 ].pos = { -8.4375,-3.0000, -56.5214, 199 } -- W1 AHtop W
mobList[zone][19 ].pos = {-16.4125,-3.0000, -54.3911, 207 } -- W1 AHtop WW
mobList[zone][20 ].pos = {-35.5730, 0.0000, -78.3345, 9   } -- W1 SW of AH
mobList[zone][21 ].pos = {-24.4831, 0.0000, -97.2766, 192 } -- W1 S.Gate NW
mobList[zone][22 ].pos = {-10.4154,-1.0008,-106.0800, 192 } -- W1 S.Gate C
mobList[zone][23 ].pos = {-24.4167,-1.0008,-106.3167, 192 } -- W1 S.Gate W
mobList[zone][24 ].pos = { -5.6342,-1.0008,-115.6188, 192 } -- W1 S.Gate SE
mobList[zone][25 ].pos = {-16.2038,-1.0008,-122.3855, 192 } -- W1 S.Gate S
mobList[zone][26 ].pos = {-23.9244,-1.0008,-121.6056, 227 } -- W1 spawned by 330
mobList[zone][27 ].pos = {-26.3670,-1.0008,-121.4364, 192 } -- W1 S.Gate SW
mobList[zone][28 ].pos = {-37.0065, 0.0000, -56.1556, 60  } -- W1 W of AH (S)
mobList[zone][29 ].pos = {-35.4041, 0.0000, -58.2174, 60  } -- W1 spawned by 313
mobList[zone][30 ].pos = {-38.9458, 0.0000, -58.3568, 60  } -- W1 spawned by 313
mobList[zone][31 ].pos = {-37.0648, 0.0000, -53.8018, 64  } -- W1 spawned by 313
mobList[zone][32 ].pos = {-38.4296, 0.0000, -38.0029, 60  } -- W1 W of AH (C)
mobList[zone][33 ].pos = {-28.5587, 0.0000, -25.8180, 82  } -- W1 W of AH (NE)
mobList[zone][34 ].pos = {-46.8709, 0.0000, -20.4151, 49  } -- W1 W of AH (NW)
mobList[zone][35 ].pos = {  0.4871, 0.0000, -24.9742, 128 } -- W1 AH N.Alley C
mobList[zone][36 ].pos = { -4.9191, 0.0000, -17.1571, 190 } -- W1 AH N.Alley Catwalk
mobList[zone][37 ].pos = { 30.4976, 0.0000, -26.9415, 55  } -- W1 AH E.Alley N
mobList[zone][38 ].pos = {-41.0685, 0.0000,  -2.1238, 255 } -- W1 W of Boytz (S)
mobList[zone][39 ].pos = {-45.5975, 0.0000,   4.8671, 128 } -- W1 W of Boytz (C)
mobList[zone][40 ].pos = {-44.9282,-3.4933,  15.1018, 93  } -- W1 W of Boytz (N)
mobList[zone][41 ].pos = {-57.7503, 0.0000,  41.0368, 192 } -- W1 Corner Shed E
mobList[zone][42 ].pos = {-64.5615, 0.0000,  41.3409, 192 } -- W1 Corner Sheds W
mobList[zone][43 ].pos = { -21.3849, 7.0000, 31.8739, 119 } -- W1 O.St. Entr N
mobList[zone][44 ].pos = { -20.1820, 7.0000, 27.5603, 130 } -- W1 O.St. Entr S
mobList[zone][45 ].pos = {   2.0635, 7.0000, 18.2131, 159 } -- W1 O.St. NW
mobList[zone][46 ].pos = {  -2.5034, 7.0000, -6.0080, 0   } -- W1 O.St. SW
mobList[zone][47 ].pos = {  21.0685, 7.0000,  1.1670, 115 } -- W1 O.St. NE
mobList[zone][48 ].pos = {  14.0251, 7.0000, -8.5442, 192 } -- W1 O.St. SE
mobList[zone][49 ].pos = {  30.9778, 7.0000,  5.6604, 64  } -- W1 O.St. CW S.Well Base
mobList[zone][50 ].pos = {  31.0277, 0.0000, 23.8121, 64  } -- W1 O.St. CW S.Well#2
mobList[zone][51 ].pos = {  69.9420, 7.0000,  2.5947, 64  } -- W1 Alch NW
mobList[zone][52 ].pos = {  81.9570, 7.0000,  2.3986, 64  } -- W1 Alch NE
mobList[zone][53 ].pos = {  90.2082, 7.0029, -2.4041, 128 } -- W1 Alch E
mobList[zone][54 ].pos = {  90.0454, 7.0000, -5.9869, 133 } -- W1 spawned by 222
mobList[zone][55 ].pos = {  73.8867, 7.0029,-34.8135, 185 } -- W1 Gal.Dist. S
mobList[zone][56 ].pos = {  83.5793, 7.0000,-32.4353, 145 } -- W1 Gal.Dist. E
mobList[zone][57 ].pos = {  63.8661, 7.0000,-32.7333, 215 } -- W1 Gal.Dist. W
mobList[zone][58 ].pos = {-78.0000, 0.0000,   4.0000, 0   } -- W1 Under Bridge NE
mobList[zone][59 ].pos = {-74.0000, 0.0000,   0.0000, 0   } -- W1 Under Bridge E
mobList[zone][60 ].pos = {-78.0000, 0.0000,  -4.0000, 0   } -- W1 Under Bridge SE
mobList[zone][61 ].pos = {-91.2000, 0.0000,   6.0000, 0   } -- W1 Under Bridge NW
mobList[zone][62 ].pos = {-91.2000, 0.0000,  -1.0000, 0   } -- W1 Under Bridge W
mobList[zone][63 ].pos = {-91.2000, 0.0000,  -6.0000, 0   } -- W1 Under Bridge SW
mobList[zone][64 ].pos = {-108.8306, 0.0000, -9.2511, 234 } -- W1 Chokepoint/Zeruhn Sect
mobList[zone][65 ].pos = { -99.3387, 8.0000, 46.4492, 72  } -- W1 Markets S
mobList[zone][66 ].pos = {-103.6146,10.0026, 56.2027, 60  } -- W1 Markets C
mobList[zone][67 ].pos = {-111.2602,12.0000, 65.9353, 64  } -- W1 Markets W
mobList[zone][68 ].pos = { -96.7740,12.0000, 66.2248, 64  } -- W1 Markets E
mobList[zone][69 ].pos = {-104.0242,12.0000, 72.8178, 64  } -- W1 Markets N
mobList[zone][70 ].pos = {-108.1392,-0.3415,-37.2321, 189 } -- W1 Depot Ramp Base
mobList[zone][71 ].pos = { -99.4389,-8.0000,-59.8070, 127 } -- W1 Depot Ramp Top
mobList[zone][72 ].pos = { -52.6932,-8.0000,-54.5636, 106 } -- W1 Depot Balc N
mobList[zone][73 ].pos = { -52.3919,-8.0000,-66.1270, 147 } -- W1 Depot Balc C
mobList[zone][74 ].pos = { -58.0759,-8.0000,-79.5513, 194 } -- W1 Depot Balc S
mobList[zone][75 ].pos = {-128.0898,-0.5724, -0.9718, 64  } -- W1 Zer N.Ramp (NW)
mobList[zone][76 ].pos = {-133.1783,-0.5393,  4.0241, 64  } -- W1 Zer N.Ramp (SW)
mobList[zone][77 ].pos = {-133.5637, 0.0000,-31.0000, 96  } -- W1 Zer S.Clearing (NW)
mobList[zone][78 ].pos = {-122.6414, 0.0000,-43.4918, 192 } -- W1 Zer S.Clearing (N)
mobList[zone][79 ].pos = {-117.1745, 0.0000,-43.4918, 192 } -- W1 Zer S.Clearing (NE)
mobList[zone][80 ].pos = {-123.7850,-3.4933,-74.1327, 189 } -- W1 Zer S.Clearing (S)
mobList[zone][81 ].pos = {-122.9294, 0.0000,-78.9028, 165 } -- W1 Zer S.Clearing (SE)
mobList[zone][82 ].pos = {-138.1234,-11.9249,29.2820, 28  } -- W1 Zer N.Ramp (top)
mobList[zone][83 ].pos = {-147.1535, 0.0000,  4.2789, 60  } -- W1 Zer W.Clearing (NE)
mobList[zone][84 ].pos = {-155.1991, 0.0000,  2.2134, 28  } -- W1 Zer W.Clearing (N)
mobList[zone][85 ].pos = {-164.7690,-3.4933, -2.0815, 2   } -- W1 Zer W.Clearing (NW)
mobList[zone][86 ].pos = {-161.1492, 0.0000,-11.3847, 249 } -- W1 Zer W.Clearing (W)
mobList[zone][87 ].pos = {-152.0940, 0.0000,-20.0017, 245 } -- W1 Zer W.Clearing (S)
mobList[zone][88 ].pos = {-153.7795, 0.0000,-40.9650, 191 } -- W1 Zer W.Ramp Base
mobList[zone][89 ].pos = {-160.1865, 0.0000,-40.8198, 232 } -- W1 spawned by 13
mobList[zone][90 ].pos = {-175.8118,-7.7793,-21.0173, 223 } -- W1 Zer W.Ramp (S)
mobList[zone][91 ].pos = {-178.4068,-8.1360,-17.9503, 254 } -- W1 Zer W.Ramp (W)
mobList[zone][92 ].pos = {-177.2654,-8.3147,-13.5608, 17  } -- W1 spawned by 1
mobList[zone][93 ].pos = {-173.8426,-7.8933,-10.8492, 21  } -- W1 Zer W.Ramp (N)
mobList[zone][94 ].pos = {-29.5942, 0.0000,  23.0013, 0   } -- W1 N of Boytz, Catwalk
mobList[zone][95 ].pos = { -14.0588, 0.0000, 30.0374, 143 } -- W1 O.St. Entr Bridge
mobList[zone][96 ].pos = {  -0.3031, 0.0000, 37.6598, 125 } -- W1 O.St. Entr Catwalk
mobList[zone][97 ].pos = {   8.8358, 0.0000, 22.4781, 170 } -- W1 O.St. CW Enc.#1
mobList[zone][98 ].pos = {   2.1785, 0.0000, 10.0314, 154 } -- W1 O.St. CW Bridge
mobList[zone][99 ].pos = {   8.9690, 0.0000, -5.4239, 192 } -- W1 O.St. CW W Enc.#1
mobList[zone][100].pos = {   8.8837, 0.0000,-16.3382, 192 } -- W1 O.St. CW W Enc.#2
mobList[zone][101].pos = {  17.7209, 0.0000,  7.9742, 133 } -- W1 O.St. CW Enc.#2
mobList[zone][102].pos = {  36.0086, 0.0000,  8.1324, 191 } -- W1 O.St. CW Enc.#3
mobList[zone][103].pos = {  37.0316, 0.0000, 20.2594, 147 } -- W1 O.St. CW S.Well#1
mobList[zone][104].pos = {  60.1261, 0.0000,  8.1024, 129 } -- W1 O.St. CW Enc.#4
mobList[zone][105].pos = {  60.0449, 0.0000, -1.2954, 192 } -- W1 O.St. CW E Enc.#1
mobList[zone][106].pos = {  50.8795,-0.0029,-13.2487, 232 } -- W1 O.St. CW E Enc.#2
mobList[zone][107].pos = {  61.7784, 0.0000,-20.6739, 187 } -- W1 O.St. CW E Enc.#3
mobList[zone][108].pos = {  69.9259, 0.0000, 10.5869, 64  } -- W1 O.St. CW Enc.#5
mobList[zone][109].pos = {  86.0668, 0.0000, 10.5541, 64  } -- W1 O.St. CW Enc.#6
mobList[zone][110].pos = {-16.1024,-1.0008,-124.9145, 192 } -- W2 Final Boss South Gate
mobList[zone][111].pos = {-31.7986,-1.0008,-122.3744, 218 } -- W2 W of Final Boss
mobList[zone][112].pos = {-20.0432,-3.0000, -58.9616, 56  } -- W3 AH WW
mobList[zone][113].pos = {-12.3780,-3.0000, -61.4330, 89  } -- W3 AH W
mobList[zone][114].pos = {  0.1313,-3.0000, -62.5700, 66  } -- W3 AH C
mobList[zone][115].pos = { 10.7283,-3.0000, -61.6430, 30  } -- W3 AH E
mobList[zone][116].pos = { 19.1724,-3.0000, -59.4239, 67  } -- W3 AH EE
mobList[zone][117].pos = { 18.1155, 0.0000, -99.2747, 144 } -- W3 W of Choco (N)
mobList[zone][118].pos = { 16.5028, 0.0000,-110.3989, 198 } -- W3 W of Choco (C)
mobList[zone][119].pos = { 16.5175, 0.0000,-121.5445, 190 } -- W3 W of Choco (S)
mobList[zone][120].pos = {  9.4977, 0.0000,-121.5922, 201 } -- W3 far W of Choco
mobList[zone][121].pos = { 31.6634, 0.0000, -64.0405, 86  } -- W3 Alley W
mobList[zone][122].pos = { 39.7658, 0.0000, -59.6651, 64  } -- W3 Alley E
mobList[zone][123].pos = { 54.8432, 0.0000, -67.1650, 93  } -- W3 Outside Mog NW
mobList[zone][124].pos = { 64.4780, 0.0000, -66.9347, 103 } -- W3 Outside Mog N
mobList[zone][125].pos = { 76.5238, 0.0000, -67.1802, 92  } -- W3 Outside Mog NE
mobList[zone][126].pos = { 62.2124, 0.0000, -85.9488, 159 } -- W3 Outside Mog SW
mobList[zone][127].pos = { 67.9729, 0.0000, -85.3997, 171 } -- W3 Outside Mog S
mobList[zone][128].pos = { 77.0071, 0.0000, -79.6646, 140 } -- W3 Outside Mog SE
mobList[zone][129].pos = { 90.1017, 0.6234, -71.7804, 128 } -- W3 Mog Clockwise #1
mobList[zone][130].pos = { 90.4399, 0.9944, -57.0740, 66  } -- W3 Mog Clockwise #2
mobList[zone][131].pos = { 90.7621, 0.9944, -87.7146, 190 } -- W3 Mog Clockwise #12
mobList[zone][132].pos = {102.6341, 0.9944, -56.2798, 114 } -- W3 Mog Clockwise #3
mobList[zone][133].pos = {102.8179, 0.9944, -88.3096, 146 } -- W3 Mog Clockwise #11
mobList[zone][134].pos = {110.9067, 0.9944, -56.7192, 121 } -- W3 Mog Clockwise #4
mobList[zone][135].pos = {110.8669, 0.9944, -88.1171, 135 } -- W3 Mog Clockwise #10
mobList[zone][136].pos = {101.4331, 0.9944, -65.9948, 185 } -- W3 Mog N
mobList[zone][137].pos = {101.6548, 0.9944, -78.9599, 69  } -- W3 Mog S
mobList[zone][138].pos = {119.3663, 0.9944, -54.6408, 89  } -- W3 Mog Clockwise #5
mobList[zone][139].pos = {118.7241, 0.9944, -88.4772, 161 } -- W3 Mog Clockwise #9
mobList[zone][140].pos = {117.2807, 0.9944, -65.8843, 128 } -- W3 Mog Clockwise #6
mobList[zone][141].pos = {117.2807, 0.9944, -77.7863, 128 } -- W3 Mog Clockwise #8
mobList[zone][142].pos = {117.2442, 0.9944, -71.5537, 128 } -- W3 Mog Clockwise #7

----------------------------------------------------------------------------------------------------
--                                    Setup of Mob Functions                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--             Patrol Paths             --
------------------------------------------
-- mobList[zone][MobIndex].patrolPath = {xpos1,ypos1,zpos1, xpos2,ypos2,zpos2,  xpos3,ypos3,zpos3}

-- mobList[zone][8  ].patrolPath = { -96,  -2, -123,     -60,  -2, -113,    -96,   -2, -123  }    -- Entrance Bridge W

mobList[zone][6  ].patrolPath = {   40,    0,  -85,     40,    1,  -96,     40,    0,  -85     } -- W1 Choc C
mobList[zone][35 ].patrolPath = {    3,    0,  -25,    -12,    0,  -25,      3,    0,  -25     } -- W1 AH N.Alley C
mobList[zone][11 ].patrolPath = {    7,    0, -100,      5,    0,  -79,      7,    0, -100     } -- W1 W of Choc
mobList[zone][21 ].patrolPath = {  -24,    0, -100,    -24,    0,  -79,    -24,    0, -100     } -- W1 W of Choc
mobList[zone][14 ].patrolPath = {  -20,    0,  -79,    -16,   -3,  -64,    -20,    0,  -79     } -- W1 AH WW
mobList[zone][12 ].patrolPath = {    0,    0,  -79,     0,    -3,  -64,      0,    0,  -79     } -- W1 AH C
mobList[zone][9  ].patrolPath = {   20,    0,  -79,     16,   -3,  -64,     20,    0,  -79     } -- W1 AH EE
mobList[zone][34 ].patrolPath = {  -44,    0,  -29,    -42,    0,   -9,    -44,    0,  -29     } -- W1 W of AH (NW)
mobList[zone][25 ].patrolPath = {  -10,   -1, -114,    -25,   -1, -114,    -10,   -1, -114     } -- W1 S.Gate S
mobList[zone][32 ].patrolPath = {  -32,    0,  -38,    -45,    0,  -38,    -32,    0,  -38     } -- W1 W of AH (C)
mobList[zone][58 ].patrolPath = {  -78,    0,    4,    -70,    0,    9,    -78,    0,    4     } -- W1 Under Bridge NE
mobList[zone][60 ].patrolPath = {  -78,    0,   -4,    -70,    0,   -9,    -78,    0,   -4     } -- W1 Under Bridge SE
mobList[zone][59 ].patrolPath = {  -70,    0,    0,    -78,    0,    0,    -70,    0,    0     } -- W1 Under Bridge E
mobList[zone][61 ].patrolPath = {  -94,    0,    9,    -87,    0,    4,    -94,    0,    9     } -- W1 Under Bridge NW
mobList[zone][63 ].patrolPath = {  -94,    0,   -9,    -87,    0,   -4,    -94,    0,   -9     } -- W1 Under Bridge SW
mobList[zone][62 ].patrolPath = {  -94,    0,    0,    -86,    0,    0,    -94,    0,    0     } -- W1 Under Bridge W
mobList[zone][75 ].patrolPath = { -128, -1.6,    4,   -128,    0,   -6,   -128, -1.6,    4     } -- W1 Zer N.Ramp (SW)
mobList[zone][76 ].patrolPath = { -132,    0,   -6,   -132, -1.6,    4,   -132,    0,   -6     } -- W1 Zer N.Ramp (NW)
mobList[zone][70 ].patrolPath = { -108,   -8,  -60,   -108,    0,  -14,   -108,   -8,  -60     } -- W1 Depot Ramp Base
mobList[zone][71 ].patrolPath = { -102,   -8,  -60,    -60,    0,  -60,   -102,   -8,  -60     } -- W1 Depot Ramp Top
mobList[zone][47 ].patrolPath = {   31,    7,   -2,      4,    7,   -2,     31,    7,   -2     } -- W1 O.St. NE
mobList[zone][49 ].patrolPath = {   31,    7,    5,     31,    3,   16,     31,    7,    5     } -- W1 O.St. CW S.Well Base
mobList[zone][50 ].patrolPath = {   31,    0,   24,     31,    2,   18,     31,    0,   24     } -- W1 O.St. CW S.Well#2
mobList[zone][104].patrolPath = {   74,    0,    8,     60,    0,    8,     74,    0,    8     } -- W1 O.St. CW Enc.#4
mobList[zone][102].patrolPath = {   36,    0,    8,     21,    0,    8,     36,    0,    8     } -- W1 O.St. CW Enc.#3

------------------------------------------
--          Statue Eye Colors           --
------------------------------------------
-- mobList[zone][MobIndex].eyes = xi.dynamis.eyesEra.BLUE -- Flags for blue eyes. (HP)
-- mobList[zone][MobIndex].eyes = xi.dynamis.eyesEra.GREEN -- Flags for green eyes. (MP)
-- mobList[zone][MobIndex].eyes = xi.dynamis.eyesEra.RED -- Flags for red eyes. (TE)

mobList[zone][1  ].eyes = xi.dynamis.eyesEra.RED
mobList[zone][7  ].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][8  ].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][19 ].eyes = xi.dynamis.eyesEra.RED
mobList[zone][25 ].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][26 ].eyes = xi.dynamis.eyesEra.GREEN
mobList[zone][31 ].eyes = xi.dynamis.eyesEra.GREEN
mobList[zone][38 ].eyes = xi.dynamis.eyesEra.GREEN
mobList[zone][39 ].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][41 ].eyes = xi.dynamis.eyesEra.RED
mobList[zone][42 ].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][81 ].eyes = xi.dynamis.eyesEra.GREEN
mobList[zone][82 ].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][85 ].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][89 ].eyes = xi.dynamis.eyesEra.RED
mobList[zone][92 ].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][104].eyes = xi.dynamis.eyesEra.GREEN
mobList[zone][110].eyes = xi.dynamis.eyesEra.RED
mobList[zone][112].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][114].eyes = xi.dynamis.eyesEra.GREEN
mobList[zone][116].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][119].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][120].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][121].eyes = xi.dynamis.eyesEra.GREEN
mobList[zone][122].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][124].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][125].eyes = xi.dynamis.eyesEra.GREEN
mobList[zone][127].eyes = xi.dynamis.eyesEra.GREEN
mobList[zone][129].eyes = xi.dynamis.eyesEra.GREEN
mobList[zone][132].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][133].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][136].eyes = xi.dynamis.eyesEra.GREEN
mobList[zone][137].eyes = xi.dynamis.eyesEra.GREEN
mobList[zone][138].eyes = xi.dynamis.eyesEra.BLUE
mobList[zone][139].eyes = xi.dynamis.eyesEra.BLUE

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- mobList[zone][MobIndex].timeExtension = 15

mobList[zone][1  ].timeExtension = 20 -- Adamantking Effigy
mobList[zone][19 ].timeExtension = 20 -- Adamantking Effigy
mobList[zone][41 ].timeExtension = 20 -- Adamantking Effigy
mobList[zone][154].timeExtension = 30 -- Gu'Nhi Noondozer
mobList[zone][113].timeExtension = 30 -- Goblin Golem
mobList[zone][162].timeExtension = 10 -- Vanguard Vindicator
mobList[zone][163].timeExtension = 10 -- Vanguard Constable
mobList[zone][164].timeExtension = 10 -- Vanguard Militant
