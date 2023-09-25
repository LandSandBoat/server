----------------------------------------------------------------------------------------------------
--                                      Dynamis-Valkurm                                           --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/val.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/val.html        --
--                       NOTE: Please refer to instructions for setup.                            --
----------------------------------------------------------------------------------------------------
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
--    Statue Ex. xi.dynamis.mobList[zoneID][MobIndex].info = {"Statue", "Serjeant Tombstone", nil, nil, nil}
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
-- 7.  xi.dynamis.mobList[zoneID][MobIndex].nmchildren is used to spawn specific NMs outlined in xi.dynamis.mobList[zoneID][MobIndex].info
--     MobIndex is the index of the mob spawning the NM, MobIndex(NM) points to which NM in .info it should spawn.
--     Ex. xi.dynamis.mobList[zoneID][MobIndex].nmchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
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
local zoneID = xi.zone.DYNAMIS_VALKURM
local i = 1
xi = xi or {} -- Ignore me I just set the global.
xi.dynamis = xi.dynamis or {} -- Ignore me I just set the global.
xi.dynamis.mobList = xi.dynamis.mobList or { } -- Ignore me I just set the global.
xi.dynamis.mobList[zoneID] = { } -- Ignore me, I just start the table.
xi.dynamis.mobList[zoneID].nmchildren = { }
xi.dynamis.mobList[zoneID].mobchildren = { }
xi.dynamis.mobList[zoneID].maxWaves = 2 -- Put in number of max waves

while i <= 290 do
    table.insert(xi.dynamis.mobList[zoneID], i, { id = i})
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
--xi.dynamis.mobList[zoneID][MobIndex].info = {"Statue/NM/Nightmare", "Mob Name", "Family", "Main Job", "MobLocalVarName"}

-- Wave 1
-- Nightmare Mobs + NMs Based on https://enedin.be/dyna/html/zone/frame_val1.htm
-- Nightmare Mobs
-- Hippogryph Sands
xi.dynamis.mobList[zoneID][21 ].info = {"Nightmare", "Nightmare Fly", nil, nil, "fly1_killed"} -- ( 021 ) Nightmare Fly Recovers Subjobs
-- Sheep Sands
xi.dynamis.mobList[zoneID][22 ].info = {"Nightmare", "Nightmare Fly", nil, nil, "fly2_killed"} -- ( 022 )  Nightmare Fly Recover Subjobs
-- Manticore Sands
xi.dynamis.mobList[zoneID][23 ].info = {"Nightmare", "Nightmare Fly", nil, nil, "fly3_killed"} -- ( 023 ) Nightmare Fly Recover Subjobs

-- NM based on https://enedin.be/dyna/html/zone/frame_val1.htm
-- Funguar NM Area
xi.dynamis.mobList[zoneID][5  ].info = {"NM", "Fairy Ring", nil, nil, "fairy_ring_killed"} -- ( 005 ) Fairy Ring - Inhibits Cirrate Christelle's 'Miasmic Breath' effect; Removes Cirrate Christelle's enhanced movement speed
-- Flytrap NM Area
xi.dynamis.mobList[zoneID][10 ].info = {"NM", "Dragontrap_1", nil, nil, "dragontrap1_killed"} -- ( 010 ) Flytrap NMs (Dragontrap ×3)
xi.dynamis.mobList[zoneID][287].info = {"NM", "Dragontrap_2", nil, nil, "dragontrap2_killed"} -- Inhibits Cirrate Christelle's 'Putrid Breath' effect
xi.dynamis.mobList[zoneID][288].info = {"NM", "Dragontrap_3", nil, nil, "dragontrap3_killed"} -- Makes Cirrate Christelle unable to summon Nightmare Morbols
-- Treant NM Area
xi.dynamis.mobList[zoneID][15 ].info = {"NM", "Stcemqestcint", nil, nil, "stcemqestcint_killed"} -- ( 015 ) Stcemqestcint - Inhibits Cirrate Christelle's 'Vampiric Lash' effect
-- Gobbue NM Area
xi.dynamis.mobList[zoneID][20 ].info = {"NM", "Nant'ina", nil, nil, "nantina_killed"} -- ( 020 ) Nant'ina - Inhibits Cirrate Christelle's 'Fragrant Breath' effect
-- Boss Area
xi.dynamis.mobList[zoneID][24 ].info = {"NM", "Cirrate Christelle", nil, nil, "MegaBoss_Killed"} -- ( 024 ) Cirrate Christelle - Spawns 025-052
xi.dynamis.mobList[zoneID][289].info = {"NM", "Nightmare Morbol", nil, nil, "morbol1_killed"} -- Spawned by Cirrate Christelle
xi.dynamis.mobList[zoneID][290].info = {"NM", "Nightmare Morbol", nil, nil, "morbol2_killed"} -- Spawned by Cirrate Christelle
-- Spawns
xi.dynamis.mobList[zoneID][25 ].info = {"Statue",    "Goblin Replica",       "Goblin", nil, nil}  -- (025-G)
xi.dynamis.mobList[zoneID][26 ].info = {"Statue",    "Manifest Icon",        "Yagudo", nil, nil}  -- (026-Y)
xi.dynamis.mobList[zoneID][27 ].info = {"Statue",    "Adamantking Effigy",    "Quadav", nil, nil} -- (027-Q)
xi.dynamis.mobList[zoneID][28 ].info = {"Statue",    "Serjeant Tombstone",   "Orc",    nil, nil}  -- (028-O)
xi.dynamis.mobList[zoneID][29 ].info = {"Nightmare", "Nightmare Manticore",  nil,      nil, nil}  -- ( 029 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][136].info = {"Nightmare", "Nightmare Manticore",  nil,      nil, nil}  -- ( 029 )
xi.dynamis.mobList[zoneID][137].info = {"Nightmare", "Nightmare Manticore",  nil,      nil, nil}  -- ( 029 )
xi.dynamis.mobList[zoneID][30 ].info = {"Nightmare", "Nightmare Hippogryph", nil,      nil, nil}  -- ( 030 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][138].info = {"Nightmare", "Nightmare Hippogryph", nil,      nil, nil}  -- ( 030 )
xi.dynamis.mobList[zoneID][139].info = {"Nightmare", "Nightmare Hippogryph", nil,      nil, nil}  -- ( 030 )
xi.dynamis.mobList[zoneID][31 ].info = {"Nightmare", "Nightmare Sabotender", nil,      nil, nil}  -- ( 031 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][140].info = {"Nightmare", "Nightmare Sabotender", nil,      nil, nil}  -- ( 031 )
xi.dynamis.mobList[zoneID][141].info = {"Nightmare", "Nightmare Sabotender", nil,      nil, nil}  -- ( 031 )
xi.dynamis.mobList[zoneID][32 ].info = {"Nightmare", "Nightmare Sheep",      nil,      nil, nil}  -- ( 032 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][142].info = {"Nightmare", "Nightmare Sheep",      nil,      nil, nil}  -- ( 032 )
xi.dynamis.mobList[zoneID][143].info = {"Nightmare", "Nightmare Sheep",      nil,      nil, nil}  -- ( 032 )

