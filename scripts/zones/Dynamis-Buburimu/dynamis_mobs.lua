----------------------------------------------------------------------------------------------------
--                                      Dynamis-Buburimu                                        --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/bub.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/bub.html        --
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
--    Ex. xi.dynamis.mobList[zoneID].waves = { MobIndex, MobIndex, MobIndex }
--    Ex. xi.dynamis.mobList[zoneID].waves2 = { 1, 7, 12 }
--
-- 3. Setup wave spawning requirements. This is handled through a localvar set on the zone based on
--    the onMobDeath() function of the NM. By default this will only be the MegaBoss.
--    xi.dynamis.mobList[zoneID].waveDefeatRequirements[2] = {zone:getLocalVar("MegaBoss_Killed") == 1}
--
-- 4. Setup mob positions for spawns. This is only required for statues and mobs that do not spawn
--    from a statue, NM, or nightmare mob.
--    Ex. xi.dynamis.mobList[zoneID][MobIndex].pos = {xpos, ypos, zpos, rot}
--
-- 5. xi.dynamis.mobList[zoneID][MobIndex].info should be used to indicate the mob type and name.
--    Mob type indicates spawning pattern used. Mob Name will replace the name dynamically.
--    Mob Family is only required for beastmen NMs. Main Job is only required for beastmen NMs.
--    NOTE: These should only be made for non-standard/zone specific mobs.
--    Statue Ex. xi.dynamis.mobList[zoneID][MobIndex].info = {"Statue", "Sergeant Tombstone", nil, nil, nil}
--    Nightmare Ex. xi.dynamis.mobList[zoneID][MobIndex].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil}
--    Non-beastman NM Ex. xi.dynamis.mobList[zoneID][MobIndex].info = {"NM", "Apocalyptic Beast", nil, nil, "Apocalyptic_Beast_killed"}
--    Beastmen NM Ex. xi.dynamis.mobList[zoneID][MobIndex].info = {"NM", "ElvaanSticker Bxafraff", "Orc", "DRG", "ElvaanSticker_Bxafraff_killed"}
--
-- 6. xi.dynamis.mobList[zoneID][MobIndex].mobchildren is used to determine the number of each job to spawn.
--    To spawn a certain job, just put in the number of that job in the order of the job list 1-15.
--    This system will automatically determine what family each of these jobs encode to.
--    For Nightmare mob spawns, simply encode the number of children in xi.dynamis.mobList[zoneID][MobIndex].mobchildren[1] (aka #WAR).
--    Ex. xi.dynamis.mobList[zoneID][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}
--    Ex. For 2 Wars: xi.dynamis.mobList[zoneID][MobIndex].mobchildren = {2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil}
--
-- 7.  xi.dynamis.mobList[zoneID][MobIndex].NMchildren is used to spawn specific NMs outlined in xi.dynamis.mobList[zoneID][MobIndex].info
--     MobIndex is the index of the mob spawning the NM, MobIndex(NM) points to which NM in .info it should spawn.
--     Ex. xi.dynamis.mobList[zoneID][MobIndex].NMchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
--
-- 8. xi.dynamis.mobList[zoneID][MobIndex].patrolPath is used to set a specific path for a mob, if left blank for that MobIndex,
--    the mob will not path on a predetermined course. If it is a statue, it will not path at all. You can add
--    as many triplets of coordinates as desired.
--    Ex. xi.dynamis.mobList[zoneID][MobIndex].patrolPath = {xpos1,ypos1,zpos1, xpos2,ypos2,zpos2,  xpos3,ypos3,zpos3}
--
-- 9. xi.dynamis.mobList[zoneID][MobIndex].eyes sets the eye color of the statue. Valid options are:
--    xi.dynamis.eyes.RED, xi.dynamis.eyes.BLUE, xi.dynamis.eyes.GREEN
--    Ex. xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eyes.BLUE -- Flags for blue eyes. (HP)
--    Ex. xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eyes.GREEN -- Flags for green eyes. (MP)
--    Ex. xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eyes.RED -- Flags for red eyes. (TE)
--
-- 10. xi.dynamis.mobList[zoneID][MobIndex].timeExtension dictates the amount of time given for the TE.
--    Ex. xi.dynamis.mobList[zoneID][MobIndex].timeExtension = 15
--
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
--                               Dependency Setup Section (IGNORE)                                --
----------------------------------------------------------------------------------------------------
local zone = xi.zone.DYNAMIS_BUBURIMU
mobList = mobList or { }
xi.dynamis.mobList[zoneID] = { } -- Ignore me, I just start the table.
xi.dynamis.mobList[zoneID].zoneID = zone -- Ignore me, I just ensure .zoneID exists.
xi.dynamis.mobList[zoneID].waveDefeatRequirements = { } -- Ignore me, I just start the table.
xi.dynamis.mobList[zoneID].waveDefeatRequirements[1] = { } -- Ignore me, I just allow for wave 1 spawning.
xi.dynamis.mobList[zoneID].maxWaves = 2 -- Ignore me because Oph told me to

----------------------------------------------------------------------------------------------------
--                                  Setup of Parent Spawning                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--               Mob Info               --
-- Note: Primarily used for mobs that   --
-- are NMs or parent mobs.              --
------------------------------------------
--xi.dynamis.mobList[zoneID][MobIndex].info = {"Statue/NM/Nightmare", "Mob Name", "Family", "Main Job", "MobLocalVarName"}

xi.dynamis.mobList[zoneID][51 ].info = {"NM", "Alklha", nil, nil, nil}                           -- 051-Alkhla         (Apocalyptic Beast's 'Chaos Blade' has no effect)
xi.dynamis.mobList[zoneID][52 ].info = {"NM", "Stihi", nil, nil, nil}                            -- 052-Stihi          (Apocalyptic Beast's 'Flame Breath' has no effect)
xi.dynamis.mobList[zoneID][53 ].info = {"NM", "Basilic", nil, nil, nil}                          -- 053-Basilic        (Apocalyptic Beast's 'Petro Eyes' has no effect)
xi.dynamis.mobList[zoneID][54 ].info = {"NM", "Jurik", nil, nil, nil}                            -- 054-Jurik          (Apocalyptic Beast's 'Wind Breath' has no effect)
xi.dynamis.mobList[zoneID][55 ].info = {"NM", "Barong", nil, nil, nil}                           -- 055-Barong         (Apocalyptic Beast's 'Body Slam' has no effect)
xi.dynamis.mobList[zoneID][56 ].info = {"NM", "Tarasca", nil, nil, nil}                          -- 056-Tarasca        (Apocalyptic Beast's 'Heavy Stomp' has no effect)
xi.dynamis.mobList[zoneID][57 ].info = {"NM", "Stollenwurm", nil, nil, nil}                      -- 057-Stollenwurm    (Apocalyptic Beast's 'Lodesong' has no effect)
xi.dynamis.mobList[zoneID][58 ].info = {"NM", "Koschei", nil, nil, nil}                          -- 058-Koschei        (Apocalyptic Beast's 'Thornsong' has no effect)
xi.dynamis.mobList[zoneID][59 ].info = {"NM", "Aitvaras", nil, nil, nil}                         -- 059-Aitvaras       (Apocalyptic Beast's 'Voidsong' has no effect)
xi.dynamis.mobList[zoneID][60 ].info = {"NM", "Vishap", nil, nil, nil}                           -- 060-Vishap         (Apocalyptic Beast's 'Poison Breath' has no effect)
xi.dynamis.mobList[zoneID][61 ].info = {"NM", "Apocalyptic Beast", nil, nil, "MegaBoss_Killed"}  -- 061-Apocalyptic Beast

-- Orcs Statues
xi.dynamis.mobList[zoneID][1  ].info = {"Statue", "Sergeant Tombstone", "Orc", nil, nil} -- 001-O
xi.dynamis.mobList[zoneID][2  ].info = {"Statue", "Sergeant Tombstone", "Orc", nil, nil} -- 002-O
xi.dynamis.mobList[zoneID][3  ].info = {"Statue", "Sergeant Tombstone", "Orc", nil, nil} -- 003-O
xi.dynamis.mobList[zoneID][4  ].info = {"Statue", "Sergeant Tombstone", "Orc", nil, nil} -- 004-O
xi.dynamis.mobList[zoneID][5  ].info = {"Statue", "Sergeant Tombstone", "Orc", nil, nil} -- 005-O
xi.dynamis.mobList[zoneID][6  ].info = {"Statue", "Sergeant Tombstone", "Orc", nil, nil} -- 006-O
xi.dynamis.mobList[zoneID][7  ].info = {"Statue", "Sergeant Tombstone", "Orc", nil, nil} -- 007-O
xi.dynamis.mobList[zoneID][8  ].info = {"Statue", "Sergeant Tombstone", "Orc", nil, nil} -- 008-O
xi.dynamis.mobList[zoneID][9  ].info = {"Statue", "Sergeant Tombstone", "Orc", nil, nil} -- 009-O
xi.dynamis.mobList[zoneID][10 ].info = {"Statue", "Sergeant Tombstone", "Orc", nil, nil} -- 010-O
xi.dynamis.mobList[zoneID][11 ].info = {"Statue", "Sergeant Tombstone", "Orc", nil, nil} -- 011-O
xi.dynamis.mobList[zoneID][12 ].info = {"Statue", "Sergeant Tombstone", "Orc", nil, nil} -- 012-O
xi.dynamis.mobList[zoneID][13 ].info = {"Statue", "Sergeant Tombstone", "Orc", nil, nil} -- 013-O

-- Goblins Statues
xi.dynamis.mobList[zoneID][14 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil} -- 014-G
xi.dynamis.mobList[zoneID][15 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil} -- 015-G
xi.dynamis.mobList[zoneID][16 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil} -- 016-G
xi.dynamis.mobList[zoneID][17 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil} -- 017-G
xi.dynamis.mobList[zoneID][18 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil} -- 018-G
xi.dynamis.mobList[zoneID][19 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil} -- 019-G
xi.dynamis.mobList[zoneID][20 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil} -- 020-G
xi.dynamis.mobList[zoneID][21 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil} -- 021-G
xi.dynamis.mobList[zoneID][22 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil} -- 022-G
xi.dynamis.mobList[zoneID][23 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil} -- 023-G
xi.dynamis.mobList[zoneID][24 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil} -- 024-G

-- Quadavs Statues
xi.dynamis.mobList[zoneID][25 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- 025-Q
xi.dynamis.mobList[zoneID][26 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- 026-Q
xi.dynamis.mobList[zoneID][27 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- 027-Q
xi.dynamis.mobList[zoneID][28 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- 028-Q
xi.dynamis.mobList[zoneID][29 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- 029-Q
xi.dynamis.mobList[zoneID][30 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- 030-Q
xi.dynamis.mobList[zoneID][31 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- 031-Q
xi.dynamis.mobList[zoneID][32 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- 032-Q
xi.dynamis.mobList[zoneID][33 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- 033-Q
xi.dynamis.mobList[zoneID][34 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- 034-Q
xi.dynamis.mobList[zoneID][35 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- 035-Q
xi.dynamis.mobList[zoneID][36 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- 036-Q
xi.dynamis.mobList[zoneID][37 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- 037-Q

-- Yagudos Statues
xi.dynamis.mobList[zoneID][38 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil} -- 038-Y
xi.dynamis.mobList[zoneID][39 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil} -- 039-Y
xi.dynamis.mobList[zoneID][40 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil} -- 040-Y
xi.dynamis.mobList[zoneID][41 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil} -- 041-Y
xi.dynamis.mobList[zoneID][42 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil} -- 042-Y
xi.dynamis.mobList[zoneID][43 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil} -- 043-Y
xi.dynamis.mobList[zoneID][44 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil} -- 044-Y
xi.dynamis.mobList[zoneID][45 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil} -- 045-Y
xi.dynamis.mobList[zoneID][46 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil} -- 046-Y
xi.dynamis.mobList[zoneID][47 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil} -- 047-Y
xi.dynamis.mobList[zoneID][48 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil} -- 048-Y
xi.dynamis.mobList[zoneID][49 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil} -- 049-Y
xi.dynamis.mobList[zoneID][50 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil} -- 050-Y

-- Nightmare Crabs
xi.dynamis.mobList[zoneID][62 ].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} -- 062-Nightmare Crab (×2)
xi.dynamis.mobList[zoneID][153].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} --
xi.dynamis.mobList[zoneID][63 ].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} -- 063-Nightmare Crab (×2)
xi.dynamis.mobList[zoneID][154].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} --
xi.dynamis.mobList[zoneID][64 ].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} -- 064-Nightmare Crab (×2)
xi.dynamis.mobList[zoneID][155].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} --
xi.dynamis.mobList[zoneID][65 ].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} -- 065-Nightmare Crab (×2)
xi.dynamis.mobList[zoneID][156].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} --
xi.dynamis.mobList[zoneID][66 ].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} -- 066-Nightmare Crab (×2)
xi.dynamis.mobList[zoneID][157].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} --
xi.dynamis.mobList[zoneID][67 ].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} -- 067-Nightmare Crab (×2)
xi.dynamis.mobList[zoneID][158].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} --
xi.dynamis.mobList[zoneID][68 ].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} -- 068-Nightmare Crab (×2)
xi.dynamis.mobList[zoneID][159].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} --
xi.dynamis.mobList[zoneID][69 ].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} -- 069-Nightmare Crab (×2)
xi.dynamis.mobList[zoneID][160].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} --
xi.dynamis.mobList[zoneID][70 ].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} -- 070-Nightmare Crab (×2)
xi.dynamis.mobList[zoneID][161].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} --
xi.dynamis.mobList[zoneID][71 ].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} -- 071-Nightmare Crab (×2)
xi.dynamis.mobList[zoneID][162].info = {"Nightmare", "Nightmare Crab", nil, nil, nil} --

-- Nightmare Dhalmel
xi.dynamis.mobList[zoneID][118].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} -- 118-Nightmare Dhalmel (×2)
xi.dynamis.mobList[zoneID][227].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} --
xi.dynamis.mobList[zoneID][119].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} -- 119-Nightmare Dhalmel (×2)
xi.dynamis.mobList[zoneID][228].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} --
xi.dynamis.mobList[zoneID][120].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} -- 120-Nightmare Dhalmel (×2)
xi.dynamis.mobList[zoneID][229].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} --
xi.dynamis.mobList[zoneID][121].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} -- 121-Nightmare Dhalmel (×2)
xi.dynamis.mobList[zoneID][230].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} --
xi.dynamis.mobList[zoneID][122].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} -- 122-Nightmare Dhalmel (×2)
xi.dynamis.mobList[zoneID][231].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} --
xi.dynamis.mobList[zoneID][123].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} -- 123-Nightmare Dhalmel (×2)
xi.dynamis.mobList[zoneID][232].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} --
xi.dynamis.mobList[zoneID][124].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} -- 124-Nightmare Dhalmel (×2)
xi.dynamis.mobList[zoneID][233].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} --
xi.dynamis.mobList[zoneID][125].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} -- 125-Nightmare Dhalmel (×3)
xi.dynamis.mobList[zoneID][234].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} --
xi.dynamis.mobList[zoneID][235].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} --
xi.dynamis.mobList[zoneID][126].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} -- 126-Nightmare Dhalmel (×3)
xi.dynamis.mobList[zoneID][236].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} --
xi.dynamis.mobList[zoneID][237].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} --
xi.dynamis.mobList[zoneID][127].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} -- 127-Nightmare Dhalmel (×3)
xi.dynamis.mobList[zoneID][238].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} --
xi.dynamis.mobList[zoneID][239].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} --
xi.dynamis.mobList[zoneID][128].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} -- 128-Nightmare Dhalmel (×3)
xi.dynamis.mobList[zoneID][240].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} --
xi.dynamis.mobList[zoneID][241].info = {"Nightmare", "Nightmare Dhamel", nil, nil, nil} --