-- Initial Statues based on https://enedin.be/dyna/html/zone/frame_val1.htm
-- Funguar NM Area
xi.dynamis.mobList[zoneID][1  ].info = {"Statue", "Manifest Icon",      "Yagudo", nil, nil} -- (001-Y)
xi.dynamis.mobList[zoneID][2  ].info = {"Statue", "Manifest Icon",      "Yagudo", nil, nil} -- (002-Y)
xi.dynamis.mobList[zoneID][3  ].info = {"Statue", "Manifest Icon",      "Yagudo", nil, nil} -- (003-Y)
xi.dynamis.mobList[zoneID][4  ].info = {"Statue", "Manifest Icon",      "Yagudo", nil, nil} -- (004-Y)
-- Flytrap NM Area
xi.dynamis.mobList[zoneID][6  ].info = {"Statue", "Goblin Replica",     "Goblin", nil, nil} -- (006-G)
xi.dynamis.mobList[zoneID][7  ].info = {"Statue", "Goblin Replica",     "Goblin", nil, nil} -- (007-G)
xi.dynamis.mobList[zoneID][8  ].info = {"Statue", "Goblin Replica",     "Goblin", nil, nil} -- (008-G)
xi.dynamis.mobList[zoneID][9  ].info = {"Statue", "Goblin Replica",     "Goblin", nil, nil} -- (009-G)
-- Treant NM Area
xi.dynamis.mobList[zoneID][11 ].info = {"Statue", "Serjeant Tombstone", "Orc",    nil, nil} -- (011-O)
xi.dynamis.mobList[zoneID][12 ].info = {"Statue", "Serjeant Tombstone", "Orc",    nil, nil} -- (012-O)
xi.dynamis.mobList[zoneID][13 ].info = {"Statue", "Serjeant Tombstone", "Orc",    nil, nil} -- (013-O)
xi.dynamis.mobList[zoneID][14 ].info = {"Statue", "Serjeant Tombstone", "Orc",    nil, nil} -- (014-O)
-- Goobbue NM Area
xi.dynamis.mobList[zoneID][16 ].info = {"Statue", "Adamantking Effigy",  "Quadav", nil, nil} -- (016-Q)
xi.dynamis.mobList[zoneID][17 ].info = {"Statue", "Adamantking Effigy",  "Quadav", nil, nil} -- (017-Q)
xi.dynamis.mobList[zoneID][18 ].info = {"Statue", "Adamantking Effigy",  "Quadav", nil, nil} -- (018-Q)
xi.dynamis.mobList[zoneID][19 ].info = {"Statue", "Adamantking Effigy",  "Quadav", nil, nil} -- (019-Q)

-- Wave 2 Manticore Sands and Goobubue NM Area
-- Nightmare Mobs + NMs Based on https://enedin.be/dyna/html/zone/frame_val2.htm
-- Nightmare Mobs
xi.dynamis.mobList[zoneID][110].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 110 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][244].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 110 )
xi.dynamis.mobList[zoneID][245].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 110 )
xi.dynamis.mobList[zoneID][111].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 111 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][246].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 111 )
xi.dynamis.mobList[zoneID][247].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 111 )
xi.dynamis.mobList[zoneID][112].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 112 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][248].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 112 )
xi.dynamis.mobList[zoneID][249].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 112 )
xi.dynamis.mobList[zoneID][113].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 113 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][250].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 113 )
xi.dynamis.mobList[zoneID][251].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 113 )
xi.dynamis.mobList[zoneID][114].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 114 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][252].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 114 )
xi.dynamis.mobList[zoneID][253].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 114 )
xi.dynamis.mobList[zoneID][115].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 115 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][254].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 115 )
xi.dynamis.mobList[zoneID][255].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 115 )
xi.dynamis.mobList[zoneID][116].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 116 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][256].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 116 )
xi.dynamis.mobList[zoneID][257].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 116 )
xi.dynamis.mobList[zoneID][117].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 117 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][258].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 117 )
xi.dynamis.mobList[zoneID][259].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 117 )
xi.dynamis.mobList[zoneID][118].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 118 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][260].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 118 )
xi.dynamis.mobList[zoneID][261].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 118 )
xi.dynamis.mobList[zoneID][119].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 119 ) Nightmare Manticore (×4)
xi.dynamis.mobList[zoneID][262].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 119 )
xi.dynamis.mobList[zoneID][263].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 119 )
xi.dynamis.mobList[zoneID][264].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 119 )
xi.dynamis.mobList[zoneID][120].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 120 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][265].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 120 )
xi.dynamis.mobList[zoneID][266].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 120 )
xi.dynamis.mobList[zoneID][121].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 121 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][267].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 121 )
xi.dynamis.mobList[zoneID][268].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 121 )
xi.dynamis.mobList[zoneID][122].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 122 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][269].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 122 )
xi.dynamis.mobList[zoneID][270].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 122 )
xi.dynamis.mobList[zoneID][123].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 123 ) Nightmare Manticore (×4)
xi.dynamis.mobList[zoneID][271].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 123 )
xi.dynamis.mobList[zoneID][272].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 123 )
xi.dynamis.mobList[zoneID][273].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 123 )
xi.dynamis.mobList[zoneID][124].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 124 ) Nightmare Manticore (×4)
xi.dynamis.mobList[zoneID][274].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 124 )
xi.dynamis.mobList[zoneID][275].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 124 )
xi.dynamis.mobList[zoneID][276].info = {"Nightmare", "Nightmare Manticore", nil, nil, nil} -- ( 124 )
-- Goobbue NM Area
xi.dynamis.mobList[zoneID][125].info = {"Nightmare", "Nightmare Manticore",  nil, nil, nil} -- ( 125 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][277].info = {"Nightmare", "Nightmare Manticore",  nil, nil, nil} -- ( 125 )
xi.dynamis.mobList[zoneID][278].info = {"Nightmare", "Nightmare Manticore",  nil, nil, nil} -- ( 125 )
xi.dynamis.mobList[zoneID][126].info = {"Nightmare", "Nightmare Manticore",  nil, nil, nil} -- ( 126 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][279].info = {"Nightmare", "Nightmare Manticore",  nil, nil, nil} -- ( 126 )
xi.dynamis.mobList[zoneID][280].info = {"Nightmare", "Nightmare Manticore",  nil, nil, nil} -- ( 126 )
xi.dynamis.mobList[zoneID][127].info = {"Nightmare", "Nightmare Manticore",  nil, nil, nil} -- ( 127 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][281].info = {"Nightmare", "Nightmare Manticore",  nil, nil, nil} -- ( 127 )
xi.dynamis.mobList[zoneID][282].info = {"Nightmare", "Nightmare Manticore",  nil, nil, nil} -- ( 127 )
xi.dynamis.mobList[zoneID][128].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 128 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][283].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 128 )
xi.dynamis.mobList[zoneID][284].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 128 )
xi.dynamis.mobList[zoneID][129].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 129 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][285].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 129 )
xi.dynamis.mobList[zoneID][286].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 129 )