-- Nightmare Urganite
xi.dynamis.mobList[zoneID][139].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} -- 139-Nightmare Uragnite (×2)
xi.dynamis.mobList[zoneID][256].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][140].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} -- 140-Nightmare Uragnite (×2)
xi.dynamis.mobList[zoneID][257].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][141].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} -- 141-Nightmare Uragnite (×2)
xi.dynamis.mobList[zoneID][258].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][142].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} -- 142-Nightmare Uragnite (×2)
xi.dynamis.mobList[zoneID][259].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][143].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} -- 143-Nightmare Uragnite (×2)
xi.dynamis.mobList[zoneID][260].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][144].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} -- 144-Nightmare Uragnite (×3)
xi.dynamis.mobList[zoneID][261].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][262].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][145].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} -- 145-Nightmare Uragnite (×3)
xi.dynamis.mobList[zoneID][263].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][264].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][146].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} -- 146-Nightmare Uragnite (×3)
xi.dynamis.mobList[zoneID][265].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][266].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][147].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} -- 147-Nightmare Uragnite (×3)
xi.dynamis.mobList[zoneID][267].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][268].info = {"Nightmare", "Nightmare Urganite", nil, nil, nil} --

-- Nightmare Scorpion
xi.dynamis.mobList[zoneID][148].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} -- 148-Nightmare Scorpion (×4)
xi.dynamis.mobList[zoneID][269].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --
xi.dynamis.mobList[zoneID][270].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --
xi.dynamis.mobList[zoneID][271].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --
xi.dynamis.mobList[zoneID][149].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} -- 149-Nightmare Scorpion (×4)
xi.dynamis.mobList[zoneID][272].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --
xi.dynamis.mobList[zoneID][273].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --
xi.dynamis.mobList[zoneID][274].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --
xi.dynamis.mobList[zoneID][150].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} -- 150-Nightmare Scorpion (×4)
xi.dynamis.mobList[zoneID][275].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --
xi.dynamis.mobList[zoneID][276].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --
xi.dynamis.mobList[zoneID][277].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --
xi.dynamis.mobList[zoneID][151].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} -- 151-Nightmare Scorpion (×4)
xi.dynamis.mobList[zoneID][278].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --
xi.dynamis.mobList[zoneID][279].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --
xi.dynamis.mobList[zoneID][280].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --
xi.dynamis.mobList[zoneID][152].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} -- 152-Nightmare Scorpion (×5)
xi.dynamis.mobList[zoneID][281].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --
xi.dynamis.mobList[zoneID][282].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --
xi.dynamis.mobList[zoneID][283].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --
xi.dynamis.mobList[zoneID][284].info = {"Nightmare", "Nightmare Scorpion", nil, nil, nil} --

-- Nightmare Bunny
xi.dynamis.mobList[zoneID][82 ].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} -- 082-Nightmare Bunny (×2)
xi.dynamis.mobList[zoneID][173].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} --
xi.dynamis.mobList[zoneID][83 ].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} -- 083-Nightmare Bunny (×2)
xi.dynamis.mobList[zoneID][174].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} --
xi.dynamis.mobList[zoneID][84 ].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} -- 084-Nightmare Bunny (×2)
xi.dynamis.mobList[zoneID][175].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} --
xi.dynamis.mobList[zoneID][85 ].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} -- 085-Nightmare Bunny (×2)
xi.dynamis.mobList[zoneID][176].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} --
xi.dynamis.mobList[zoneID][86 ].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} -- 086-Nightmare Bunny (×2)
xi.dynamis.mobList[zoneID][177].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} --
xi.dynamis.mobList[zoneID][87 ].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} -- 087-Nightmare Bunny (×2)
xi.dynamis.mobList[zoneID][178].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} --
xi.dynamis.mobList[zoneID][88 ].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} -- 088-Nightmare Bunny (×2)
xi.dynamis.mobList[zoneID][179].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} --
xi.dynamis.mobList[zoneID][89 ].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} -- 089-Nightmare Bunny (×2)
xi.dynamis.mobList[zoneID][180].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} --
xi.dynamis.mobList[zoneID][90 ].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} -- 090-Nightmare Bunny (×2)
xi.dynamis.mobList[zoneID][181].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} --
xi.dynamis.mobList[zoneID][91 ].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} -- 091-Nightmare Bunny (×2)
xi.dynamis.mobList[zoneID][182].info = {"Nightmare", "Nightmare Bunny", nil, nil, nil} --