-- Wave 3 Sheep Sands and Treant NM Area
-- Nightmare Mobs + NMs Based on https://enedin.be/dyna/html/zone/frame_val2.htm
-- Nightmare Mobs
xi.dynamis.mobList[zoneID][87 ].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 087 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][212].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 087 )
xi.dynamis.mobList[zoneID][213].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 087 )
xi.dynamis.mobList[zoneID][88 ].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 088 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][214].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 088 )
xi.dynamis.mobList[zoneID][215].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 088 )
xi.dynamis.mobList[zoneID][89 ].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 089 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][216].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 089 )
xi.dynamis.mobList[zoneID][217].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 089 )
xi.dynamis.mobList[zoneID][90 ].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 090 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][218].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 090 )
xi.dynamis.mobList[zoneID][219].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 090 )
xi.dynamis.mobList[zoneID][91 ].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 091 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][220].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 091 )
xi.dynamis.mobList[zoneID][221].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 091 )
xi.dynamis.mobList[zoneID][92 ].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 092 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][222].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 092 )
xi.dynamis.mobList[zoneID][223].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 092 )
xi.dynamis.mobList[zoneID][93 ].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 093 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][224].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 093 )
xi.dynamis.mobList[zoneID][94 ].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 094 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][225].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 094 )
xi.dynamis.mobList[zoneID][95 ].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 095 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][226].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 095 )
xi.dynamis.mobList[zoneID][96 ].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 096 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][227].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 096 )
xi.dynamis.mobList[zoneID][97 ].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 097 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][228].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 097 )
xi.dynamis.mobList[zoneID][98 ].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 098 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][229].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 098 )
xi.dynamis.mobList[zoneID][99 ].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 099 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][230].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 099 )
xi.dynamis.mobList[zoneID][100].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 100 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][231].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 100 )
xi.dynamis.mobList[zoneID][101].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 101 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][232].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 101 )
xi.dynamis.mobList[zoneID][102].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 102 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][233].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 102 )
xi.dynamis.mobList[zoneID][103].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 103 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][234].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 103 )
xi.dynamis.mobList[zoneID][104].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 104 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][235].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 104 )
xi.dynamis.mobList[zoneID][105].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 105 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][236].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 105 )
xi.dynamis.mobList[zoneID][106].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 106 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][237].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 106 )
xi.dynamis.mobList[zoneID][107].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 107 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][238].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 107 )
xi.dynamis.mobList[zoneID][239].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 107 )
xi.dynamis.mobList[zoneID][108].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 108 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][240].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 108 )
xi.dynamis.mobList[zoneID][241].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 108 )
xi.dynamis.mobList[zoneID][109].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 109 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][242].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 109 )
xi.dynamis.mobList[zoneID][243].info = {"Nightmare", "Nightmare Sheep", nil, nil, nil} -- ( 109 )

-- Wave 4 Hippogryph Sands and Flytrap NM Area
-- Nightmare Mobs + NMs Based on https://enedin.be/dyna/html/zone/frame_val2.htm
-- Nightmare Mobs
-- Hippogryph Sands
xi.dynamis.mobList[zoneID][59 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 059 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][156].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 059 )
xi.dynamis.mobList[zoneID][157].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 059 )
xi.dynamis.mobList[zoneID][60 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 060 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][158].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 060 )
xi.dynamis.mobList[zoneID][159].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 060 )
xi.dynamis.mobList[zoneID][61 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 061 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][160].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 061 )
xi.dynamis.mobList[zoneID][161].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 061 )
xi.dynamis.mobList[zoneID][62 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 062 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][162].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 062 )
xi.dynamis.mobList[zoneID][163].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 062 )
xi.dynamis.mobList[zoneID][63 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 063 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][164].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 063 )
xi.dynamis.mobList[zoneID][165].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 063 )
xi.dynamis.mobList[zoneID][64 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 064 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][166].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 064 )
xi.dynamis.mobList[zoneID][167].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 064 )
xi.dynamis.mobList[zoneID][65 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 065 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][168].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 065 )
xi.dynamis.mobList[zoneID][169].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 065 )
xi.dynamis.mobList[zoneID][66 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 066 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][170].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 066 )
xi.dynamis.mobList[zoneID][171].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 066 )
xi.dynamis.mobList[zoneID][67 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 067 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][172].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 067 )
xi.dynamis.mobList[zoneID][173].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 067 )
xi.dynamis.mobList[zoneID][68 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 068 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][174].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 068 )
xi.dynamis.mobList[zoneID][175].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 068 )
xi.dynamis.mobList[zoneID][69 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 069 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][176].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 069 )
xi.dynamis.mobList[zoneID][177].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 069 )
xi.dynamis.mobList[zoneID][70 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 070 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][178].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 070 )
xi.dynamis.mobList[zoneID][179].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 070 )
xi.dynamis.mobList[zoneID][71 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 071 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][180].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 071 )
xi.dynamis.mobList[zoneID][181].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 071 )
xi.dynamis.mobList[zoneID][72 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 072 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][182].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 072 )
xi.dynamis.mobList[zoneID][183].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 072 )
xi.dynamis.mobList[zoneID][73 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 073 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][184].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 073 )
xi.dynamis.mobList[zoneID][185].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 073 )
xi.dynamis.mobList[zoneID][74 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 074 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][186].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 074 )
xi.dynamis.mobList[zoneID][187].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 074 )
xi.dynamis.mobList[zoneID][75 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 075 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][188].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 075 )
xi.dynamis.mobList[zoneID][189].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 075 )
xi.dynamis.mobList[zoneID][76 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 076 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][190].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 076 )
xi.dynamis.mobList[zoneID][191].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 076 )
xi.dynamis.mobList[zoneID][77 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 077 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][192].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 077 )
xi.dynamis.mobList[zoneID][193].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 077 )
xi.dynamis.mobList[zoneID][78 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 078 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][194].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 078 )
xi.dynamis.mobList[zoneID][195].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 078 )
xi.dynamis.mobList[zoneID][79 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 079 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][196].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 079 )
xi.dynamis.mobList[zoneID][197].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 079 )
xi.dynamis.mobList[zoneID][80 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 080 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][198].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 080 )
xi.dynamis.mobList[zoneID][199].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 080 )
xi.dynamis.mobList[zoneID][81 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 081 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][200].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 081 )
xi.dynamis.mobList[zoneID][201].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 081 )
xi.dynamis.mobList[zoneID][82 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 082 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][202].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 082 )
xi.dynamis.mobList[zoneID][203].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 082 )
-- Flytrap NM Area
xi.dynamis.mobList[zoneID][83 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 083 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][204].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 083 )
xi.dynamis.mobList[zoneID][205].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 083 )
xi.dynamis.mobList[zoneID][84 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 084 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][206].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 084 )
xi.dynamis.mobList[zoneID][207].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 084 )
xi.dynamis.mobList[zoneID][85 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 085 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][208].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 085 )
xi.dynamis.mobList[zoneID][209].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 085 )
xi.dynamis.mobList[zoneID][86 ].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 086 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][210].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 086 )
xi.dynamis.mobList[zoneID][211].info = {"Nightmare", "Nightmare Hippogryph", nil, nil, nil} -- ( 086 )