-- Nightmare Mandragora
xi.dynamis.mobList[zoneID][97 ].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} -- 097-Nightmare Mandragora (×3)
xi.dynamis.mobList[zoneID][198].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --
xi.dynamis.mobList[zoneID][199].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --
xi.dynamis.mobList[zoneID][98 ].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} -- 098-Nightmare Mandragora (×3)
xi.dynamis.mobList[zoneID][200].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --
xi.dynamis.mobList[zoneID][201].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --
xi.dynamis.mobList[zoneID][99 ].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} -- 099-Nightmare Mandragora (×3)
xi.dynamis.mobList[zoneID][202].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --
xi.dynamis.mobList[zoneID][203].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --
xi.dynamis.mobList[zoneID][100].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} -- 100-Nightmare Mandragora (×3)
xi.dynamis.mobList[zoneID][204].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --
xi.dynamis.mobList[zoneID][205].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --
xi.dynamis.mobList[zoneID][101].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} -- 101-Nightmare Mandragora (×3)
xi.dynamis.mobList[zoneID][206].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --
xi.dynamis.mobList[zoneID][207].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --
xi.dynamis.mobList[zoneID][102].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} -- 102-Nightmare Mandragora (×3)
xi.dynamis.mobList[zoneID][208].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --
xi.dynamis.mobList[zoneID][209].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --
xi.dynamis.mobList[zoneID][103].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} -- 103-Nightmare Mandragora (×3)
xi.dynamis.mobList[zoneID][210].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --
xi.dynamis.mobList[zoneID][211].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --
xi.dynamis.mobList[zoneID][104].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} -- 104-Nightmare Mandragora (×3)
xi.dynamis.mobList[zoneID][212].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --
xi.dynamis.mobList[zoneID][213].info = {"Nightmare", "Nightmare Mandragora", nil, nil, nil} --

-- Nightmare Crawler
xi.dynamis.mobList[zoneID][129].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} -- 129-Nightmare Crawler (×2)
xi.dynamis.mobList[zoneID][242].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} --
xi.dynamis.mobList[zoneID][130].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} -- 130-Nightmare Crawler (×2)
xi.dynamis.mobList[zoneID][243].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} --
xi.dynamis.mobList[zoneID][131].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} -- 131-Nightmare Crawler (×2)
xi.dynamis.mobList[zoneID][244].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} --
xi.dynamis.mobList[zoneID][132].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} -- 132-Nightmare Crawler (×3)
xi.dynamis.mobList[zoneID][245].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} --
xi.dynamis.mobList[zoneID][246].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} --
xi.dynamis.mobList[zoneID][133].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} -- 133-Nightmare Crawler (×3)
xi.dynamis.mobList[zoneID][247].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} --
xi.dynamis.mobList[zoneID][248].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} --
xi.dynamis.mobList[zoneID][134].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} -- 134-Nightmare Crawler (×2)
xi.dynamis.mobList[zoneID][249].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} --
xi.dynamis.mobList[zoneID][135].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} -- 135-Nightmare Crawler (×2)
xi.dynamis.mobList[zoneID][250].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} --
xi.dynamis.mobList[zoneID][136].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} -- 136-Nightmare Crawler (×2)
xi.dynamis.mobList[zoneID][251].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} --
xi.dynamis.mobList[zoneID][137].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} -- 137-Nightmare Crawler (×3)
xi.dynamis.mobList[zoneID][252].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} --
xi.dynamis.mobList[zoneID][253].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} --
xi.dynamis.mobList[zoneID][138].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} -- 138-Nightmare Crawler (×3)
xi.dynamis.mobList[zoneID][254].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} --
xi.dynamis.mobList[zoneID][255].info = {"Nightmare", "Nightmare Crawler", nil, nil, nil} --

-- Nightmare Raven
xi.dynamis.mobList[zoneID][105].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} -- 105-Nightmare Raven (×2)
xi.dynamis.mobList[zoneID][214].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} --
xi.dynamis.mobList[zoneID][106].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} -- 106-Nightmare Raven (×2)
xi.dynamis.mobList[zoneID][215].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} --
xi.dynamis.mobList[zoneID][107].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} -- 107-Nightmare Raven (×2)
xi.dynamis.mobList[zoneID][216].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} --
xi.dynamis.mobList[zoneID][108].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} -- 108-Nightmare Raven (×2)
xi.dynamis.mobList[zoneID][217].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} --
xi.dynamis.mobList[zoneID][109].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} -- 109-Nightmare Raven (×2)
xi.dynamis.mobList[zoneID][218].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} --
xi.dynamis.mobList[zoneID][110].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} -- 110-Nightmare Raven (×2)
xi.dynamis.mobList[zoneID][219].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} --
xi.dynamis.mobList[zoneID][111].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} -- 111-Nightmare Raven (×2)
xi.dynamis.mobList[zoneID][220].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} --
xi.dynamis.mobList[zoneID][112].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} -- 112-Nightmare Raven (×2)
xi.dynamis.mobList[zoneID][221].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} --
xi.dynamis.mobList[zoneID][113].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} -- 113-Nightmare Raven (×2)
xi.dynamis.mobList[zoneID][222].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} --
xi.dynamis.mobList[zoneID][114].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} -- 114-Nightmare Raven (×2)
xi.dynamis.mobList[zoneID][223].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} --
xi.dynamis.mobList[zoneID][115].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} -- 115-Nightmare Raven (×2)
xi.dynamis.mobList[zoneID][224].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} --
xi.dynamis.mobList[zoneID][116].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} -- 116-Nightmare Raven (×2)
xi.dynamis.mobList[zoneID][225].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} --
xi.dynamis.mobList[zoneID][117].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} -- 117-Nightmare Raven (×2)
xi.dynamis.mobList[zoneID][226].info = {"Nightmare", "Nightmare Raven", nil, nil, nil} --

-- Nightmare Eft
xi.dynamis.mobList[zoneID][72 ].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} -- 072-Nightmare Eft (×2)
xi.dynamis.mobList[zoneID][163].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} --
xi.dynamis.mobList[zoneID][73 ].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} -- 073-Nightmare Eft (×2)
xi.dynamis.mobList[zoneID][164].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} --
xi.dynamis.mobList[zoneID][74 ].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} -- 074-Nightmare Eft (×2)
xi.dynamis.mobList[zoneID][165].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} --
xi.dynamis.mobList[zoneID][75 ].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} -- 075-Nightmare Eft (×2)
xi.dynamis.mobList[zoneID][166].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} --
xi.dynamis.mobList[zoneID][76 ].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} -- 076-Nightmare Eft (×2)
xi.dynamis.mobList[zoneID][167].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} --
xi.dynamis.mobList[zoneID][77 ].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} -- 077-Nightmare Eft (×2)
xi.dynamis.mobList[zoneID][168].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} --
xi.dynamis.mobList[zoneID][78 ].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} -- 078-Nightmare Eft (×2)
xi.dynamis.mobList[zoneID][169].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} --
xi.dynamis.mobList[zoneID][79 ].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} -- 079-Nightmare Eft (×2)
xi.dynamis.mobList[zoneID][170].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} --
xi.dynamis.mobList[zoneID][80 ].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} -- 080-Nightmare Eft (×2)
xi.dynamis.mobList[zoneID][171].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} --
xi.dynamis.mobList[zoneID][81 ].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} -- 081-Nightmare Eft (×2)
xi.dynamis.mobList[zoneID][172].info = {"Nightmare", "Nightmare Eft", nil, nil, nil} --

-- Nightmare Cockatrice
xi.dynamis.mobList[zoneID][92 ].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} -- 092-Nightmare Cockatrice (×4)
xi.dynamis.mobList[zoneID][183].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} --
xi.dynamis.mobList[zoneID][184].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} --
xi.dynamis.mobList[zoneID][185].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} --
xi.dynamis.mobList[zoneID][93 ].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} -- 093-Nightmare Cockatrice (×4)
xi.dynamis.mobList[zoneID][186].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} --
xi.dynamis.mobList[zoneID][187].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} --
xi.dynamis.mobList[zoneID][188].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} -- 094-Nightmare Cockatrice (×4)
xi.dynamis.mobList[zoneID][94 ].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} --
xi.dynamis.mobList[zoneID][189].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} --
xi.dynamis.mobList[zoneID][190].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} --
xi.dynamis.mobList[zoneID][191].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} --
xi.dynamis.mobList[zoneID][95 ].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} -- 095-Nightmare Cockatrice (×4)
xi.dynamis.mobList[zoneID][192].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} --
xi.dynamis.mobList[zoneID][193].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} --
xi.dynamis.mobList[zoneID][194].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} --
xi.dynamis.mobList[zoneID][96 ].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} -- 096-Nightmare Cockatrice (×4)
xi.dynamis.mobList[zoneID][195].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} --
xi.dynamis.mobList[zoneID][196].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} --
xi.dynamis.mobList[zoneID][197].info = {"Nightmare", "Nightmare Cockatrice", nil, nil, nil} --