-- Wave 5 Statues based on https://enedin.be/dyna/html/zone/frame_val2.htm
-- Outpost Area
xi.dynamis.mobList[zoneID][33 ].info = {"Statue", "Manifest Icon",       "Yagudo", nil, nil}    -- (033-Y) Manifest Icon
xi.dynamis.mobList[zoneID][34 ].info = {"Statue", "Manifest Icon",       "Yagudo", nil, nil}    -- (034-Y) Manifest Icon
xi.dynamis.mobList[zoneID][35 ].info = {"Statue", "Manifest Icon",       "Yagudo", nil, nil}    -- (035-Y) Manifest Icon
xi.dynamis.mobList[zoneID][36 ].info = {"Statue", "Manifest Icon",       "Yagudo", nil, nil}    -- (036-Y) Manifest Icon
xi.dynamis.mobList[zoneID][37 ].info = {"Statue", "Manifest Icon",       "Yagudo", nil, nil}    -- (037-Y) Manifest Icon
xi.dynamis.mobList[zoneID][38 ].info = {"Statue", "Goblin Replica",      "Goblin", nil, nil}    -- (038-G) Goblin Replica
xi.dynamis.mobList[zoneID][39 ].info = {"Statue", "Goblin Replica",      "Goblin", nil, nil}    -- (039-G) Goblin Replica
xi.dynamis.mobList[zoneID][40 ].info = {"Statue", "Goblin Replica",      "Goblin", nil, nil}    -- (040-G) Goblin Replica
xi.dynamis.mobList[zoneID][41 ].info = {"Statue", "Goblin Replica",      "Goblin", nil, nil}    -- (041-G) Goblin Replica
xi.dynamis.mobList[zoneID][42 ].info = {"Statue", "Goblin Replica",      "Goblin", nil, nil}    -- (042-G) Goblin Replica
xi.dynamis.mobList[zoneID][43 ].info = {"Statue", "Serjeant Tombstone",  "Orc",    nil, nil}    -- (043-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][44 ].info = {"Statue", "Serjeant Tombstone",  "Orc",    nil, nil}    -- (044-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][45 ].info = {"Statue", "Serjeant Tombstone",  "Orc",    nil, nil}    -- (045-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][46 ].info = {"Statue", "Serjeant Tombstone",  "Orc",    nil, nil}    -- (046-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][47 ].info = {"Statue", "Serjeant Tombstone",  "Orc",    nil, nil}    -- (047-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][48 ].info = {"Statue", "Adamantking Effigy",   "Quadav", nil, nil}   -- (048-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][49 ].info = {"Statue", "Adamantking Effigy",   "Quadav", nil, nil}   -- (049-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][50 ].info = {"Statue", "Adamantking Effigy",   "Quadav", nil, nil}   -- (050-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][51 ].info = {"Statue", "Adamantking Effigy",   "Quadav", nil, nil}   -- (051-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][52 ].info = {"Statue", "Adamantking Effigy",   "Quadav", nil, nil}   -- (052-Q) Adamantking Effigy

-- Wave 5 Outpost Area
-- Nightmare Mobs based on https://enedin.be/dyna/html/zone/frame_val2.htm
-- Nightmare Mobs
xi.dynamis.mobList[zoneID][53 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 053 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][144].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 053 )
xi.dynamis.mobList[zoneID][145].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 053 )
xi.dynamis.mobList[zoneID][54 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 054 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][146].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 054 )
xi.dynamis.mobList[zoneID][147].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 054 )
xi.dynamis.mobList[zoneID][55 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 055 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][148].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 055 )
xi.dynamis.mobList[zoneID][149].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 055 )
xi.dynamis.mobList[zoneID][56 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 056 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][150].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 056 )
xi.dynamis.mobList[zoneID][151].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 056 )
xi.dynamis.mobList[zoneID][57 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 057 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][152].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 057 )
xi.dynamis.mobList[zoneID][153].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 057 )
xi.dynamis.mobList[zoneID][58 ].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 058 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][154].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 058 )
xi.dynamis.mobList[zoneID][155].info = {"Nightmare", "Nightmare Sabotender", nil, nil, nil} -- ( 058 )

----------------------------------------------------------------------------------------------------
--                                    Setup of Wave Spawning                                      --
----------------------------------------------------------------------------------------------------

---------------------------------------------
--           Wave Defeat Reqs.          --
--------------------------------------------
--xi.dynamis.mobList[zoneID].waveDefeatRequirements[2] = {zone:getLocalVar("MegaBoss_Killed") == 1}

xi.dynamis.mobList[zoneID].waveDefeatRequirements =
{
    {}, -- Do not touch this is wave 1
    {"MegaBoss_Killed"} -- Spawns Nightmare Mobs
}

------------------------------------------
--            Wave Spawning             --
-- Note: Wave 1 spawns at start.        --
------------------------------------------
--xi.dynamis.mobList[zoneID].wave# = { MobIndex#1, MobIndex#2, MobIndex#3 }

xi.dynamis.mobList[zoneID][1].wave =
{
    21 , -- ( 021 ) Nightmare Flys - Recover subjobs
    22 , -- ( 022 ) Nightmare Flys - Recover subjobs
    23 , -- ( 023 ) Nightmare Flys - Recover subjobs
    5  , -- ( 005 ) Fairy Ring
    10 , -- ( 010 ) Flytrap NMs
    15 , -- ( 015 ) Stcemqestcint
    20 , -- ( 020 ) Nant'ina
    24 , -- ( 024 ) Cirrate Christelle
    1  , -- (001-Y) Manifest Icon
    2  , -- (002-Y) Manifest Icon
    3  , -- (003-Y) Manifest Icon
    4  , -- (004-Y) Manifest Icon
    6  , -- (006-G) Goblin Replica
    7  , -- (007-G) Goblin Replica
    8  , -- (008-G) Goblin Replica
    9  , -- (009-G) Goblin Replica
    11 , -- (011-O) Serjeant Tombstone
    12 , -- (012-O) Serjeant Tombstone
    13 , -- (013-O) Serjeant Tombstone
    14 , -- (014-O) Serjeant Tombstone
    16 , -- (016-Q) Adamantking Effigy
    17 , -- (017-Q) Adamantking Effigy
    18 , -- (018-Q) Adamantking Effigy
    19 , -- (019-Q) Adamantking Effigy
    59 , -- ( 059 ) Nightmare Hippogryph (×3)
    60 , -- ( 060 ) Nightmare Hippogryph (×3)
    61 , -- ( 061 ) Nightmare Hippogryph (×3)
    62 , -- ( 062 ) Nightmare Hippogryph (×3)
    63 , -- ( 063 ) Nightmare Hippogryph (×3)
    64 , -- ( 064 ) Nightmare Hippogryph (×3)
    65 , -- ( 065 ) Nightmare Hippogryph (×3)
    66 , -- ( 066 ) Nightmare Hippogryph (×3)
    67 , -- ( 067 ) Nightmare Hippogryph (×3)
    68 , -- ( 068 ) Nightmare Hippogryph (×3)
    69 , -- ( 069 ) Nightmare Hippogryph (×3)
    70 , -- ( 070 ) Nightmare Hippogryph (×3)
    71 , -- ( 071 ) Nightmare Hippogryph (×3)
    72 , -- ( 072 ) Nightmare Hippogryph (×3)
    73 , -- ( 073 ) Nightmare Hippogryph (×3)
    53 , -- ( 053 ) Nightmare Sabotender (x3)
    54 , -- ( 054 ) Nightmare Sabotender (x3)
    55 , -- ( 055 ) Nightmare Sabotender (x3)
    56 , -- ( 056 ) Nightmare Sabotender (x3)
    57 , -- ( 057 ) Nightmare Sabotender (x3)
    58 , -- ( 058 ) Nightmare Sabotender (x3)
    74 , -- ( 074 ) Nightmare Sabotender (×3)
    75 , -- ( 075 ) Nightmare Sabotender (×3)
    76 , -- ( 076 ) Nightmare Sabotender (×3)
    77 , -- ( 077 ) Nightmare Sabotender (×3)
    78 , -- ( 078 ) Nightmare Sabotender (×3)
    79 , -- ( 079 ) Nightmare Sabotender (×3)
    80 , -- ( 080 ) Nightmare Sabotender (×3)
    81 , -- ( 081 ) Nightmare Sabotender (×3)
    82 , -- ( 082 ) Nightmare Sabotender (×3)
    83 , -- ( 083 ) Nightmare Sabotender (×3)
    84 , -- ( 084 ) Nightmare Hippogryph (×3)
    85 , -- ( 085 ) Nightmare Hippogryph (×3)
    86 , -- ( 086 ) Nightmare Hippogryph (×3)
    87 , -- ( 087 ) Nightmare Sheep (×3)
    88 , -- ( 088 ) Nightmare Sheep (×3)
    89 , -- ( 089 ) Nightmare Sheep (×3)
    90 , -- ( 090 ) Nightmare Sheep (×3)
    91 , -- ( 091 ) Nightmare Sheep (×3)
    92 , -- ( 092 ) Nightmare Sheep (×3)
    93 , -- ( 093 ) Nightmare Sheep (×2)
    94 , -- ( 094 ) Nightmare Sheep (×2)
    95 , -- ( 095 ) Nightmare Sheep (×2)
    96 , -- ( 096 ) Nightmare Sheep (×2)
    97 , -- ( 097 ) Nightmare Sheep (×2)
    98 , -- ( 098 ) Nightmare Sheep (×2)
    99 , -- ( 099 ) Nightmare Sheep (×2)
    100, -- ( 100 ) Nightmare Sheep (×2)
    101, -- ( 101 ) Nightmare Sheep (×2)
    102, -- ( 102 ) Nightmare Sheep (×2)
    103, -- ( 103 ) Nightmare Sheep (×2)
    104, -- ( 104 ) Nightmare Sheep (×2)
    105, -- ( 105 ) Nightmare Sheep (×2)
    106, -- ( 106 ) Nightmare Sheep (×2)
    107, -- ( 107 ) Nightmare Sheep (×3)
    108, -- ( 108 ) Nightmare Sheep (×3)
    109, -- ( 109 ) Nightmare Sheep (×3)
    110, -- ( 110 ) Nightmare Manticore (×3)
    111, -- ( 111 ) Nightmare Manticore (×3)
    112, -- ( 112 ) Nightmare Manticore (×3)
    113, -- ( 113 ) Nightmare Manticore (×3)
    114, -- ( 114 ) Nightmare Manticore (×3)
    115, -- ( 115 ) Nightmare Manticore (×3)
    116, -- ( 116 ) Nightmare Manticore (×3)
    117, -- ( 117 ) Nightmare Manticore (×3)
    118, -- ( 118 ) Nightmare Manticore (×3)
    119, -- ( 119 ) Nightmare Manticore (×4)
    120, -- ( 120 ) Nightmare Manticore (×3)
    121, -- ( 121 ) Nightmare Manticore (×3)
    122, -- ( 122 ) Nightmare Manticore (×3)
    123, -- ( 123 ) Nightmare Manticore (×4)
    124, -- ( 124 ) Nightmare Manticore (×4)
    125, -- ( 125 ) Nightmare Manticore (×3)
    126, -- ( 126 ) Nightmare Manticore (×3)
    127, -- ( 127 ) Nightmare Manticore (×3)
    128, -- ( 128 ) Nightmare Sabotender (×3)
    129  -- ( 129 ) Nightmare Sabotender (×3)
}

xi.dynamis.mobList[zoneID][2].wave =
{
    25 , -- (025-G) Goblin Replica
    26 , -- (026-Y) Manifest Icon
    27 , -- (027-Q) Adamantking Effigy
    28 , -- (028-O) Serjeant Tombstone
    29 , -- ( 029 ) Nightmare Manticore (×3)
    30 , -- ( 030 ) Nightmare Hippogryph (×3)
    31 , -- ( 031 ) Nightmare Sabotender (×3)
    32 , -- ( 032 ) Nightmare Sheep (×3)
    33 , -- (033-Y) Manifest Icon
    34 , -- (034-Y) Manifest Icon
    35 , -- (035-Y) Manifest Icon
    36 , -- (036-Y) Manifest Icon
    37 , -- (037-Y) Manifest Icon
    38 , -- (038-G) Goblin Replica
    39 , -- (039-G) Goblin Replica
    40 , -- (040-G) Goblin Replica
    41 , -- (041-G) Goblin Replica
    42 , -- (042-G) Goblin Replica
    43 , -- (043-O) Serjeant Tombstone
    44 , -- (044-O) Serjeant Tombstone
    45 , -- (045-O) Serjeant Tombstone
    46 , -- (046-O) Serjeant Tombstone
    47 , -- (047-O) Serjeant Tombstone
    48 , -- (048-Q) Adamantking Effigy
    49 , -- (049-Q) Adamantking Effigy
    50 , -- (050-Q) Adamantking Effigy
    51 , -- (051-Q) Adamantking Effigy
    52   -- (052-Q) Adamantking Effigy
}

----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