-- Orc NMs
xi.dynamis.mobList[zoneID][285].info = {"NM", "Elvaansticker Bxafraff", "Orc", "DRG", nil}       -- Elvaansticker Bxafraff (Apocalyptic Beast's 'Call Wyvern' has no effect)
xi.dynamis.mobList[zoneID][286].info = {"NM", "Flamecaller Zoeqdoq", "Orc", "BLM", nil}          -- Flamecaller Zoeqdoq (Apocalyptic Beast's 'Manafont' has no effect)
xi.dynamis.mobList[zoneID][287].info = {"NM", "Hamfist Gukhbuk", "Orc", "MNK", nil}              -- Hamfist Gukhbuk (Apocalyptic Beast's 'Hundred Fists' has no effect)
xi.dynamis.mobList[zoneID][288].info = {"NM", "Lyncean Juvgneg", "Orc", "RNG", nil}              -- Lyncean Juvgneg (Apocalyptic Beast's 'Eagle Eye Shot' has no effect)
-- Goblin NMs
xi.dynamis.mobList[zoneID][289].info = {"NM", "Gosspix Blabberlips", "Goblin", "RDM", nil}       -- Gosspix Blabberlips (Apocalyptic Beast's 'Chainspell' has no effect)
xi.dynamis.mobList[zoneID][290].info = {"NM", "Woodnix Shrillwhistle", "Goblin", "BST", nil}     -- Woodnix Shrillwhistle (Apocalyptic Beast's 'Familiar' has no effect)
xi.dynamis.mobList[zoneID][291].info = {"NM", "Shamblix Rottenheart", "Goblin", "DRK", nil}      -- Shamblix Rottenheart (Apocalyptic Beast's 'Blood Weapon' has no effect)
-- Quadav NMs
xi.dynamis.mobList[zoneID][292].info = {"NM", "Qu'Pho Bloodspiller", "Quadav", "WAR", nil}       -- Qu'Pho Bloodspiller (Apocalyptic Beast's 'Mighty Strikes' has no effect)
xi.dynamis.mobList[zoneID][293].info = {"NM", "Te'Zha Ironclad", "Quadav", "PLD", nil}           -- Te'Zha Ironclad (Apocalyptic Beast's 'Invincible' has no effect)
xi.dynamis.mobList[zoneID][294].info = {"NM", "Gi'Bhe Flesheater", "Quadav", "WHM", nil}         -- Gi'Bhe Flesheater (Apocalyptic Beast's 'Benediction' has no effect)
xi.dynamis.mobList[zoneID][295].info = {"NM", "Va'Rhu Bodysnatcher", "Quadav", "THF", nil}       -- Va'Rhu Bodysnatcher (Apocalyptic Beast's 'Perfect Dodge' has no effect)
-- Yagudo NMs
xi.dynamis.mobList[zoneID][296].info = {"NM", "Koo rahi the Levinblade", "Yagudo", "SAM", nil}   -- Koo rahi the Levinblade (Apocalyptic Beast's 'Meikyo Shisui' has no effect)
xi.dynamis.mobList[zoneID][297].info = {"NM", "Baa Dava the Bibliopage", "Yagudo", "SMN", nil}   -- Baa Dava the Bibliopage (Apocalyptic Beast's 'Astral Flow' has no effect)
xi.dynamis.mobList[zoneID][298].info = {"NM", "Doo Peku the Fleetfoot", "Yagudo", "NIN", nil}    -- Doo Peku the Fleetfoot (Apocalyptic Beast's 'Mijin Gakure' has no effect)
xi.dynamis.mobList[zoneID][299].info = {"NM", "Ree Nata the Melomanic", "Yagudo", "BRD", nil}    -- Ree Nata the Melomanic (Apocalyptic Beast's 'Soul Voice' has no effect)

----------------------------------------------------------------------------------------------------
--                                    Setup of Wave Spawning                                      --
----------------------------------------------------------------------------------------------------

---------------------------------------------
--           Wave Defeat Reqs.          --
--------------------------------------------
--xi.dynamis.mobList[zoneID].waveDefeatRequirements[2] = {zone:getLocalVar("MegaBoss_Killed") == 1}

xi.dynamis.mobList[zoneID].waveDefeatRequirements[2] = { zone:getLocalVar("MegaBoss_Killed") == 1 } -- Spawns Nightmare Mobs

------------------------------------------
--            Wave Spawning             --
-- Note: Wave 1 spawns at start.        --
------------------------------------------
--xi.dynamis.mobList[zoneID].wave# = { MobIndex#1, MobIndex#2, MobIndex#3 }

xi.dynamis.mobList[zoneID].wave1 = {
    61, -- Apocalyptic Beast          061
    52, -- Stihi                      052
    51, -- Alklha                     051
    53, -- Basilic                    053
    54, -- Jurik                      054
    55, -- Barong                     055
    56, -- Tarasca                    056
    57, -- Stollenwurm                057
    58, -- Koschei                    058
    59, -- Aitvaras                   059
    60, -- Vishap                     060
    1 , -- Sergeant Tombstone         001-O
    2 , -- Sergeant Tombstone         002-O
    3 , -- Sergeant Tombstone         003-O
    4 , -- Sergeant Tombstone         004-O
    5 , -- Sergeant Tombstone         005-O
    6 , -- Sergeant Tombstone         006-O
    7 , -- Sergeant Tombstone         007-O
    8 , -- Sergeant Tombstone         008-O
    9 , -- Sergeant Tombstone         009-O
    10, -- Sergeant Tombstone         010-O
    11, -- Sergeant Tombstone         011-O
    12, -- Sergeant Tombstone         012-O
    13, -- Sergeant Tombstone         013-O
    14, -- Goblin Replica             014-G
    15, -- Goblin Replica             015-G
    16, -- Goblin Replica             016-G
    17, -- Goblin Replica             017-G
    18, -- Goblin Replica             018-G
    19, -- Goblin Replica             019-G
    20, -- Goblin Replica             020-G
    21, -- Goblin Replica             021-G
    22, -- Goblin Replica             022-G
    23, -- Goblin Replica             023-G
    24, -- Goblin Replica             024-G
    25, -- Adamantking Effigy         025-Q
    26, -- Adamantking Effigy         026-Q
    27, -- Adamantking Effigy         027-Q
    28, -- Adamantking Effigy         028-Q
    29, -- Adamantking Effigy         029-Q
    30, -- Adamantking Effigy         030-Q
    31, -- Adamantking Effigy         031-Q
    32, -- Adamantking Effigy         032-Q
    33, -- Adamantking Effigy         033-Q
    34, -- Adamantking Effigy         034-Q
    35, -- Adamantking Effigy         035-Q
    36, -- Adamantking Effigy         036-Q
    37, -- Adamantking Effigy         037-Q
    38, -- Manifest Icon              038-Y
    39, -- Manifest Icon              039-Y
    40, -- Manifest Icon              040-Y
    41, -- Manifest Icon              041-Y
    42, -- Manifest Icon              042-Y
    43, -- Manifest Icon              043-Y
    44, -- Manifest Icon              044-Y
    45, -- Manifest Icon              045-Y
    46, -- Manifest Icon              046-Y
    47, -- Manifest Icon              047-Y
    48, -- Manifest Icon              048-Y
    49, -- Manifest Icon              049-Y
    50  -- Manifest Icon              050-Y
}

xi.dynamis.mobList[zoneID].wave2 = {
    62 , -- Nightmare Crab
    63 , -- Nightmare Crab
    64 , -- Nightmare Crab
    65 , -- Nightmare Crab
    66 , -- Nightmare Crab
    67 , -- Nightmare Crab
    68 , -- Nightmare Crab
    69 , -- Nightmare Crab
    70 , -- Nightmare Crab
    71 , -- Nightmare Crab
    72 , -- Nightmare Eft
    73 , -- Nightmare Eft
    74 , -- Nightmare Eft
    75 , -- Nightmare Eft
    76 , -- Nightmare Eft
    77 , -- Nightmare Eft
    78 , -- Nightmare Eft
    79 , -- Nightmare Eft
    80 , -- Nightmare Eft
    81 , -- Nightmare Eft
    82 , -- Nightmare Bunny
    83 , -- Nightmare Bunny
    84 , -- Nightmare Bunny
    85 , -- Nightmare Bunny
    86 , -- Nightmare Bunny
    87 , -- Nightmare Bunny
    88 , -- Nightmare Bunny
    89 , -- Nightmare Bunny
    90 , -- Nightmare Bunny
    91 , -- Nightmare Bunny
    92 , -- Nightmare Cockatrice
    93 , -- Nightmare Cockatrice
    94 , -- Nightmare Cockatrice
    95,  -- Nightmare Cockatrice
    96,  -- Nightmare Cockatrice
    97 , -- Nightmare Mandragora
    98 , -- Nightmare Mandragora
    99 , -- Nightmare Mandragora
    100, -- Nightmare Mandragora
    101, -- Nightmare Mandragora
    102, -- Nightmare Mandragora
    103, -- Nightmare Mandragora
    104, -- Nightmare Mandragora
    105, -- Nightmare Raven
    106, -- Nightmare Raven
    107, -- Nightmare Raven
    108, -- Nightmare Raven
    109, -- Nightmare Raven
    110, -- Nightmare Raven
    111, -- Nightmare Raven
    112, -- Nightmare Raven
    113, -- Nightmare Raven
    114, -- Nightmare Raven
    115, -- Nightmare Raven
    116, -- Nightmare Raven
    117, -- Nightmare Raven
    118, -- Nightmare Dhamel
    119, -- Nightmare Dhamel
    120, -- Nightmare Dhamel
    121, -- Nightmare Dhamel
    122, -- Nightmare Dhamel
    123, -- Nightmare Dhamel
    124, -- Nightmare Dhamel
    125, -- Nightmare Dhamel
    126, -- Nightmare Dhamel
    127, -- Nightmare Dhamel
    129, -- Nightmare Crawler
    130, -- Nightmare Crawler
    131, -- Nightmare Crawler
    132, -- Nightmare Crawler
    133, -- Nightmare Crawler
    134, -- Nightmare Crawler
    135, -- Nightmare Crawler
    136, -- Nightmare Crawler
    137, -- Nightmare Crawler
    138, -- Nightmare Crawler
    139, -- Nightmare Urganite
    140, -- Nightmare Urganite
    141, -- Nightmare Urganite
    142, -- Nightmare Urganite
    143, -- Nightmare Urganite
    144, -- Nightmare Urganite
    145, -- Nightmare Urganite
    146, -- Nightmare Urganite
    147, -- Nightmare Urganite
    148, -- Nightmare Scorpion
    149, -- Nightmare Scorpion
    150, -- Nightmare Scorpion
    151, -- Nightmare Scorpion
    152  -- Nightmare Scorpion
}

----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

xi.dynamis.mobList[zoneID][1  ].mobchildren = { nil, nil, nil, nil,   1,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  }	-- 1 RDM  1 THF  1 BRD
xi.dynamis.mobList[zoneID][2  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1  }	-- 1 BST  1 SMN
xi.dynamis.mobList[zoneID][3  ].mobchildren = {   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }	-- 1 WAR  1 WHM  1 NIN
xi.dynamis.mobList[zoneID][4  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }	-- 1 SAM
xi.dynamis.mobList[zoneID][5  ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }	-- 1 BLM
xi.dynamis.mobList[zoneID][6  ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil  }	-- 1 WAR  1 BST  1 DRG
xi.dynamis.mobList[zoneID][7  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }	-- 1 DRK
xi.dynamis.mobList[zoneID][8  ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }	-- 1 RDM
xi.dynamis.mobList[zoneID][9  ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }	-- 1 PLD
xi.dynamis.mobList[zoneID][10 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }	-- 1 WHM  1 NIN
xi.dynamis.mobList[zoneID][11 ].mobchildren = { nil,   2, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }	-- 2 MNK  1 RNG
xi.dynamis.mobList[zoneID][12 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1  }	-- 1 BRD  1 SMN
xi.dynamis.mobList[zoneID][13 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }	-- 1 THF
xi.dynamis.mobList[zoneID][14 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }	-- 1 BRD
xi.dynamis.mobList[zoneID][15 ].mobchildren = { nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil,   1, nil  }	-- 1 THF  1 PLD  1 DRG
xi.dynamis.mobList[zoneID][16 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil  }	-- 1 BST  1 NIN
xi.dynamis.mobList[zoneID][17 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1  }	-- 1 BRD  1 SMN
xi.dynamis.mobList[zoneID][18 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil  }	-- 1 WHM  1 DRK  1 RNG
xi.dynamis.mobList[zoneID][19 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }	-- 1 BLM
xi.dynamis.mobList[zoneID][20 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }	-- 1 BLM
xi.dynamis.mobList[zoneID][21 ].mobchildren = {   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }	-- 1 WAR  1 MNK  1 SAM
xi.dynamis.mobList[zoneID][22 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  }	-- 1 SMN
xi.dynamis.mobList[zoneID][23 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }	-- 1 NIN
xi.dynamis.mobList[zoneID][24 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }	-- 1 RDM
xi.dynamis.mobList[zoneID][25 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }	-- 1 WAR  2 BST
xi.dynamis.mobList[zoneID][26 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }	-- 2 BLM
xi.dynamis.mobList[zoneID][27 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  }	-- 2 DRK
xi.dynamis.mobList[zoneID][28 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil,   2, nil, nil  }	-- 1 PLD  2 NIN
xi.dynamis.mobList[zoneID][29 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil  }	-- 2 BRD
xi.dynamis.mobList[zoneID][30 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  }	-- 2 DRG
xi.dynamis.mobList[zoneID][31 ].mobchildren = { nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }	-- 2 RDM
xi.dynamis.mobList[zoneID][32 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  }	-- 2 SAM
xi.dynamis.mobList[zoneID][33 ].mobchildren = { nil,   2,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }	-- 2 MNK  1 WHM
xi.dynamis.mobList[zoneID][34 ].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  }	-- 2 PLD
xi.dynamis.mobList[zoneID][35 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }	-- 2 BLM
xi.dynamis.mobList[zoneID][36 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2  }	-- 2 SMN
xi.dynamis.mobList[zoneID][37 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   2, nil, nil, nil, nil  }	-- 1 THF  2 RNG
xi.dynamis.mobList[zoneID][38 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }	-- 1 MNK  1 SAM
xi.dynamis.mobList[zoneID][39 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }	-- 1 MNK  1 SAM
xi.dynamis.mobList[zoneID][40 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil  }	-- 1 WAR  1 DRK  1 RNG
xi.dynamis.mobList[zoneID][41 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil  }	-- 1 BST  1 DRG
xi.dynamis.mobList[zoneID][42 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1  }	-- 1 BRD  1 SMN
xi.dynamis.mobList[zoneID][43 ].mobchildren = { nil, nil,   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }	-- 1 WHM  1 BLM  1 RDM
xi.dynamis.mobList[zoneID][44 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1  }	-- 1 BRD  1 SMN
xi.dynamis.mobList[zoneID][45 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil  }	-- 1 BST  1 DRG
xi.dynamis.mobList[zoneID][46 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  }	-- 2 DRK
xi.dynamis.mobList[zoneID][47 ].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }	-- 1 WAR  1 THF
xi.dynamis.mobList[zoneID][48 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil  }	-- 3 NIN
xi.dynamis.mobList[zoneID][49 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil  }	-- 1 THF  1 RNG
xi.dynamis.mobList[zoneID][50 ].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil,   1, nil, nil, nil, nil, nil  }	-- 2 PLD  1 BRD

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].NMchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

xi.dynamis.mobList[zoneID][1  ].specificChildren = { true, 285 }         -- Elvaansticker Bxafraff                 (001-O)
xi.dynamis.mobList[zoneID][3  ].specificChildren = { true, 286 }         -- Flamecaller Zoeqdoq                    (003-O)
xi.dynamis.mobList[zoneID][6  ].specificChildren = { true, 287 }         -- Hamfist Gukhbuk                        (006-O)
xi.dynamis.mobList[zoneID][11 ].specificChildren = { true, 288 }         -- Lyncean Juvgneg                        (011-O)
xi.dynamis.mobList[zoneID][15 ].specificChildren = { true, 289 }         -- Gosspix Blabberlips                    (015-G)
xi.dynamis.mobList[zoneID][18 ].specificChildren = { true, 290 }         -- Woodnix Shrillwhistle                  (018-G)
xi.dynamis.mobList[zoneID][21 ].specificChildren = { true, 291 }         -- Shamblix Rottenheart                   (021-G)
xi.dynamis.mobList[zoneID][25 ].specificChildren = { true, 292 }         -- Qu'Pho Bloodspiller                    (025-Q)
xi.dynamis.mobList[zoneID][28 ].specificChildren = { true, 293 }         -- Te'Zha Ironclad                        (028-Q)
xi.dynamis.mobList[zoneID][33 ].specificChildren = { true, 294 }         -- Gi'Bhe Flesheater                      (033-Q)
xi.dynamis.mobList[zoneID][37 ].specificChildren = { true, 295 }         -- Va'Rhu Bodysnatcher                    (037-Q)
xi.dynamis.mobList[zoneID][40 ].specificChildren = { true, 296 }         -- Koo rahi the Levinblade                (040-Y)
xi.dynamis.mobList[zoneID][43 ].specificChildren = { true, 297 }         -- Baa Dava the Bibliopage                (043-Y)
xi.dynamis.mobList[zoneID][48 ].specificChildren = { true, 298 }         -- Doo Peku the Fleetfoot                 (048-Y)
xi.dynamis.mobList[zoneID][50 ].specificChildren = { true, 299 }         -- Ree Nata the Melomanic                 (050-Y)

-- Nightmare Mobs
xi.dynamis.mobList[zoneID][62 ].NMchildren = { true, 153                } -- Nightmare Crab                        ( 062 )
xi.dynamis.mobList[zoneID][63 ].NMchildren = { true, 154                } -- Nightmare Crab                        ( 063 )
xi.dynamis.mobList[zoneID][64 ].NMchildren = { true, 155                } -- Nightmare Crab                        ( 064 )
xi.dynamis.mobList[zoneID][65 ].NMchildren = { true, 156                } -- Nightmare Crab                        ( 065 )
xi.dynamis.mobList[zoneID][66 ].NMchildren = { true, 157                } -- Nightmare Crab                        ( 066 )
xi.dynamis.mobList[zoneID][67 ].NMchildren = { true, 158                } -- Nightmare Crab                        ( 067 )
xi.dynamis.mobList[zoneID][68 ].NMchildren = { true, 159                } -- Nightmare Crab                        ( 068 )
xi.dynamis.mobList[zoneID][69 ].NMchildren = { true, 160                } -- Nightmare Crab                        ( 069 )
xi.dynamis.mobList[zoneID][70 ].NMchildren = { true, 161                } -- Nightmare Crab                        ( 070 )
xi.dynamis.mobList[zoneID][71 ].NMchildren = { true, 162                } -- Nightmare Crab                        ( 071 )
xi.dynamis.mobList[zoneID][72 ].NMchildren = { true, 163                } -- Nightmare Eft                         ( 072 )
xi.dynamis.mobList[zoneID][73 ].NMchildren = { true, 164                } -- Nightmare Eft                         ( 073 )
xi.dynamis.mobList[zoneID][74 ].NMchildren = { true, 165                } -- Nightmare Eft                         ( 074 )
xi.dynamis.mobList[zoneID][75 ].NMchildren = { true, 166                } -- Nightmare Eft                         ( 075 )
xi.dynamis.mobList[zoneID][76 ].NMchildren = { true, 167                } -- Nightmare Eft                         ( 076 )
xi.dynamis.mobList[zoneID][77 ].NMchildren = { true, 168                } -- Nightmare Eft                         ( 077 )
xi.dynamis.mobList[zoneID][78 ].NMchildren = { true, 169                } -- Nightmare Eft                         ( 078 )
xi.dynamis.mobList[zoneID][79 ].NMchildren = { true, 170                } -- Nightmare Eft                         ( 079 )
xi.dynamis.mobList[zoneID][80 ].NMchildren = { true, 171                } -- Nightmare Eft                         ( 080 )
xi.dynamis.mobList[zoneID][81 ].NMchildren = { true, 172                } -- Nightmare Eft                         ( 081 )
xi.dynamis.mobList[zoneID][82 ].NMchildren = { true, 173                } -- Nightmare Bunny                       ( 082 )
xi.dynamis.mobList[zoneID][83 ].NMchildren = { true, 174                } -- Nightmare Bunny                       ( 083 )
xi.dynamis.mobList[zoneID][84 ].NMchildren = { true, 175                } -- Nightmare Bunny                       ( 084 )
xi.dynamis.mobList[zoneID][85 ].NMchildren = { true, 176                } -- Nightmare Bunny                       ( 085 )
xi.dynamis.mobList[zoneID][86 ].NMchildren = { true, 177                } -- Nightmare Bunny                       ( 086 )
xi.dynamis.mobList[zoneID][87 ].NMchildren = { true, 178                } -- Nightmare Bunny                       ( 087 )
xi.dynamis.mobList[zoneID][88 ].NMchildren = { true, 179                } -- Nightmare Bunny                       ( 088 )
xi.dynamis.mobList[zoneID][89 ].NMchildren = { true, 180                } -- Nightmare Bunny                       ( 089 )
xi.dynamis.mobList[zoneID][90 ].NMchildren = { true, 181                } -- Nightmare Bunny                       ( 090 )
xi.dynamis.mobList[zoneID][91 ].NMchildren = { true, 182                } -- Nightmare Bunny                       ( 091 )
xi.dynamis.mobList[zoneID][92 ].NMchildren = { true, 183, 184, 185      } -- Nightmare Cockatrice                  ( 092 )
xi.dynamis.mobList[zoneID][93 ].NMchildren = { true, 186, 187, 188      } -- Nightmare Cockatrice                  ( 093 )
xi.dynamis.mobList[zoneID][94 ].NMchildren = { true, 189, 190, 191      } -- Nightmare Cockatrice                  ( 094 )
xi.dynamis.mobList[zoneID][95 ].NMchildren = { true, 192, 193, 194      } -- Nightmare Cockatrice                  ( 095 )
xi.dynamis.mobList[zoneID][96 ].NMchildren = { true, 195, 196, 197      } -- Nightmare Cockatrice                  ( 096 )
xi.dynamis.mobList[zoneID][97 ].NMchildren = { true, 198, 199           } -- Nightmare Mandragora                  ( 097 )
xi.dynamis.mobList[zoneID][98 ].NMchildren = { true, 200, 201           } -- Nightmare Mandragora                  ( 098 )
xi.dynamis.mobList[zoneID][99 ].NMchildren = { true, 202, 203           } -- Nightmare Mandragora                  ( 099 )
xi.dynamis.mobList[zoneID][100].NMchildren = { true, 204, 205           } -- Nightmare Mandragora                  ( 100 )
xi.dynamis.mobList[zoneID][101].NMchildren = { true, 206, 207           } -- Nightmare Mandragora                  ( 101 )
xi.dynamis.mobList[zoneID][102].NMchildren = { true, 208, 209           } -- Nightmare Mandragora                  ( 102 )
xi.dynamis.mobList[zoneID][103].NMchildren = { true, 210, 211           } -- Nightmare Mandragora                  ( 103 )
xi.dynamis.mobList[zoneID][104].NMchildren = { true, 212, 213           } -- Nightmare Mandragora                  ( 104 )
xi.dynamis.mobList[zoneID][105].NMchildren = { true, 214                } -- Nightmare Raven                       ( 105 )
xi.dynamis.mobList[zoneID][106].NMchildren = { true, 215                } -- Nightmare Raven                       ( 106 )
xi.dynamis.mobList[zoneID][107].NMchildren = { true, 216                } -- Nightmare Raven                       ( 107 )
xi.dynamis.mobList[zoneID][108].NMchildren = { true, 217                } -- Nightmare Raven                       ( 108 )
xi.dynamis.mobList[zoneID][109].NMchildren = { true, 218                } -- Nightmare Raven                       ( 109 )
xi.dynamis.mobList[zoneID][110].NMchildren = { true, 219                } -- Nightmare Raven                       ( 110 )
xi.dynamis.mobList[zoneID][111].NMchildren = { true, 220                } -- Nightmare Raven                       ( 111 )
xi.dynamis.mobList[zoneID][112].NMchildren = { true, 221                } -- Nightmare Raven                       ( 112 )
xi.dynamis.mobList[zoneID][113].NMchildren = { true, 222                } -- Nightmare Raven                       ( 113 )
xi.dynamis.mobList[zoneID][114].NMchildren = { true, 223                } -- Nightmare Raven                       ( 114 )
xi.dynamis.mobList[zoneID][115].NMchildren = { true, 224                } -- Nightmare Raven                       ( 115 )
xi.dynamis.mobList[zoneID][116].NMchildren = { true, 225                } -- Nightmare Raven                       ( 116 )
xi.dynamis.mobList[zoneID][117].NMchildren = { true, 226                } -- Nightmare Raven                       ( 117 )
xi.dynamis.mobList[zoneID][118].NMchildren = { true, 227                } -- Nightmare Dhalmel                     ( 118 )
xi.dynamis.mobList[zoneID][119].NMchildren = { true, 228                } -- Nightmare Dhalmel                     ( 119 )
xi.dynamis.mobList[zoneID][120].NMchildren = { true, 229                } -- Nightmare Dhalmel                     ( 120 )
xi.dynamis.mobList[zoneID][121].NMchildren = { true, 230                } -- Nightmare Dhalmel                     ( 121 )
xi.dynamis.mobList[zoneID][122].NMchildren = { true, 231                } -- Nightmare Dhalmel                     ( 122 )
xi.dynamis.mobList[zoneID][123].NMchildren = { true, 232                } -- Nightmare Dhalmel                     ( 123 )
xi.dynamis.mobList[zoneID][124].NMchildren = { true, 233                } -- Nightmare Dhalmel                     ( 124 )
xi.dynamis.mobList[zoneID][125].NMchildren = { true, 234, 235           } -- Nightmare Dhalmel                     ( 125 )
xi.dynamis.mobList[zoneID][126].NMchildren = { true, 236, 237           } -- Nightmare Dhalmel                     ( 126 )
xi.dynamis.mobList[zoneID][127].NMchildren = { true, 238, 239           } -- Nightmare Dhalmel                     ( 127 )
xi.dynamis.mobList[zoneID][128].NMchildren = { true, 240, 241           } -- Nightmare Dhalmel                     ( 128 )
xi.dynamis.mobList[zoneID][129].NMchildren = { true, 242                } -- Nightmare Crawler                     ( 129 )
xi.dynamis.mobList[zoneID][130].NMchildren = { true, 243                } -- Nightmare Crawler                     ( 130 )
xi.dynamis.mobList[zoneID][131].NMchildren = { true, 244                } -- Nightmare Crawler                     ( 131 )
xi.dynamis.mobList[zoneID][132].NMchildren = { true, 245, 246           } -- Nightmare Crawler                     ( 132 )
xi.dynamis.mobList[zoneID][133].NMchildren = { true, 247, 248           } -- Nightmare Crawler                     ( 133 )
xi.dynamis.mobList[zoneID][134].NMchildren = { true, 249                } -- Nightmare Crawler                     ( 134 )
xi.dynamis.mobList[zoneID][135].NMchildren = { true, 250                } -- Nightmare Crawler                     ( 135 )
xi.dynamis.mobList[zoneID][136].NMchildren = { true, 251                } -- Nightmare Crawler                     ( 136 )
xi.dynamis.mobList[zoneID][137].NMchildren = { true, 252, 253           } -- Nightmare Crawler                     ( 137 )
xi.dynamis.mobList[zoneID][138].NMchildren = { true, 254, 255           } -- Nightmare Crawler                     ( 138 )
xi.dynamis.mobList[zoneID][139].NMchildren = { true, 256                } -- Nightmare Uragnite                    ( 139 )
xi.dynamis.mobList[zoneID][140].NMchildren = { true, 257                } -- Nightmare Uragnite                    ( 140 )
xi.dynamis.mobList[zoneID][141].NMchildren = { true, 258                } -- Nightmare Uragnite                    ( 141 )
xi.dynamis.mobList[zoneID][142].NMchildren = { true, 259                } -- Nightmare Uragnite                    ( 142 )
xi.dynamis.mobList[zoneID][143].NMchildren = { true, 260                } -- Nightmare Uragnite                    ( 143 )
xi.dynamis.mobList[zoneID][144].NMchildren = { true, 261, 262           } -- Nightmare Uragnite                    ( 144 )
xi.dynamis.mobList[zoneID][145].NMchildren = { true, 263, 264           } -- Nightmare Uragnite                    ( 145 )
xi.dynamis.mobList[zoneID][146].NMchildren = { true, 265, 266           } -- Nightmare Uragnite                    ( 146 )
xi.dynamis.mobList[zoneID][147].NMchildren = { true, 267, 268           } -- Nightmare Uragnite                    ( 147 )
xi.dynamis.mobList[zoneID][148].NMchildren = { true, 269, 270, 271      } -- Nightmare Scorption                   ( 148 )
xi.dynamis.mobList[zoneID][149].NMchildren = { true, 272, 273, 274      } -- Nightmare Scorption                   ( 149 )
xi.dynamis.mobList[zoneID][150].NMchildren = { true, 275, 276, 277      } -- Nightmare Scorption                   ( 150 )
xi.dynamis.mobList[zoneID][151].NMchildren = { true, 278, 279, 280      } -- Nightmare Scorption                   ( 151 )
xi.dynamis.mobList[zoneID][152].NMchildren = { true, 281, 282, 283, 284 } -- Nightmare Scorption                   ( 152 )

------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].pos = {xpos, ypos, zpos, rot}

-- Dragons
xi.dynamis.mobList[zoneID][61 ].pos = {-201.7883, -29.9139, 147.2554, 57 }
xi.dynamis.mobList[zoneID][52 ].pos = {60.7967, -23.0410, 199.0426, 12   }
xi.dynamis.mobList[zoneID][51 ].pos = {-339.9798, -39.0022, 243.1307, 70 }
xi.dynamis.mobList[zoneID][53 ].pos = {232.1226, -9.4403, 211.5448, 20   }
xi.dynamis.mobList[zoneID][54 ].pos = {346.0957, -9.2967, 271.6128, 66   }
xi.dynamis.mobList[zoneID][55 ].pos = {-428.8357, -7.4000, -221.6568, 211}
xi.dynamis.mobList[zoneID][56 ].pos = {-41.1463, -16.0195, -3.8987, 63   }
xi.dynamis.mobList[zoneID][57 ].pos = {-33.7517, 16.1113, -236.2199, 186 }
xi.dynamis.mobList[zoneID][58 ].pos = {36.0265, 0.1348, -233.2813, 193   }
xi.dynamis.mobList[zoneID][59 ].pos = {206.5141, -7.7500, 4.5535, 119    }
xi.dynamis.mobList[zoneID][60 ].pos = {482.4607, 0.9171, -18.3645, 127   }
-- Orc Stats
xi.dynamis.mobList[zoneID][1  ].pos = {-489.6237, -29.8504, 59.9449, 63  }
xi.dynamis.mobList[zoneID][2  ].pos = {-483.8572, -30.9016, 65.4925, 63  }
xi.dynamis.mobList[zoneID][3  ].pos = {-474.6325, -29.7465, 58.5642, 63  }
xi.dynamis.mobList[zoneID][4  ].pos = {-365.3331, -22.1115, 21.2624, 198 }
xi.dynamis.mobList[zoneID][5  ].pos = {-355.8970, -21.9494, 21.5242, 198 }
xi.dynamis.mobList[zoneID][6  ].pos = {-360.7734, -21.8964, 18.8860, 198 }
xi.dynamis.mobList[zoneID][7  ].pos = {-370.3228, -23.2670, 15.0742, 71  }
xi.dynamis.mobList[zoneID][8  ].pos = {-353.7643, -22.5512, 15.7313, 71  }
xi.dynamis.mobList[zoneID][9  ].pos = {-216.7957, -22.1539, 96.7794, 64  }
xi.dynamis.mobList[zoneID][10 ].pos = {-216.1143, -22.1460, 106.0876, 189}
xi.dynamis.mobList[zoneID][11 ].pos = {-208.1248, -21.6153, 101.4173, 189}
xi.dynamis.mobList[zoneID][12 ].pos = {-199.5664, -22.8261, 94.8028, 9   }
xi.dynamis.mobList[zoneID][13 ].pos = {-199.2854, -22.8656, 105.3254, 195}
-- Goblin Stats
xi.dynamis.mobList[zoneID][14 ].pos = {-30.1739, -13.7288, 61.2518, 82   }
xi.dynamis.mobList[zoneID][15 ].pos = {-24.6467, -13.2863, 58.9652, 82   }
xi.dynamis.mobList[zoneID][16 ].pos = { -15.2367, -13.3332, 57.8845, 82  }
xi.dynamis.mobList[zoneID][17 ].pos = {26.1893, -13.1639, 61.5514, 74    }
xi.dynamis.mobList[zoneID][18 ].pos = {36.0939, -13.8959, 61.0378, 74    }
xi.dynamis.mobList[zoneID][19 ].pos = {47.8134, -12.8931, 60.0505, 74    }
xi.dynamis.mobList[zoneID][20 ].pos = {-20.4471, -13.5662, -5.0198, 67   }
xi.dynamis.mobList[zoneID][21 ].pos = {-20.9386, -6.1433, -33.5945, 185  }
xi.dynamis.mobList[zoneID][22 ].pos = {-12.7062, -7.3521, -42.6142, 249  }
xi.dynamis.mobList[zoneID][23 ].pos = {-26.1805, -6.9301, -43.9465, 128  }
xi.dynamis.mobList[zoneID][24 ].pos = {-18.5424, -6.0020, -48.6369, 49   }
-- Quadav Stats
xi.dynamis.mobList[zoneID][25 ].pos = {241.4802, -5.7749, 20.1419, 129   }
xi.dynamis.mobList[zoneID][26 ].pos = {257.7976, -2.3514, 22.7234, 129   }
xi.dynamis.mobList[zoneID][27 ].pos = { 279.3134, 2.1576, 20.6812, 129   }
xi.dynamis.mobList[zoneID][28 ].pos = { 302.2001, 2.1881, 96.2034, 170   }
xi.dynamis.mobList[zoneID][29 ].pos = { 299.4405, 2.1729, 82.7570, 170   }
xi.dynamis.mobList[zoneID][30 ].pos = {300.0283, 2.2393, 77.8772, 170    }
xi.dynamis.mobList[zoneID][31 ].pos = {283.6140, 2.1808, 19.5053, 128    }
xi.dynamis.mobList[zoneID][32 ].pos = {299.0122, 2.2500, 37.3500, 128    }
xi.dynamis.mobList[zoneID][33 ].pos = { 298.2328, 2.8144, 16.9182, 128   }
xi.dynamis.mobList[zoneID][34 ].pos = {300.0039, 2.2430, -0.4152, 128    }
xi.dynamis.mobList[zoneID][35 ].pos = {301.2189, 2.5103, -25.6304, 110   }
xi.dynamis.mobList[zoneID][36 ].pos = {299.6303, 2.1966, -37.0409, 110   }
xi.dynamis.mobList[zoneID][37 ].pos = {300.0410, 2.2101, -43.0707, 110   }
-- Yagudo Stats
xi.dynamis.mobList[zoneID][38 ].pos = {351.5531, 2.0022, -60.4356, 196   }
xi.dynamis.mobList[zoneID][39 ].pos = {373.1893, 2.5996, -63.9211, 219   }
xi.dynamis.mobList[zoneID][40 ].pos = {379.2950, 2.1553, -81.4621, 2     }
xi.dynamis.mobList[zoneID][41 ].pos = {351.6066, -0.6636, -190.2410, 1   }
xi.dynamis.mobList[zoneID][42 ].pos = {353.3952, -0.6354, -200.8557, 236 }
xi.dynamis.mobList[zoneID][43 ].pos = {375.5005, -0.6350, -225.3975, 225 }
xi.dynamis.mobList[zoneID][44 ].pos = {412.0664, 2.6627, -221.4059, 189  }
xi.dynamis.mobList[zoneID][45 ].pos = {430.3526, 2.0774, -219.0766, 123  }
xi.dynamis.mobList[zoneID][46 ].pos = {493.5782, 2.5840, -225.4034, 154  }
xi.dynamis.mobList[zoneID][47 ].pos = {501.7607, 2.0000, -247.7523, 169  }
xi.dynamis.mobList[zoneID][48 ].pos = {523.8189, 2.1778, -259.4799, 144  }
xi.dynamis.mobList[zoneID][49 ].pos = {536.0930, 2.2397, -261.7803, 137  }
xi.dynamis.mobList[zoneID][50 ].pos = {553.5475, 1.4175, -261.2966, 126  }
-- Nightmare Crabs
xi.dynamis.mobList[zoneID][62 ].pos = {-30.7958, 19.4184, -308.5479, 130 }
xi.dynamis.mobList[zoneID][63 ].pos = {-31.1747, 15.8897, -278.6635, 168 }
xi.dynamis.mobList[zoneID][64 ].pos = {-13.1607, 15.8045, -251.7880, 164 }
xi.dynamis.mobList[zoneID][65 ].pos = {-0.6842, 16.8508, -217.9911, 228  }
xi.dynamis.mobList[zoneID][66 ].pos = {-43.9131, 16.5957, -214.0052, 243 }
xi.dynamis.mobList[zoneID][67 ].pos = {-68.2952, 15.9799, -253.3839, 79  }
xi.dynamis.mobList[zoneID][68 ].pos = {-89.9767, 16.1424, -234.8192, 48  }
xi.dynamis.mobList[zoneID][69 ].pos = {-120.5364, 16.0000, -238.3332, 103}
xi.dynamis.mobList[zoneID][70 ].pos = {-132.1700, 15.4754, -280.0170, 75 }
xi.dynamis.mobList[zoneID][71 ].pos = {-111.2321, 20.0000, -321.6591, 99 }
-- Nightmare Dhalmel
xi.dynamis.mobList[zoneID][118].pos = {147.0991, -13.8950, 83.2262, 91   }
xi.dynamis.mobList[zoneID][119].pos = {184.7485, -14.7913, 70.9593, 80   }
xi.dynamis.mobList[zoneID][120].pos = {173.1945, -15.7263, 105.4897, 231 }
xi.dynamis.mobList[zoneID][121].pos = {168.6498, -17.3226, 97.7622, 245  }
xi.dynamis.mobList[zoneID][122].pos = {164.7219, -20.3030, 142.5724, 240 }
xi.dynamis.mobList[zoneID][123].pos = {200.3606, -12.1309, 138.5568, 25  }
xi.dynamis.mobList[zoneID][124].pos = {202.5746, -13.5267, 144.1523, 46  }
xi.dynamis.mobList[zoneID][125].pos = {229.5914, -7.8646, 131.2038, 69   }
xi.dynamis.mobList[zoneID][126].pos = {218.4597, -11.5093, 170.9403, 98  }
xi.dynamis.mobList[zoneID][127].pos = {226.7076, -10.4975, 199.3315, 214 }
xi.dynamis.mobList[zoneID][128].pos = {257.5502, -5.7149, 202.1803, 183  }
-- Nightmare Urganite
xi.dynamis.mobList[zoneID][139].pos = {387.0336, 15.3531, 76.0351, 147   }
xi.dynamis.mobList[zoneID][140].pos = {377.8488, 15.0754, 102.8690, 169  }
xi.dynamis.mobList[zoneID][141].pos = {359.6248, 16.2275, 128.5730, 170  }
xi.dynamis.mobList[zoneID][142].pos = {349.6410, 15.6979, 156.5760, 179  }
xi.dynamis.mobList[zoneID][143].pos = {367.1823, 15.1005, 173.3831, 196  }
xi.dynamis.mobList[zoneID][144].pos = {435.8933, 19.9970, 170.3763, 115  }
xi.dynamis.mobList[zoneID][145].pos = {435.6099, 20.0000, 138.3125, 119  }
xi.dynamis.mobList[zoneID][146].pos = {445.4790, 20.0000, 105.9790, 78   }
xi.dynamis.mobList[zoneID][147].pos = {445.8142, 20.0674, 68.9965, 176   }
-- Nightmare Scorpion
xi.dynamis.mobList[zoneID][148].pos = {471.2361, 0.2161, 6.8440, 62      }
xi.dynamis.mobList[zoneID][149].pos = {516.1291, 0.2165, -8.3529, 115    }
xi.dynamis.mobList[zoneID][150].pos = {519.8561, 1.0989, -51.0201, 102   }
xi.dynamis.mobList[zoneID][151].pos = {474.1000, 0.0938, -39.7732, 137   }
xi.dynamis.mobList[zoneID][152].pos = {471.0633, 0.3659, -15.7049, 56    }
--Nightmare Bunny
xi.dynamis.mobList[zoneID][82 ].pos = {-500.4587, -31.1175, 40.6901, 236 }
xi.dynamis.mobList[zoneID][83 ].pos = {-490.4445, -31.8260, 19.6098, 51  }
xi.dynamis.mobList[zoneID][84 ].pos = {-465.3930, -32.6130, 15.1436, 246 }
xi.dynamis.mobList[zoneID][85 ].pos = {-459.7678, -29.8715, 35.0834, 240 }
xi.dynamis.mobList[zoneID][86 ].pos = {-458.8814, -32.5718, 66.9976, 179 }
xi.dynamis.mobList[zoneID][87 ].pos = {-478.2877, -32.0000, 78.9771, 147 }
xi.dynamis.mobList[zoneID][88 ].pos = {-503.5589, -31.2163, 79.4331, 113 }
xi.dynamis.mobList[zoneID][89 ].pos = {-524.4575, -32.0880, 44.5391, 40  }
xi.dynamis.mobList[zoneID][90 ].pos = {-471.6640, -31.7843, -0.3831, 184 }
xi.dynamis.mobList[zoneID][91 ].pos = {-432.8346, -31.8996, 0.7240, 207  }
-- Nightmare Mandragora
xi.dynamis.mobList[zoneID][97 ].pos = {18.8103, -25.6353, 215.0178, 84   }
xi.dynamis.mobList[zoneID][98 ].pos = {-0.9103, -24.2774, 235.0815, 0    }
xi.dynamis.mobList[zoneID][99 ].pos = {-42.1285, -24.0754, 236.0463, 104 }
xi.dynamis.mobList[zoneID][100].pos = {-27.1142, -25.0121, 265.3078, 82  }
xi.dynamis.mobList[zoneID][101].pos = {-62.4796, -29.3045, 273.5851, 222 }
xi.dynamis.mobList[zoneID][102].pos = {-105.0640, -31.3110, 277.3794, 172}
xi.dynamis.mobList[zoneID][103].pos = {-131.7827, -33.5953, 268.1009, 136}
xi.dynamis.mobList[zoneID][104].pos = {57.2546, -23.1384, 198.0793, 78   }
-- Nightmare Crawler
xi.dynamis.mobList[zoneID][129].pos = {319.6010, 0.0000, 361.1112, 80    }
xi.dynamis.mobList[zoneID][130].pos = {323.2807, 0.0000, 357.6271, 91    }
xi.dynamis.mobList[zoneID][131].pos = {338.2596, 0.9850, 325.3451, 252   }
xi.dynamis.mobList[zoneID][132].pos = {317.7736, 0.0000, 319.5869, 247   }
xi.dynamis.mobList[zoneID][133].pos = {278.1880, -8.0000, 319.7731, 107  }
xi.dynamis.mobList[zoneID][134].pos = {371.0742, 0.6000, 228.1120, 74    }
xi.dynamis.mobList[zoneID][135].pos = {374.6455, 0.3026, 216.7436, 65    }
xi.dynamis.mobList[zoneID][136].pos = {400.8975, 0.0391, 235.1942, 177   }
xi.dynamis.mobList[zoneID][137].pos = {433.7487, 0.1114, 201.2834, 121   }
xi.dynamis.mobList[zoneID][138].pos = {397.8453, 0.1269, 190.9244, 55    }
--Nightmare Raven
xi.dynamis.mobList[zoneID][105].pos = {251.3917, -7.5990, -27.2447, 247  }
xi.dynamis.mobList[zoneID][106].pos = {247.8203, -7.7523, -51.8739, 76   }
xi.dynamis.mobList[zoneID][107].pos = {226.7718, -8.4287, -67.0033, 101  }
xi.dynamis.mobList[zoneID][108].pos = {212.1411, -13.9209, -45.4596, 175 }
xi.dynamis.mobList[zoneID][109].pos = {189.4418, -14.5562, -35.2972, 106 }
xi.dynamis.mobList[zoneID][110].pos = {192.6980, -12.6985, -60.3909, 50  }
xi.dynamis.mobList[zoneID][111].pos = {164.4827, -7.9380, -4.5929, 98    }
xi.dynamis.mobList[zoneID][112].pos = {194.2779, -7.9510, 10.4772, 243   }
xi.dynamis.mobList[zoneID][113].pos = {153.4070, -7.2771, -17.0971, 133  }
xi.dynamis.mobList[zoneID][114].pos = {133.5932, -7.9051, -41.3949, 50   }
xi.dynamis.mobList[zoneID][115].pos = {107.4268, -7.9171, -27.6511, 142  }
xi.dynamis.mobList[zoneID][116].pos = {104.9176, -7.3981, 7.3448, 79     }
xi.dynamis.mobList[zoneID][117].pos = {78.0692, -7.9856, 4.3110, 91      }
--Nightmare Eft
xi.dynamis.mobList[zoneID][72 ].pos = {-361.8208, -9.4083, -189.7500, 254}
xi.dynamis.mobList[zoneID][73 ].pos = {-388.3024, -7.6163, -196.1346, 60 }
xi.dynamis.mobList[zoneID][74 ].pos = {-411.7224, -7.6151, -198.3405, 131}
xi.dynamis.mobList[zoneID][75 ].pos = {-444.0339, -8.0858, -193.2675, 164}
xi.dynamis.mobList[zoneID][76 ].pos = {-481.2613, -16.0000, -241.4592, 71}
xi.dynamis.mobList[zoneID][77 ].pos = {-450.6776, -9.8428, -262.6942, 35 }
xi.dynamis.mobList[zoneID][78 ].pos = {-426.0003, -5.8710, -279.0026, 24 }
xi.dynamis.mobList[zoneID][79 ].pos = {-403.1646, 0.0000, -278.8900, 233 }
xi.dynamis.mobList[zoneID][80 ].pos = {-381.4844, -9.1690, -220.7178, 122}
xi.dynamis.mobList[zoneID][81 ].pos = {-355.3060, -8.1887, -200.9366, 245}
--Nightmare Cockatrice
xi.dynamis.mobList[zoneID][92 ].pos = {-313.1621, -39.8093, 257.1451, 19 }
xi.dynamis.mobList[zoneID][93 ].pos = {-352.1228, -39.8073, 236.7914, 139}
xi.dynamis.mobList[zoneID][94 ].pos = {-334.8820, -31.3485, 204.2709, 51 }
xi.dynamis.mobList[zoneID][95].pos = {-357.9044, -32.3993, 154.4069, 9  }
xi.dynamis.mobList[zoneID][96].pos = {-318.5551, -23.0392, 139.2384, 11 }

----------------------------------------------------------------------------------------------------
--                                    Setup of Mob Functions                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--             Patrol Paths             --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].patrolPath = {xpos1,ypos1,zpos1, xpos2,ypos2,zpos2,  xpos3,ypos3,zpos3}

------------------------------------------
--          Statue Eye Colors           --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eyes.BLUE -- Flags for blue eyes. (HP)
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eyes.GREEN -- Flags for green eyes. (MP)
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eyes.RED -- Flags for red eyes. (TE)

xi.dynamis.mobList[zoneID][2  ].eyes = xi.dynamis.eyes.GREEN
xi.dynamis.mobList[zoneID][9  ].eyes = xi.dynamis.eyes.BLUE
xi.dynamis.mobList[zoneID][10 ].eyes = xi.dynamis.eyes.GREEN
xi.dynamis.mobList[zoneID][12 ].eyes = xi.dynamis.eyes.GREEN
xi.dynamis.mobList[zoneID][13 ].eyes = xi.dynamis.eyes.BLUE
xi.dynamis.mobList[zoneID][20 ].eyes = xi.dynamis.eyes.GREEN
xi.dynamis.mobList[zoneID][22 ].eyes = xi.dynamis.eyes.BLUE
xi.dynamis.mobList[zoneID][23 ].eyes = xi.dynamis.eyes.BLUE
xi.dynamis.mobList[zoneID][24 ].eyes = xi.dynamis.eyes.GREEN
xi.dynamis.mobList[zoneID][34 ].eyes = xi.dynamis.eyes.GREEN
xi.dynamis.mobList[zoneID][38 ].eyes = xi.dynamis.eyes.GREEN
xi.dynamis.mobList[zoneID][39 ].eyes = xi.dynamis.eyes.BLUE
xi.dynamis.mobList[zoneID][41 ].eyes = xi.dynamis.eyes.BLUE
xi.dynamis.mobList[zoneID][44 ].eyes = xi.dynamis.eyes.GREEN
xi.dynamis.mobList[zoneID][45 ].eyes = xi.dynamis.eyes.BLUE

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].timeExtension = 15

xi.dynamis.mobList[zoneID][61].timeExtension = 60