-- Boss Area
xi.dynamis.mobList[zoneID][25 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- 1 THF 1 DRG 1 SMN
xi.dynamis.mobList[zoneID][26 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- 1 THF 1 DRG 1 SMN
xi.dynamis.mobList[zoneID][27 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- 1 THF 1 DRG 1 SMN
xi.dynamis.mobList[zoneID][28 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- 1 THF 1 DRG 1 SMN
xi.dynamis.mobList[zoneID][1  ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 WHM 1 NIN 1 MNK
xi.dynamis.mobList[zoneID][2  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- 1 BRD 1 BST 1 DRK
xi.dynamis.mobList[zoneID][3  ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 PLD 1 BLM 1 SAM
xi.dynamis.mobList[zoneID][4  ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 WAR 1 RNG 1 RDM
xi.dynamis.mobList[zoneID][6  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- 1 BRD 1 BST 1 DRK
xi.dynamis.mobList[zoneID][7  ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 PLD 1 BLM 1 SAM
xi.dynamis.mobList[zoneID][8  ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 WHM 1 NIN 1 MNK
xi.dynamis.mobList[zoneID][9  ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 WAR 1 RNG 1 RDM
xi.dynamis.mobList[zoneID][11 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 PLD 1 BLM 1 SAM
xi.dynamis.mobList[zoneID][12 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 WAR 1 RNG 1 RDM
xi.dynamis.mobList[zoneID][13 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- 1 BST 1 BRD 1 DRK
xi.dynamis.mobList[zoneID][14 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 WHM 1 NIN 1 MNK
xi.dynamis.mobList[zoneID][16 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 WHM 1 NIN 1 MNK
xi.dynamis.mobList[zoneID][17 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 WAR 1 RNG 1 RDM
xi.dynamis.mobList[zoneID][18 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 PLD 1 BLM 1 SAM
xi.dynamis.mobList[zoneID][19 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- 1 BRD 1 BST 1 DRK
xi.dynamis.mobList[zoneID][33 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 WAR 1 RNG 1 RDM
xi.dynamis.mobList[zoneID][34 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 WHM 1 NIN 1 MNK
xi.dynamis.mobList[zoneID][35 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 PLD 1 BLM 1 SAM
xi.dynamis.mobList[zoneID][36 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- 1 BRD 1 BST 1 DRK
xi.dynamis.mobList[zoneID][37 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- 1 THF 1 DRG 1 SMN
xi.dynamis.mobList[zoneID][38 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 WAR 1 RNG 1 RDM
xi.dynamis.mobList[zoneID][39 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 WHM 1 NIN 1 MNK
xi.dynamis.mobList[zoneID][40 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 PLD 1 BLM 1 SAM
xi.dynamis.mobList[zoneID][41 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- 1 BRD 1 BST 1 DRK
xi.dynamis.mobList[zoneID][42 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- 1 THF 1 DRG 1 SMN
xi.dynamis.mobList[zoneID][43 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 WAR 1 RNG 1 RDM
xi.dynamis.mobList[zoneID][44 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 WHM 1 NIN 1 MNK
xi.dynamis.mobList[zoneID][45 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 PLD 1 BLM 1 SAM
xi.dynamis.mobList[zoneID][46 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- 1 BRD 1 BST 1 DRK
xi.dynamis.mobList[zoneID][47 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- 1 THF 1 DRG 1 SMN
xi.dynamis.mobList[zoneID][48 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 WAR 1 RNG 1 RDM
xi.dynamis.mobList[zoneID][49 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 WHM 1 NIN 1 MNK
xi.dynamis.mobList[zoneID][50 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 PLD 1 BLM 1 SAM
xi.dynamis.mobList[zoneID][51 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil  } -- 1 BRD 1 BST 1 DRK
xi.dynamis.mobList[zoneID][52 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1  } -- 1 THF 1 DRG 1 SMN

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].nmchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

-- Wave 1
-- Boss Arera
xi.dynamis.mobList[zoneID][29 ].nmchildren = { true, 136, 137                       } -- ( 029 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][30 ].nmchildren = { true, 138, 139                       } -- ( 030 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][31 ].nmchildren = { true, 140, 141                       } -- ( 031 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][32 ].nmchildren = { true, 142, 143                       } -- ( 032 ) Nightmare Sheep (×3)
-- Nightmare Mobs
xi.dynamis.mobList[zoneID][53 ].nmchildren = { true, 144, 145                       } -- ( 053 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][54 ].nmchildren = { true, 146, 147                       } -- ( 054 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][55 ].nmchildren = { true, 148, 149                       } -- ( 055 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][56 ].nmchildren = { true, 150, 151                       } -- ( 056 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][57 ].nmchildren = { true, 152, 153                       } -- ( 057 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][58 ].nmchildren = { true, 154, 155                       } -- ( 058 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][59 ].nmchildren = { true, 156, 157                       } -- ( 059 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][60 ].nmchildren = { true, 158, 159                       } -- ( 060 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][61 ].nmchildren = { true, 160, 161                       } -- ( 061 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][62 ].nmchildren = { true, 162, 163                       } -- ( 062 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][63 ].nmchildren = { true, 164, 165                       } -- ( 063 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][64 ].nmchildren = { true, 166, 167                       } -- ( 064 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][65 ].nmchildren = { true, 168, 169                       } -- ( 065 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][66 ].nmchildren = { true, 170, 171                       } -- ( 066 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][67 ].nmchildren = { true, 172, 173                       } -- ( 067 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][68 ].nmchildren = { true, 174, 175                       } -- ( 068 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][69 ].nmchildren = { true, 176, 177                       } -- ( 069 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][70 ].nmchildren = { true, 178, 179                       } -- ( 070 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][71 ].nmchildren = { true, 180, 181                       } -- ( 071 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][72 ].nmchildren = { true, 182, 183                       } -- ( 072 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][73 ].nmchildren = { true, 184, 185                       } -- ( 073 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][74 ].nmchildren = { true, 186, 187                       } -- ( 074 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][75 ].nmchildren = { true, 188, 189                       } -- ( 075 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][76 ].nmchildren = { true, 190, 191                       } -- ( 076 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][77 ].nmchildren = { true, 192, 193                       } -- ( 077 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][78 ].nmchildren = { true, 194, 195                       } -- ( 078 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][79 ].nmchildren = { true, 196, 197                       } -- ( 079 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][80 ].nmchildren = { true, 198, 199                       } -- ( 080 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][81 ].nmchildren = { true, 200, 201                       } -- ( 081 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][82 ].nmchildren = { true, 202, 203                       } -- ( 082 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][83 ].nmchildren = { true, 204, 205                       } -- ( 083 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][84 ].nmchildren = { true, 206, 207                       } -- ( 084 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][85 ].nmchildren = { true, 208, 209                       } -- ( 085 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][86 ].nmchildren = { true, 210, 211                       } -- ( 086 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][87 ].nmchildren = { true, 212, 213                       } -- ( 087 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][88 ].nmchildren = { true, 214, 215                       } -- ( 088 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][89 ].nmchildren = { true, 216, 217                       } -- ( 089 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][90 ].nmchildren = { true, 218, 219                       } -- ( 090 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][91 ].nmchildren = { true, 220, 221                       } -- ( 091 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][92 ].nmchildren = { true, 222, 223                       } -- ( 092 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][93 ].nmchildren = { true, 224,                           } -- ( 093 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][94 ].nmchildren = { true, 225,                           } -- ( 094 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][95 ].nmchildren = { true, 226,                           } -- ( 095 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][96 ].nmchildren = { true, 227,                           } -- ( 096 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][97 ].nmchildren = { true, 228,                           } -- ( 097 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][98 ].nmchildren = { true, 229,                           } -- ( 098 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][99 ].nmchildren = { true, 230,                           } -- ( 099 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][100].nmchildren = { true, 231,                           } -- ( 100 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][101].nmchildren = { true, 232,                           } -- ( 101 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][102].nmchildren = { true, 233,                           } -- ( 102 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][103].nmchildren = { true, 234,                           } -- ( 103 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][104].nmchildren = { true, 235,                           } -- ( 104 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][105].nmchildren = { true, 236,                           } -- ( 105 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][106].nmchildren = { true, 237,                           } -- ( 106 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][107].nmchildren = { true, 238, 239                       } -- ( 107 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][108].nmchildren = { true, 240, 241                       } -- ( 108 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][109].nmchildren = { true, 242, 243                       } -- ( 109 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][110].nmchildren = { true, 244, 245                       } -- ( 110 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][111].nmchildren = { true, 246, 247                       } -- ( 111 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][112].nmchildren = { true, 248, 249                       } -- ( 112 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][113].nmchildren = { true, 250, 251                       } -- ( 113 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][114].nmchildren = { true, 252, 253                       } -- ( 114 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][115].nmchildren = { true, 254, 255                       } -- ( 115 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][116].nmchildren = { true, 256, 257                       } -- ( 116 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][117].nmchildren = { true, 258, 259                       } -- ( 117 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][118].nmchildren = { true, 260, 261                       } -- ( 118 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][119].nmchildren = { true, 262, 263, 264                  } -- ( 119 ) Nightmare Manticore (×4)
xi.dynamis.mobList[zoneID][120].nmchildren = { true, 265, 266                       } -- ( 120 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][121].nmchildren = { true, 267, 268                       } -- ( 121 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][122].nmchildren = { true, 269, 270                       } -- ( 122 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][123].nmchildren = { true, 271, 272, 273                  } -- ( 123 ) Nightmare Manticore (×4)
xi.dynamis.mobList[zoneID][124].nmchildren = { true, 274, 275, 276                  } -- ( 124 ) Nightmare Manticore (×4)
xi.dynamis.mobList[zoneID][125].nmchildren = { true, 277, 278                       } -- ( 125 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][126].nmchildren = { true, 279, 280                       } -- ( 126 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][127].nmchildren = { true, 281, 282                       } -- ( 127 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][128].nmchildren = { true, 283, 284                       } -- ( 128 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][129].nmchildren = { true, 285, 286                       } -- ( 129 ) Nightmare Sabotender (×3)
-- NMs
xi.dynamis.mobList[zoneID][10 ].nmchildren = { true, 287, 288                       } -- ( 010 ) Dragontrap (×3)

------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].pos = {xpos, ypos, zpos, rot}

-- Wave 1
-- Boss Area
xi.dynamis.mobList[zoneID][24 ].pos = { 63.648, 1.031, -76.541, 180     } -- ( 024 ) Cirrate Christelle - Spawns 025-052
xi.dynamis.mobList[zoneID][25 ].pos = { 29.358, 0.045, -24.815, 45      } -- (025-G) Goblin Replica
xi.dynamis.mobList[zoneID][26 ].pos = { 41.943, 0.814, -23.702, 67      } -- (026-Y) Manifest Icon
xi.dynamis.mobList[zoneID][27 ].pos = { 56.671, 0.562, -25.307, 67      } -- (027-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][28 ].pos = { 84.413, 0.024, -29.546, 59      } -- (028-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][29 ].pos = { 37.877, 0.000, -38.515, 60      } -- ( 029 ) 029-Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][30 ].pos = { 85.392, 0.709, -56.579, 78      } -- ( 030 ) 030-Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][31 ].pos = { 111.675, 0.053, -46.130, 110    } -- ( 031 ) 031-Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][32 ].pos = { 106.273, 0.463, -35.941, 100    } -- ( 032 ) 032-Nightmare Sheep (×3)
-- NMs
xi.dynamis.mobList[zoneID][5  ].pos = { -308.519, 0.095, -148.257, 29   } -- ( 005 ) Fairy Ring
xi.dynamis.mobList[zoneID][10 ].pos = { -679.979, -8.000, 158.754, 139  } -- ( 010 ) Flytrap NMs (Dragontrap ×3)
xi.dynamis.mobList[zoneID][15 ].pos = { 769.009, -7.530, 379.675, 54    } -- ( 015 ) Stcemqestcint - Inhibits Cirrate Christelle's 'Vampiric Lash' effect
xi.dynamis.mobList[zoneID][20 ].pos = { 956.335, 0.475, -332.799, 190   } -- ( 020 ) Nant'ina
-- Initial Statues
xi.dynamis.mobList[zoneID][1  ].pos = { -227.075, 4.043, -136.874, 198  } -- (001-Y) Manifest Icon
xi.dynamis.mobList[zoneID][2  ].pos = { -231.037, 4.300, -156.459, 181  } -- (002-Y) Manifest Icon
xi.dynamis.mobList[zoneID][3  ].pos = { -248.461, 4.300, -155.360, 241  } -- (003-Y) Manifest Icon
xi.dynamis.mobList[zoneID][4  ].pos = { -238.301, 3.994, -135.911, 188  } -- (004-Y) Manifest Icon
xi.dynamis.mobList[zoneID][6  ].pos = { -541.404, -15.080, 355.848, 249 } -- (006-G) Goblin Replica
xi.dynamis.mobList[zoneID][7  ].pos = { -565.817, -16.120, 354.162, 255 } -- (007-G) Goblin Replica
xi.dynamis.mobList[zoneID][8  ].pos = { -550.128, -16.683, 323.770, 130 } -- (008-G) Goblin Replica
xi.dynamis.mobList[zoneID][9  ].pos = { -568.867, -16.445, 325.818, 8   } -- (009-G) Goblin Replica
xi.dynamis.mobList[zoneID][11 ].pos = { 800.240, -7.456, 254.332, 105   } -- (011-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][12 ].pos = { 796.763, -7.631, 268.595, 64    } -- (012-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][13 ].pos = { 792.154, -8.291, 321.301, 52    } -- (013-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][14 ].pos = { 805.659, -7.797, 340.507, 80    } -- (014-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][16 ].pos = { 648.224, -0.554, -166.534, 176  } -- (016-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][17 ].pos = { 627.996, -1.738, -163.301, 225  } -- (017-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][18 ].pos = { 702.606, -5.689, -180.082, 98   } -- (018-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][19 ].pos = { 718.906, -8.000, -178.972, 123  } -- (019-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][33 ].pos = { 15.751, -7.298, 79.127, 65      } -- (033-Y) Manifest Icon
xi.dynamis.mobList[zoneID][34 ].pos = { 2.127, -7.719, 70.444, 65       } -- (034-Y) Manifest Icon
xi.dynamis.mobList[zoneID][35 ].pos = { 15.570, -7.075, 68.542, 64      } -- (035-Y) Manifest Icon
xi.dynamis.mobList[zoneID][36 ].pos = { 29.655, -8.313, 67.841, 61      } -- (036-Y) Manifest Icon
xi.dynamis.mobList[zoneID][37 ].pos = { 16.975, -6.399, 53.539, 60      } -- (037-Y) Manifest Icon
xi.dynamis.mobList[zoneID][38 ].pos = { -6.098, -7.882, 76.867, 120     } -- (038-G) Goblin Replica
xi.dynamis.mobList[zoneID][39 ].pos = { -18.538, -7.656, 87.493, 126    } -- (039-G) Goblin Replica
xi.dynamis.mobList[zoneID][40 ].pos = { -4.878, -7.742, 87.812, 127     } -- (040-G) Goblin Replica
xi.dynamis.mobList[zoneID][41 ].pos = { 6.479, -7.928, 87.953, 130      } -- (041-G) Goblin Replica
xi.dynamis.mobList[zoneID][42 ].pos = { -4.693, -7.204, 102.477, 124    } -- (042-G) Goblin Replica
xi.dynamis.mobList[zoneID][43 ].pos = { 20.768, -7.224, 125.433, 199    } -- (043-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][44 ].pos = { 3.822, -7.841, 112.598, 204     } -- (044-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][45 ].pos = { 17.844, -8.016, 108.887, 198    } -- (045-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][46 ].pos = { 31.170, -7.792, 106.365, 195    } -- (046-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][47 ].pos = { 15.876, -7.875, 96.537, 191     } -- (047-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][48 ].pos = { 42.235, -7.096, 101.898, 2      } -- (048-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][49 ].pos = { 28.787, -7.788, 86.305, 2       } -- (049-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][50 ].pos = { 40.759, -7.855, 86.931, 253     } -- (050-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][51 ].pos = { 54.684, -7.896, 87.993, 252     } -- (051-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][52 ].pos = { 41.105, -7.913, 74.242, 255     } -- (052-Q) Adamantking Effigy
-- Nightmare Mobs
xi.dynamis.mobList[zoneID][21 ].pos = { -199.637, 0.752, 15.476, 243    } -- ( 021 ) Recover subjobs
xi.dynamis.mobList[zoneID][22 ].pos = { 497.477, -15.127, 237.200, 77   } -- ( 022 ) Recover subjobs
xi.dynamis.mobList[zoneID][23 ].pos = { 351.001, -2.324, -21.541, 159   } -- ( 023 ) Recover subjobs
xi.dynamis.mobList[zoneID][53 ].pos = { 270.350, -7.845, 88.144, 11     } -- ( 053 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][54 ].pos = { 269.572, -7.850, 110.006, 212   } -- ( 054 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][55 ].pos = { 232.008, -8.007, 114.407, 116   } -- ( 055 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][56 ].pos = { 227.459, -7.580, 81.794, 109    } -- ( 056 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][57 ].pos = { 203.136, -7.688, 103.600, 130   } -- ( 057 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][58 ].pos = { 204.115, -7.446, 133.583, 112   } -- ( 058 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][59 ].pos = { -201.351, -0.157, -72.847, 191  } -- ( 059 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][60 ].pos = { -182.171, -2.491, -41.078, 211  } -- ( 060 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][61 ].pos = { -207.936, -3.404, -18.120, 169  } -- ( 061 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][62 ].pos = { -211.957, -0.079, -48.985, 246  } -- ( 062 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][63 ].pos = { -242.782, -0.176, -39.340, 131  } -- ( 063 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][64 ].pos = { -337.618, -7.120, 116.906, 27   } -- ( 064 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][65 ].pos = { -368.481, -7.446, 104.491, 3    } -- ( 065 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][66 ].pos = { -431.067, -7.755, 83.780, 17    } -- ( 066 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][67 ].pos = { -439.514, -7.563, 147.256, 66   } -- ( 067 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][68 ].pos = { -411.644, -7.61, 200.437, 235   } -- ( 068 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][69 ].pos = { -363.394, -8.000, 199.008, 245  } -- ( 069 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][70 ].pos = { -337.741, -9.782, 180.387, 21   } -- ( 070 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][71 ].pos = { -323.574, -7.976, 155.486, 27   } -- ( 071 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][72 ].pos = { -321.165, -7.748, 129.066, 16   } -- ( 072 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][73 ].pos = { -307.629, -7.568, 161.307, 21   } -- ( 073 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][74 ].pos = { -528.345, -9.070, 112.368, 235  } -- ( 074 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][75 ].pos = { -525.822, -7.596, 134.059, 26   } -- ( 075 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][76 ].pos = { -525.602, -8.154, 161.502, 57   } -- ( 076 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][77 ].pos = { -504.772, -8.829, 166.651, 10   } -- ( 077 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][78 ].pos = { -506.119, -7.978, 141.795, 55   } -- ( 078 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][79 ].pos = { -495.775, -7.227, 116.713, 12   } -- ( 079 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][80 ].pos = { -477.706, -7.630, 131.416, 248  } -- ( 080 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][81 ].pos = { -476.029, -8.003, 161.425, 237  } -- ( 081 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][82 ].pos = { -496.854, -7.158, 123.142, 221  } -- ( 082 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][83 ].pos = { -675.863, -8.309, 206.097, 69   } -- ( 083 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][84 ].pos = { -704.722, -7.277, 203.703, 3    } -- ( 084 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][85 ].pos = { -722.532, -8.000, 238.819, 49   } -- ( 085 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][86 ].pos = { -747.801, -4.455, 196.307, 11   } -- ( 086 ) Nightmare Hippogryph (×3)
xi.dynamis.mobList[zoneID][87 ].pos = { 448.005, -15.775, 233.921, 42   } -- ( 087 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][88 ].pos = { 449.724, -16.110, 209.823, 94   } -- ( 088 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][89 ].pos = { 471.173, -16.142, 218.323, 235  } -- ( 089 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][90 ].pos = { 463.897, -15.196, 239.508, 50   } -- ( 090 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][91 ].pos = { 486.988, -15.702, 251.184, 49   } -- ( 091 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][92 ].pos = { 500.990, -16.375, 219.804, 148  } -- ( 092 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][93 ].pos = { 440.603, -8.000, 80.841, 179    } -- ( 093 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][94 ].pos = { 453.174, -7.956, 99.440, 198    } -- ( 094 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][95 ].pos = { 430.282, -8.061, 106.429, 154   } -- ( 095 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][96 ].pos = { 414.866, -7.318, 80.183, 110    } -- ( 096 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][97 ].pos = { 407.319, -7.451, 58.923, 138    } -- ( 097 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][98 ].pos = { 428.845, -2.609, 48.355, 15     } -- ( 098 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][99 ].pos = { 419.554, -3.957, 32.476, 89     } -- ( 099 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][100].pos = { 398.680, -7.547, 32.037, 121    } -- ( 100 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][101].pos = { 398.680, -7.547, 32.037, 121    } -- ( 101 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][102].pos = { 374.559, -7.349, 77.603, 144    } -- ( 102 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][103].pos = { 354.904, -7.569, 69.202, 122    } -- ( 103 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][104].pos = { 350.501, -7.809, 48.913, 84     } -- ( 104 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][105].pos = { 350.501, -7.809, 48.913, 84     } -- ( 105 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][106].pos = { 390.835, -1.071, 11.709, 1      } -- ( 106 ) Nightmare Sheep (×2)
xi.dynamis.mobList[zoneID][107].pos = { 713.279, -7.865, 198.806, 145   } -- ( 107 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][108].pos = { 716.741, -6.853, 221.077, 139   } -- ( 108 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][109].pos = { 693.905, -14.598, 247.086, 69   } -- ( 109 ) Nightmare Sheep (×3)
xi.dynamis.mobList[zoneID][110].pos = { 313.455, -0.126, 4.949, 49      } -- ( 110 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][111].pos = { 281.517, 0.000, 3.977, 135      } -- ( 111 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][112].pos = { 257.308, -1.385, -25.174, 98    } -- ( 112 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][113].pos = { 266.672, -2.356, -59.410, 147   } -- ( 113 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][114].pos = { 301.975, -0.297, -50.620, 237   } -- ( 114 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][115].pos = { 335.514, -0.512, -34.323, 247   } -- ( 115 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][116].pos = { 248.361, 4.000, -157.225, 217   } -- ( 116 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][117].pos = { 277.378, 3.340, -147.096, 245   } -- ( 117 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][118].pos = { 306.276, 4.000, -164.827, 192   } -- ( 118 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][119].pos = { 331.719, 0.533, -125.410, 202   } -- ( 119 ) Nightmare Manticore (×4)
xi.dynamis.mobList[zoneID][120].pos = { 627.957, -0.003, -29.334, 81    } -- ( 120 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][121].pos = { 650.911, -0.059, -31.493, 84    } -- ( 121 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][122].pos = { 657.631, 0.766, -4.862, 56      } -- ( 122 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][123].pos = { 632.846, -0.239, 3.933, 41      } -- ( 123 ) Nightmare Manticore (×4)
xi.dynamis.mobList[zoneID][124].pos = { 679.221, 0.227, -8.568, 107     } -- ( 124 ) Nightmare Manticore (×4)
xi.dynamis.mobList[zoneID][125].pos = { 921.803, 0.809, -223.797, 141   } -- ( 125 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][126].pos = { 896.764, 0.749, -205.139, 139   } -- ( 126 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][127].pos = { 892.210, 0.249, -244.012, 91    } -- ( 127 ) Nightmare Manticore (×3)
xi.dynamis.mobList[zoneID][128].pos = { 911.322, -0.561, -323.268, 237  } -- ( 128 ) Nightmare Sabotender (×3)
xi.dynamis.mobList[zoneID][129].pos = { 968.520, -0.415, -278.791, 99   } -- ( 129 ) Nightmare Sabotender (×3)

----------------------------------------------------------------------------------------------------
--                                    Setup of Mob Functions                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--             Patrol Paths             --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].patrolPath = {xpos1,ypos1,zpos1, xpos2,ypos2,zpos2,  xpos3,ypos3,zpos3}
xi.dynamis.mobList[zoneID].patrolPaths = { }

------------------------------------------
--          Statue Eye Colors           --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eyes.BLUE -- Flags for blue eyes. (HP)
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eyes.GREEN -- Flags for green eyes. (MP)

xi.dynamis.mobList[zoneID][6  ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][7  ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][16 ].eyes = xi.dynamis.eye.BLUE

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].timeExtension = 15

xi.dynamis.mobList[zoneID].timeExtensionList = {24}
xi.dynamis.mobList[zoneID][24].timeExtension = 60
