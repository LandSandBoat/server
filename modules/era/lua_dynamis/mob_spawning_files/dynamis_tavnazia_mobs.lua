----------------------------------------------------------------------------------------------------
--                                      Dynamis-Tavnazia                                          --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/tav.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/tav.html        --
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
--    xi.dynamis.eye.RED, xi.dynamis.eye.BLUE, xi.dynamis.eye.GREEN
--    Ex. xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eye.BLUE -- Flags for blue eyes. (HP)
--    Ex. xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eye.GREEN -- Flags for green eyes. (MP)
--    Ex. xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eye.RED -- Flags for red eyes. (TE)
--
-- 10. xi.dynamis.mobList[zoneID][MobIndex].timeExtension dictates the amount of time given for the TE.
--    Ex. xi.dynamis.mobList[zoneID][MobIndex].timeExtension = 15
--
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
--                               Dependency Setup Section (IGNORE)                                --
----------------------------------------------------------------------------------------------------
local zoneID = xi.zone.DYNAMIS_TAVNAZIA
local i = 1
xi = xi or {} -- Ignore me I just set the global.
xi.dynamis = xi.dynamis or {} -- Ignore me I just set the global.
xi.dynamis.mobList = xi.dynamis.mobList or { } -- Ignore me I just set the global.
xi.dynamis.mobList[zoneID] = { } -- Ignore me, I just start the table.
xi.dynamis.mobList[zoneID].nmchildren = { }
xi.dynamis.mobList[zoneID].mobchildren = { }
xi.dynamis.mobList[zoneID].maxWaves = 3 -- Put in number of max waves

while i <= 252 do -- This needs to be the max numer of mobs in the zone
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

-- Nightmare
xi.dynamis.mobList[zoneID][1  ].info = {"Nightmare", "Nightmare Bugard", nil, nil, nil} -- ( 001 ) Nightmare Bugard (15)
xi.dynamis.mobList[zoneID][2  ].info = {"NM", "Nightmare Worm", nil, nil, nil}          -- ( 002 ) Nightmare Worm
xi.dynamis.mobList[zoneID][3  ].info = {"NM", "Nightmare Antlion", nil, nil, nil}       -- ( 003 ) Nightmare Antlion (30)
xi.dynamis.mobList[zoneID][4  ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 004 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][114].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 004 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][115].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 004 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][5  ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 005 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][116].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 005 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][117].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 005 ) Nightmare Hornet

-- Vanguard Eyes
xi.dynamis.mobList[zoneID][6  ].info = {"Statue", "Vanguard Eye", "Hydra", nil, nil, 2}            -- (006-H)
xi.dynamis.mobList[zoneID][7  ].info = {"Statue", "Vanguard Eye", "Hydra", nil, nil, 2}            -- (007-H)
xi.dynamis.mobList[zoneID][8  ].info = {"Statue", "Vanguard Eye", "Hydra", nil, nil, 2}            -- (008-H)
xi.dynamis.mobList[zoneID][9  ].info = {"Statue", "Vanguard Eye", "Hydra", nil, "eyeOneKilled", 2} -- (009-H)

-- Nightmare
xi.dynamis.mobList[zoneID][10 ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 010 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][118].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 010 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][119].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 010 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][11 ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 011 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][120].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 011 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][121].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 011 ) Nightmare Hornet

-- Vanguard Eyes
xi.dynamis.mobList[zoneID][12 ].info = {"Statue", "Vanguard Eye", "Hydra", nil, nil, 2} -- (012-H)
xi.dynamis.mobList[zoneID][13 ].info = {"Statue", "Vanguard Eye", "Hydra", nil, nil, 2} -- (013-H)
xi.dynamis.mobList[zoneID][14 ].info = {"Statue", "Vanguard Eye", "Hydra", nil, nil, 2} -- (014-H)
xi.dynamis.mobList[zoneID][15 ].info = {"Statue", "Vanguard Eye", "Hydra", nil, "eyeTwoKilled", 2} -- (015-H)

-- Nightmare
xi.dynamis.mobList[zoneID][16 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 016 ) Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][122].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 016 ) Nightmare Leech

xi.dynamis.mobList[zoneID][17 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 017 ) Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][123].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 017 ) Nightmare Leech

xi.dynamis.mobList[zoneID][18 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 018 ) Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][124].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 018 ) Nightmare Leech
xi.dynamis.mobList[zoneID][125].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 018 ) Nightmare Leech

xi.dynamis.mobList[zoneID][19 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 019 ) Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][126].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 019 ) Nightmare Leech
xi.dynamis.mobList[zoneID][127].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 019 ) Nightmare Leech

xi.dynamis.mobList[zoneID][20 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 020 ) Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][128].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 020 ) Nightmare Leech

xi.dynamis.mobList[zoneID][21 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 021 ) Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][129].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 021 ) Nightmare Leech

xi.dynamis.mobList[zoneID][22 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 022 ) Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][130].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 022 ) Nightmare Leech
xi.dynamis.mobList[zoneID][131].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 022 ) Nightmare Leech

xi.dynamis.mobList[zoneID][23 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 023 ) Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][132].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 023 ) Nightmare Leech
xi.dynamis.mobList[zoneID][133].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 023 ) Nightmare Leech

xi.dynamis.mobList[zoneID][24 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 024 ) Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][134].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 024 ) Nightmare Makara

xi.dynamis.mobList[zoneID][25 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 025 ) Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][135].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 025 ) Nightmare Makara

xi.dynamis.mobList[zoneID][26 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 026 ) Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][136].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 026 ) Nightmare Makara
xi.dynamis.mobList[zoneID][137].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 026 ) Nightmare Makara

xi.dynamis.mobList[zoneID][27 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 027 ) Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][138].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 027 ) Nightmare Makara
xi.dynamis.mobList[zoneID][139].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 027 ) Nightmare Makara

xi.dynamis.mobList[zoneID][28 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 028 ) Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][140].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 028 ) Nightmare Makara

xi.dynamis.mobList[zoneID][29 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 029 ) Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][141].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 029 ) Nightmare Makara

xi.dynamis.mobList[zoneID][30 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 030 ) Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][142].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 030 ) Nightmare Makara
xi.dynamis.mobList[zoneID][143].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 030 ) Nightmare Makara

xi.dynamis.mobList[zoneID][31 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 031 ) Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][144].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 031 ) Nightmare Makara
xi.dynamis.mobList[zoneID][145].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 031 ) Nightmare Makara

xi.dynamis.mobList[zoneID][32 ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 032 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][146].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 032 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][147].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 032 ) Nightmare Hornet

xi.dynamis.mobList[zoneID][33 ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 033 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][148].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 033 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][149].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 033 ) Nightmare Hornet

-- Vanguard Eyes
xi.dynamis.mobList[zoneID][34 ].info = {"Statue", "Vanguard Eye", "Hydra", nil, nil, 2} -- (034-H)
xi.dynamis.mobList[zoneID][35 ].info = {"Statue", "Vanguard Eye", "Hydra", nil, nil, 2} -- (035-H)
xi.dynamis.mobList[zoneID][36 ].info = {"Statue", "Vanguard Eye", "Hydra", nil, nil, 2} -- (036-H)
xi.dynamis.mobList[zoneID][37 ].info = {"Statue", "Vanguard Eye", "Hydra", nil, nil, 2} -- (037-H)

-- Nightmare
xi.dynamis.mobList[zoneID][38 ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 038 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][150].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 038 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][151].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 038 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][39 ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 039 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][152].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 039 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][153].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 039 ) Nightmare Hornet

-- Vanguard Eyes
xi.dynamis.mobList[zoneID][40 ].info = {"Statue", "Vanguard Eye", "Hydra", nil, nil, 2} -- (040-H)
xi.dynamis.mobList[zoneID][41 ].info = {"Statue", "Vanguard Eye", "Hydra", nil, nil, 2} -- (041-H)
xi.dynamis.mobList[zoneID][42 ].info = {"Statue", "Vanguard Eye", "Hydra", nil, nil, 2} -- (042-H)
xi.dynamis.mobList[zoneID][43 ].info = {"Statue", "Vanguard Eye", "Hydra", nil, nil, 2} -- (043-H)

-- Nightmare
xi.dynamis.mobList[zoneID][44 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 044 ) Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][154].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 044 ) Nightmare Leech
xi.dynamis.mobList[zoneID][45 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 045 ) Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][155].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 045 ) Nightmare Leech
xi.dynamis.mobList[zoneID][46 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 046 ) Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][156].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 046 ) Nightmare Leech
xi.dynamis.mobList[zoneID][157].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 046 ) Nightmare Leech
xi.dynamis.mobList[zoneID][47 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 047 ) Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][158].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 047 ) Nightmare Leech
xi.dynamis.mobList[zoneID][159].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 047 ) Nightmare Leech
xi.dynamis.mobList[zoneID][48 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 048 ) Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][160].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 048 ) Nightmare Leech
xi.dynamis.mobList[zoneID][49 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 049 ) Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][161].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 049 ) Nightmare Leech
xi.dynamis.mobList[zoneID][50 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 050 ) Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][162].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 050 ) Nightmare Leech
xi.dynamis.mobList[zoneID][163].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 050 ) Nightmare Leech
xi.dynamis.mobList[zoneID][51 ].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 051 ) Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][164].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 051 ) Nightmare Leech
xi.dynamis.mobList[zoneID][165].info = {"Nightmare", "Nightmare Leech", nil, nil, nil}  -- ( 051 ) Nightmare Leech
xi.dynamis.mobList[zoneID][52 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 052 ) Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][166].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 052 ) Nightmare Makara
xi.dynamis.mobList[zoneID][53 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 053 ) Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][167].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 053 ) Nightmare Makara

xi.dynamis.mobList[zoneID][54 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 054 ) Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][168].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 054 ) Nightmare Makara
xi.dynamis.mobList[zoneID][169].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 054 ) Nightmare Makara

xi.dynamis.mobList[zoneID][55 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 055 ) Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][170].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 055 ) Nightmare Makara
xi.dynamis.mobList[zoneID][171].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 055 ) Nightmare Makara

xi.dynamis.mobList[zoneID][56 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 056 ) Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][172].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 056 ) Nightmare Makara

xi.dynamis.mobList[zoneID][57 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 057 ) Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][173].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 057 ) Nightmare Makara

xi.dynamis.mobList[zoneID][58 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 058 ) Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][174].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 058 ) Nightmare Makara
xi.dynamis.mobList[zoneID][175].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 058 ) Nightmare Makara

xi.dynamis.mobList[zoneID][59 ].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 059 ) Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][176].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 059 ) Nightmare Makara
xi.dynamis.mobList[zoneID][177].info = {"Nightmare", "Nightmare Makara", nil, nil, nil} -- ( 059 ) Nightmare Makara

xi.dynamis.mobList[zoneID][60 ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 060 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][178].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 060 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][179].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 060 ) Nightmare Hornet

xi.dynamis.mobList[zoneID][61 ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 061 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][180].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 061 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][181].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 061 ) Nightmare Hornet

-- Vanguard Eyes
xi.dynamis.mobList[zoneID][62 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (062-D)
xi.dynamis.mobList[zoneID][63 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (063-D)
xi.dynamis.mobList[zoneID][64 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (064-D)
xi.dynamis.mobList[zoneID][65 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (065-D)
xi.dynamis.mobList[zoneID][66 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (066-D)
xi.dynamis.mobList[zoneID][67 ].info = {"Statue", "Vanguard Eye", nil, nil, "eyeThreeKilled", 3} -- (067-D)

-- Nightmare
xi.dynamis.mobList[zoneID][68 ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 068 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][182].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 068 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][183].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 068 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][69 ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 069 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][184].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 069 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][185].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 069 ) Nightmare Hornet

xi.dynamis.mobList[zoneID][70 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3}     -- (070-D)
xi.dynamis.mobList[zoneID][71 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3}     -- (071-D)
xi.dynamis.mobList[zoneID][72 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3}     -- (072-D)
xi.dynamis.mobList[zoneID][73 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3}     -- (073-D)
xi.dynamis.mobList[zoneID][74 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3}     -- (074-D)
xi.dynamis.mobList[zoneID][75 ].info = {"Statue", "Vanguard Eye", nil, nil, "eyeFourKilled", 3}     -- (075-D)

-- Nightmare
xi.dynamis.mobList[zoneID][76 ].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 076 ) Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][186].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 076 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][187].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 076 ) Nightmare Cluster

xi.dynamis.mobList[zoneID][77 ].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 077 ) Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][188].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 077 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][189].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 077 ) Nightmare Cluster

xi.dynamis.mobList[zoneID][78 ].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 078 ) Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][190].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 078 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][191].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 078 ) Nightmare Cluster

xi.dynamis.mobList[zoneID][79 ].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 079 ) Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][192].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 079 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][193].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 079 ) Nightmare Cluster

xi.dynamis.mobList[zoneID][80 ].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 080 ) Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][194].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 080 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][195].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 080 ) Nightmare Cluster

xi.dynamis.mobList[zoneID][81 ].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 081 ) Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][196].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 081 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][197].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 081 ) Nightmare Cluster

xi.dynamis.mobList[zoneID][82 ].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 082 ) Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][198].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 082 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][199].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 082 ) Nightmare Cluster

xi.dynamis.mobList[zoneID][83 ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil}  -- ( 083 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][200].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil}  -- ( 083 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][201].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil}  -- ( 083 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][84 ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil}  -- ( 084 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][202].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil}  -- ( 084 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][203].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil}  -- ( 084 ) Nightmare Hornet

xi.dynamis.mobList[zoneID][85 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (085-D)
xi.dynamis.mobList[zoneID][86 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (086-D)
xi.dynamis.mobList[zoneID][87 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (087-D)
xi.dynamis.mobList[zoneID][88 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (088-D)
xi.dynamis.mobList[zoneID][89 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (089-D)
xi.dynamis.mobList[zoneID][90 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (090-D)

-- Nightmare
xi.dynamis.mobList[zoneID][91 ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 091 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][204].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 091 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][205].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 091 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][92 ].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 092 ) Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][206].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 092 ) Nightmare Hornet
xi.dynamis.mobList[zoneID][207].info = {"Nightmare", "Nightmare Hornet", nil, nil, nil} -- ( 092 ) Nightmare Hornet

xi.dynamis.mobList[zoneID][93 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (093-D)
xi.dynamis.mobList[zoneID][94 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (094-D)
xi.dynamis.mobList[zoneID][95 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (095-D)
xi.dynamis.mobList[zoneID][96 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (096-D)
xi.dynamis.mobList[zoneID][97 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (097-D)
xi.dynamis.mobList[zoneID][98 ].info = {"Statue", "Vanguard Eye", nil, nil, nil, 3} -- (098-D)

-- Nightmare
xi.dynamis.mobList[zoneID][99 ].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 099 ) Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][208].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 099 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][209].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 099 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][100].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 100 ) Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][210].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 100 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][211].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 100 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][101].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 101 ) Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][212].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 101 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][213].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 101 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][102].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 102 ) Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][214].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 102 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][215].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 102 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][103].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 103 ) Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][216].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 103 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][217].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 103 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][104].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 104 ) Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][218].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 104 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][219].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 104 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][105].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 105 ) Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][220].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 105 ) Nightmare Cluster
xi.dynamis.mobList[zoneID][221].info = {"Nightmare", "Nightmare Cluster", nil, nil, nil} -- ( 105 ) Nightmare Cluster

-- NMs
xi.dynamis.mobList[zoneID][106].info = {"NM", "Umbral Diabolos", nil, nil, nil} -- ( 106 ) Umbral Diabolos
xi.dynamis.mobList[zoneID][107].info = {"NM", "Umbral Diabolos", nil, nil, nil} -- ( 107 ) Umbral Diabolos
xi.dynamis.mobList[zoneID][108].info = {"NM", "Umbral Diabolos", nil, nil, nil} -- ( 108 ) Umbral Diabolos
xi.dynamis.mobList[zoneID][109].info = {"NM", "Umbral Diabolos", nil, nil, nil} -- ( 109 ) Umbral Diabolos
xi.dynamis.mobList[zoneID][110].info = {"NM", "Diabolos Club", nil, nil, nil} -- ( 110 ) Diabolos Club
xi.dynamis.mobList[zoneID][111].info = {"NM", "Diabolos Heart", nil, nil, nil} -- ( 111 ) Diabolos Heart
xi.dynamis.mobList[zoneID][112].info = {"NM", "Diabolos Spade", nil, nil, nil} -- ( 112 ) Diabolos Spade
xi.dynamis.mobList[zoneID][113].info = {"NM", "Diabolos Diamond", nil, nil, nil} -- ( 113 ) Diabolos Diamond
xi.dynamis.mobList[zoneID][252].info = {"NM", "Diabolos Shard", nil, nil, nil} -- ( 110 ) Diabolos Club

-- Nightmare Taurus
xi.dynamis.mobList[zoneID][222].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (062-D)
xi.dynamis.mobList[zoneID][223].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (063-D)
xi.dynamis.mobList[zoneID][224].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (064-D)
xi.dynamis.mobList[zoneID][225].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (065-D)
xi.dynamis.mobList[zoneID][226].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (066-D)
xi.dynamis.mobList[zoneID][227].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (067-D)
xi.dynamis.mobList[zoneID][228].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (072-D)
xi.dynamis.mobList[zoneID][229].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (072-D)
xi.dynamis.mobList[zoneID][230].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (072-D)
xi.dynamis.mobList[zoneID][231].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (074-D)
xi.dynamis.mobList[zoneID][232].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (074-D)
xi.dynamis.mobList[zoneID][233].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (074-D)
xi.dynamis.mobList[zoneID][234].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (085-D)
xi.dynamis.mobList[zoneID][235].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (085-D)
xi.dynamis.mobList[zoneID][236].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (086-D)
xi.dynamis.mobList[zoneID][237].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (086-D)
xi.dynamis.mobList[zoneID][238].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (087-D)
xi.dynamis.mobList[zoneID][239].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (087-D)
xi.dynamis.mobList[zoneID][240].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (088-D)
xi.dynamis.mobList[zoneID][241].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (088-D)
xi.dynamis.mobList[zoneID][242].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (089-D)
xi.dynamis.mobList[zoneID][243].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (089-D)
xi.dynamis.mobList[zoneID][244].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (090-D)
xi.dynamis.mobList[zoneID][245].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (090-D)
xi.dynamis.mobList[zoneID][246].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (093-D)
xi.dynamis.mobList[zoneID][247].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (093-D)
xi.dynamis.mobList[zoneID][248].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (093-D)
xi.dynamis.mobList[zoneID][249].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (096-D)
xi.dynamis.mobList[zoneID][250].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (097-D)
xi.dynamis.mobList[zoneID][251].info = {"Nightmare", "Nightmare Taurus", nil, nil, nil} -- From Eye - (098-D)

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
    {"qmOne"}, -- Spawns First Floor Bees
    {"qmTwo"}, -- Spawns Second Floor Bees
}

------------------------------------------
--            Wave Spawning             --
-- Note: Wave 1 spawns at start.        --
------------------------------------------
--xi.dynamis.mobList[zoneID].wave# = { MobIndex#1, MobIndex#2, MobIndex#3 }

xi.dynamis.mobList[zoneID][1].wave =
{
    1,  -- ( 001 )-Nightmare Bugard(15)
    2,  -- ( 002 )-Nightmare Worm
    3,  -- ( 003 )-Nightmare Antlion(30)
    4,  -- ( 004 )-Nightmare Hornet (×3)
    5,  -- ( 005 )-Nightmare Hornet (×3)
    6,  -- (006-H) Vanguard Eye
    7,  -- (007-H) Vanguard Eye
    8,  -- (008-H) Vanguard Eye
    9,  -- (009-H) Vanguard Eye
    10, -- ( 010 )-Nightmare Hornet (×3)
    11, -- ( 011 )-Nightmare Hornet (×3)
    12, -- (012-H) Vanguard Eye
    13, -- (013-H) Vanguard Eye
    14, -- (014-H) Vanguard Eye
    15, -- (015-H) Vanguard Eye
    16, -- ( 016 )-Nightmare Leech (×2)
    17, -- ( 017 )-Nightmare Leech (×2)
    18, -- ( 018 )-Nightmare Leech (×3)
    19, -- ( 019 )-Nightmare Leech (×3)
    20, -- ( 020 )-Nightmare Leech (×2)
    21, -- ( 021 )-Nightmare Leech (×2)
    22, -- ( 022 )-Nightmare Leech (×3)
    23, -- ( 023 )-Nightmare Leech (×3)
    24, -- ( 024 )-Nightmare Makara (×2)
    25, -- ( 025 )-Nightmare Makara (×2)
    26, -- ( 026 )-Nightmare Makara (×3)
    27, -- ( 027 )-Nightmare Makara (×3)
    28, -- ( 028 )-Nightmare Makara (×2)
    29, -- ( 029 )-Nightmare Makara (×2)
    30, -- ( 030 )-Nightmare Makara (×3)
    31, -- ( 031 )-Nightmare Makara (×3)
    60, -- ( 060 )-Nightmare Hornet (×3)
    61, -- ( 061 )-Nightmare Hornet (×3)
    62, -- ( 062-D ) Vanguard Eye
    63, -- ( 063-D ) Vanguard Eye
    64, -- ( 064-D ) Vanguard Eye
    65, -- ( 065-D ) Vanguard Eye
    66, -- ( 066-D ) Vanguard Eye
    67, -- ( 067-D ) Vanguard Eye
    68, -- ( 068 )-Nightmare Hornet (×3)
    69, -- ( 069 )-Nightmare Hornet (×3)
    70, -- ( 070-D ) Vanguard Eye
    71, -- ( 071-D ) Vanguard Eye
    72, -- ( 072-D ) Vanguard Eye
    73, -- ( 073-D ) Vanguard Eye
    74, -- ( 074-D ) Vanguard Eye
    75, -- ( 075-D ) Vanguard Eye
    76, -- ( 076 )-Nightmare Cluster (×3)
    77, -- ( 077 )-Nightmare Cluster (×3)
    78, -- ( 078 )-Nightmare Cluster (×3)
    79, -- ( 079 )-Nightmare Cluster (×3)
    80, -- ( 080 )-Nightmare Cluster (×3)
    81, -- ( 081 )-Nightmare Cluster (×3)
    82, -- ( 082 )-Nightmare Cluster (×3)
    106, -- ( 106 )-Umbral Diabolos
    107, -- ( 107 )-Umbral Diabolos
    108, -- ( 108 )-Umbral Diabolos
    109, -- ( 109 )-Umbral Diabolos
}

xi.dynamis.mobList[zoneID][2].wave =
{
    32, -- ( 032 )-Nightmare Hornet (×3)
    33, -- ( 033 )-Nightmare Hornet (×3)
    34, -- ( 034-H )-Vanguard Eye
    35, -- ( 035-H )-Vanguard Eye
    36, -- ( 036-H )-Vanguard Eye
    37, -- ( 037-H )-Vanguard Eye
    38, -- ( 038 )-Nightmare Hornet (×3)
    39, -- ( 039 )-Nightmare Hornet (×3)
    40, -- ( 040-H )-Vanguard Eye
    41, -- ( 041-H )-Vanguard Eye
    42, -- ( 042-H )-Vanguard Eye
    43, -- ( 043-H )-Vanguard Eye
    44, -- ( 044 )-Nightmare Leech (×2)
    45, -- ( 045 )-Nightmare Leech (×2)
    46, -- ( 046 )-Nightmare Leech (×3)
    47, -- ( 047 )-Nightmare Leech (×3)
    48, -- ( 048 )-Nightmare Leech (×2)
    49, -- ( 049 )-Nightmare Leech (×2)
    50, -- ( 050 )-Nightmare Leech (×3)
    51, -- ( 051 )-Nightmare Leech (×3)
    52, -- ( 052 )-Nightmare Makara (×2)
    53, -- ( 053 )-Nightmare Makara (×2)
    54, -- ( 054 )-Nightmare Makara (×3)
    55, -- ( 055 )-Nightmare Makara (×3)
    56, -- ( 056 )-Nightmare Makara (×2)
    57, -- ( 057 )-Nightmare Makara (×2)
    58, -- ( 058 )-Nightmare Makara (×3)
    59, -- ( 059 )-Nightmare Makara (×3)
}

xi.dynamis.mobList[zoneID][3].wave =
{
    83,  -- ( 083 )-Nightmare Hornet (×3)
    84,  -- ( 084 )-Nightmare Hornet (×3)
    85,  -- ( 085-D ) Vanguard Eye
    86,  -- ( 086-D ) Vanguard Eye
    87,  -- ( 087-D ) Vanguard Eye
    88,  -- ( 088-D ) Vanguard Eye
    89,  -- ( 089-D ) Vanguard Eye
    90,  -- ( 090-D ) Vanguard Eye
    91,  -- ( 091 )-Nightmare Hornet (×3)
    92,  -- ( 092 )-Nightmare Hornet (×3)
    93,  -- ( 093-D ) Vanguard Eye
    94,  -- ( 094-D ) Vanguard Eye
    95,  -- ( 095-D ) Vanguard Eye
    96,  -- ( 096-D ) Vanguard Eye
    97,  -- ( 097-D ) Vanguard Eye
    98,  -- ( 098-D ) Vanguard Eye
    99,  -- ( 099 )-Nightmare Cluster (×3)
    100, -- ( 100 )-Nightmare Cluster (×3)
    101, -- ( 101 )-Nightmare Cluster (×3)
    102, -- ( 102 )-Nightmare Cluster (×3)
    103, -- ( 103 )-Nightmare Cluster (×3)
    104, -- ( 104 )-Nightmare Cluster (×3)
    105, -- ( 105 )-Nightmare Cluster (×3)
}

----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

xi.dynamis.mobList[zoneID][6  ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil } -- 1 WAR  1 RDM  1 RNG
xi.dynamis.mobList[zoneID][7  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil,   1 } -- 1 DRK  1 BST  1 SMN
xi.dynamis.mobList[zoneID][8  ].mobchildren = { nil, nil,   1,   1, nil,   1,   1, nil, nil, nil, nil, nil, nil,   1, nil } -- 1 WHM  1 BLM  1 THF  1 PLD  1 DRG
xi.dynamis.mobList[zoneID][9  ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1,   1, nil, nil } -- 1 MNK  1 BRD  1 SAM  1 NIN
xi.dynamis.mobList[zoneID][12 ].mobchildren = { nil, nil,   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil } -- 1 WHM  1 BLM  1 RDM
xi.dynamis.mobList[zoneID][13 ].mobchildren = {   1,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil } -- 1 WAR  1 MNK  1 THF  1 SAM
xi.dynamis.mobList[zoneID][14 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil,   1,   1, nil,   1, nil, nil } -- 1 PLD  1 DRK  1 BRD  1 RNG  1 NIN
xi.dynamis.mobList[zoneID][15 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1,   1 } -- 1 BST  1 DRG  1 SMN
xi.dynamis.mobList[zoneID][34 ].mobchildren = { nil,   1, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil,   1 } -- 1 MNK  1 PLD  1 RNG  1 SMN
xi.dynamis.mobList[zoneID][35 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil } -- 1 BLM  1 DRK  1 NIN
xi.dynamis.mobList[zoneID][36 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil,   1, nil,   1, nil } -- 1 BST  1 BRD  1 SAM  1 DRG
xi.dynamis.mobList[zoneID][37 ].mobchildren = {   1, nil,   1, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil } -- 1 WAR  1 WHM  1 RDM  1 THF
xi.dynamis.mobList[zoneID][40 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil } -- 1 MNK  1 WHM  1 BRD  1 NIN
xi.dynamis.mobList[zoneID][41 ].mobchildren = {   1, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil,   1, nil, nil, nil } -- 1 WAR  1 PLD  1 DRK  1 SAM
xi.dynamis.mobList[zoneID][42 ].mobchildren = { nil, nil, nil, nil,   1,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil } -- 1 RDM  1 THF  1 BST  1 DRG
xi.dynamis.mobList[zoneID][43 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1 } -- 1 BLM  1 RNG  1 SMN
xi.dynamis.mobList[zoneID][62 ].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil } -- 1 WAR  1 THF
xi.dynamis.mobList[zoneID][63 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil } -- 1 RNG  1 SAM
xi.dynamis.mobList[zoneID][64 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil } -- 1 BLM  1 BST  1 NIN
xi.dynamis.mobList[zoneID][65 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil,   1 } -- 1 PLD  1 DRK  1 SMN
xi.dynamis.mobList[zoneID][66 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil } -- 1 RDM  1 BRD  1 DRG
xi.dynamis.mobList[zoneID][67 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil } -- 1 MNK  1 WHM
xi.dynamis.mobList[zoneID][70 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1 } -- 1 BLM  1 PLD  1 BRD  1 SMN
xi.dynamis.mobList[zoneID][71 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil } -- 1 WAR  1 NIN  1 DRG
xi.dynamis.mobList[zoneID][73 ].mobchildren = { nil, nil,   1, nil, nil,   1, nil, nil,   1, nil, nil,   1, nil, nil, nil } -- 1 WHM  1 THF  1 BST  1 SAM
xi.dynamis.mobList[zoneID][74 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil } -- 1 MNK
xi.dynamis.mobList[zoneID][75 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil } -- 1 RDM  1 DRK  1 RNG
xi.dynamis.mobList[zoneID][85 ].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil } -- 1 WAR  1 THF
xi.dynamis.mobList[zoneID][86 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil } -- 1 RNG  1 SAM
xi.dynamis.mobList[zoneID][87 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil } -- 1 BLM  1 BST  1 NIN
xi.dynamis.mobList[zoneID][88 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil,   1 } -- 1 PLD  1 DRK  1 SMN
xi.dynamis.mobList[zoneID][89 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil } -- 1 RDM  1 BRD  1 DRG
xi.dynamis.mobList[zoneID][90 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil } -- 1 MNK  1 WHM
xi.dynamis.mobList[zoneID][94 ].mobchildren = {   1, nil,   1, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil } -- 1 WAR  1 WHM  1 BRD  1 RNG
xi.dynamis.mobList[zoneID][95 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1,   1 } -- 1 BST  1 DRG  1 SMN
xi.dynamis.mobList[zoneID][96 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil } -- 1 THF  1 SAM
xi.dynamis.mobList[zoneID][97 ].mobchildren = { nil,   1, nil, nil,   1, nil,   1,   1, nil, nil, nil, nil,   1, nil, nil } -- 1 MNK  1 RDM  1 PLD  1 DRK  1 NIN
xi.dynamis.mobList[zoneID][98 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil } -- 1 BLM

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].nmchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

xi.dynamis.mobList[zoneID][4  ].nmchildren = { true,  114, 115 }
xi.dynamis.mobList[zoneID][5  ].nmchildren = { true,  116, 117 }
xi.dynamis.mobList[zoneID][10 ].nmchildren = { true,  118, 119 }
xi.dynamis.mobList[zoneID][11 ].nmchildren = { true,  120, 121 }
xi.dynamis.mobList[zoneID][16 ].nmchildren = { true,  122 }
xi.dynamis.mobList[zoneID][17 ].nmchildren = { true,  123 }
xi.dynamis.mobList[zoneID][18 ].nmchildren = { true,  124, 125 }
xi.dynamis.mobList[zoneID][19 ].nmchildren = { true,  126, 127 }
xi.dynamis.mobList[zoneID][20 ].nmchildren = { true,  128 }
xi.dynamis.mobList[zoneID][21 ].nmchildren = { true,  129 }
xi.dynamis.mobList[zoneID][22 ].nmchildren = { true,  130, 131 }
xi.dynamis.mobList[zoneID][23 ].nmchildren = { true,  132, 133 }
xi.dynamis.mobList[zoneID][24 ].nmchildren = { true,  134 }
xi.dynamis.mobList[zoneID][25 ].nmchildren = { true,  135 }
xi.dynamis.mobList[zoneID][26 ].nmchildren = { true,  136, 137 }
xi.dynamis.mobList[zoneID][27 ].nmchildren = { true,  138, 139 }
xi.dynamis.mobList[zoneID][28 ].nmchildren = { true,  140 }
xi.dynamis.mobList[zoneID][29 ].nmchildren = { true,  141 }
xi.dynamis.mobList[zoneID][30 ].nmchildren = { true,  142, 143 }
xi.dynamis.mobList[zoneID][31 ].nmchildren = { true,  144, 145 }
xi.dynamis.mobList[zoneID][32 ].nmchildren = { true,  146, 147 }
xi.dynamis.mobList[zoneID][33 ].nmchildren = { true,  148, 149 }
xi.dynamis.mobList[zoneID][38 ].nmchildren = { true,  150, 151 }
xi.dynamis.mobList[zoneID][39 ].nmchildren = { true,  152, 153 }
xi.dynamis.mobList[zoneID][44 ].nmchildren = { true,  154 }
xi.dynamis.mobList[zoneID][45 ].nmchildren = { true,  155 }
xi.dynamis.mobList[zoneID][46 ].nmchildren = { true,  156, 157 }
xi.dynamis.mobList[zoneID][47 ].nmchildren = { true,  158, 159 }
xi.dynamis.mobList[zoneID][48 ].nmchildren = { true,  160 }
xi.dynamis.mobList[zoneID][49 ].nmchildren = { true,  161 }
xi.dynamis.mobList[zoneID][50 ].nmchildren = { true,  162, 163 }
xi.dynamis.mobList[zoneID][51 ].nmchildren = { true,  164, 165 }
xi.dynamis.mobList[zoneID][52 ].nmchildren = { true,  166 }
xi.dynamis.mobList[zoneID][53 ].nmchildren = { true,  167 }
xi.dynamis.mobList[zoneID][54 ].nmchildren = { true,  168, 169 }
xi.dynamis.mobList[zoneID][55 ].nmchildren = { true,  170, 171 }
xi.dynamis.mobList[zoneID][56 ].nmchildren = { true,  172 }
xi.dynamis.mobList[zoneID][57 ].nmchildren = { true,  173 }
xi.dynamis.mobList[zoneID][58 ].nmchildren = { true,  174, 175 }
xi.dynamis.mobList[zoneID][59 ].nmchildren = { true,  176, 177 }
xi.dynamis.mobList[zoneID][60 ].nmchildren = { true,  178, 179 }
xi.dynamis.mobList[zoneID][61 ].nmchildren = { true,  180, 181 }
xi.dynamis.mobList[zoneID][62 ].nmchildren = { true,  222 }
xi.dynamis.mobList[zoneID][63 ].nmchildren = { true,  223 }
xi.dynamis.mobList[zoneID][64 ].nmchildren = { true,  224 }
xi.dynamis.mobList[zoneID][65 ].nmchildren = { true,  225 }
xi.dynamis.mobList[zoneID][66 ].nmchildren = { true,  226 }
xi.dynamis.mobList[zoneID][67 ].nmchildren = { true,  227 }
xi.dynamis.mobList[zoneID][68 ].nmchildren = { true,  182, 183 }
xi.dynamis.mobList[zoneID][69 ].nmchildren = { true,  184, 185 }
xi.dynamis.mobList[zoneID][72 ].nmchildren = { true,  228, 229, 230 }
xi.dynamis.mobList[zoneID][74 ].nmchildren = { true,  231, 232, 233 }
xi.dynamis.mobList[zoneID][76 ].nmchildren = { true,  186, 187 }
xi.dynamis.mobList[zoneID][77 ].nmchildren = { true,  188, 189 }
xi.dynamis.mobList[zoneID][78 ].nmchildren = { true,  190, 191 }
xi.dynamis.mobList[zoneID][79 ].nmchildren = { true,  192, 193 }
xi.dynamis.mobList[zoneID][80 ].nmchildren = { true,  194, 195 }
xi.dynamis.mobList[zoneID][81 ].nmchildren = { true,  196, 197 }
xi.dynamis.mobList[zoneID][82 ].nmchildren = { true,  198, 199 }
xi.dynamis.mobList[zoneID][83 ].nmchildren = { true,  200, 201 }
xi.dynamis.mobList[zoneID][84 ].nmchildren = { true,  202, 203 }
xi.dynamis.mobList[zoneID][85 ].nmchildren = { true,  234, 235 }
xi.dynamis.mobList[zoneID][86 ].nmchildren = { true,  236, 237 }
xi.dynamis.mobList[zoneID][87 ].nmchildren = { true,  238, 239 }
xi.dynamis.mobList[zoneID][88 ].nmchildren = { true,  240, 241 }
xi.dynamis.mobList[zoneID][89 ].nmchildren = { true,  242, 243 }
xi.dynamis.mobList[zoneID][90 ].nmchildren = { true,  244, 245 }
xi.dynamis.mobList[zoneID][91 ].nmchildren = { true,  204, 205 }
xi.dynamis.mobList[zoneID][92 ].nmchildren = { true,  206, 207 }
xi.dynamis.mobList[zoneID][93 ].nmchildren = { true,  246, 247, 248 }
xi.dynamis.mobList[zoneID][96 ].nmchildren = { true,  249 }
xi.dynamis.mobList[zoneID][97 ].nmchildren = { true,  250 }
xi.dynamis.mobList[zoneID][98 ].nmchildren = { true,  251 }
xi.dynamis.mobList[zoneID][99 ].nmchildren = { true,  208, 209 }
xi.dynamis.mobList[zoneID][100].nmchildren = { true,  210, 211 }
xi.dynamis.mobList[zoneID][101].nmchildren = { true,  212, 213 }
xi.dynamis.mobList[zoneID][102].nmchildren = { true,  214, 215 }
xi.dynamis.mobList[zoneID][103].nmchildren = { true,  216, 217 }
xi.dynamis.mobList[zoneID][104].nmchildren = { true,  218, 219 }
xi.dynamis.mobList[zoneID][105].nmchildren = { true,  220, 221 }

------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].pos = {xpos, ypos, zpos, rot}

xi.dynamis.mobList[zoneID][1  ].pos = { 27.963, -11.975, 41.412, 62 } -- ( 001 )-Nightmare Bugard(15)
xi.dynamis.mobList[zoneID][2  ].pos = { -0.492, -22.75, -26.778, 193 } -- ( 002 )-Nightmare Worm
xi.dynamis.mobList[zoneID][3  ].pos = { -0.945, -36.71, 25.281, 122 } -- ( 003 )-Nightmare Antlion(30)
xi.dynamis.mobList[zoneID][4  ].pos = { -26.358, -21.97, 26.411, 161 } -- ( 004 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][5  ].pos = { -48.085, -22.051, 43.469, 128 } -- ( 005 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][6  ].pos = { -79.351, -22.007, 51.741, 57 } -- (006-H)
xi.dynamis.mobList[zoneID][7  ].pos = { -93.81, -27, 48.07, 127 } -- (007-H)
xi.dynamis.mobList[zoneID][8  ].pos = { -112.802, -27, 41.735, 255 } -- (008-H)
xi.dynamis.mobList[zoneID][9  ].pos = { -98.08, -27.02, 7.02, 190 } -- (009-H)
xi.dynamis.mobList[zoneID][10 ].pos = { -27.114, -22.075, -26.941, 225 } -- ( 010 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][11 ].pos = { -44.921, -22.026, -43.388, 127 } -- ( 011 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][12 ].pos = { -79.26, -21.79, -53.194, 201 } -- (012-H)
xi.dynamis.mobList[zoneID][13 ].pos = { -94.169, -27, -52.06, 129 } -- (013-H)
xi.dynamis.mobList[zoneID][14 ].pos = { -112.867, -27, -42.33, 253 } -- (014-H)
xi.dynamis.mobList[zoneID][15 ].pos = { -98.25, -27.02, -6.92, 63 } -- (015-H)
xi.dynamis.mobList[zoneID][16 ].pos = { -75.824, -20, 65.71, 13 } -- ( 016 )-Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][17 ].pos = { -88.107, -19.82, 64.57, 63 } -- ( 017 )-Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][18 ].pos = { -88.119, -14.54, 47.74, 0 } -- ( 018 )-Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][19 ].pos = { -86.376, -13.76, 36.24, 0 } -- ( 019 )-Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][20 ].pos = { -74, -11.14, 16.16, 193 } -- ( 020 )-Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][21 ].pos = { -74.09, -11.09, 7.78, 125 } -- ( 021 )-Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][22 ].pos = { -87.31, -12.64, 8.62, 4 } -- ( 022 )-Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][23 ].pos = { -89.58, -12.71, 6.76, 12 } -- ( 023 )-Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][24 ].pos = { -88.66, -20.06, -70.82, 122 } -- ( 024 )-Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][25 ].pos = { -89.36, -20.12, -69.05, 209 } -- ( 025 )-Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][26 ].pos = { -87.69, -14.42, -47.04, 0 } -- ( 026 )-Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][27 ].pos = { -84.038, -12.9, -34.33, 0 } -- ( 027 )-Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][28 ].pos = { -73.84, -10.86, -22.94, 30 } -- ( 028 )-Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][29 ].pos = { -74.12, -11.12, -9.12, 119 } -- ( 029 )-Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][30 ].pos = { -87.10, -12.55, -8.09, 112 } -- ( 030 )-Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][31 ].pos = { -90.97, -13.04, -7.25, 30 } -- ( 031 )-Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][32 ].pos = { -26.358, -21.97, 26.411, 161 } -- ( 032 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][33 ].pos = { -48.085, -22.051, 43.469, 128 } -- ( 033 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][34 ].pos = { -79.351, -22.007, 51.741, 57 } -- (034-H)
xi.dynamis.mobList[zoneID][35 ].pos = { -93.81, -27, 48.07, 127 }-- (035-H)
xi.dynamis.mobList[zoneID][36 ].pos = { -112.802, -27, 41.735, 255 } -- (036-H)
xi.dynamis.mobList[zoneID][37 ].pos = { -98.08, -27.02, 7.02, 190 } --(037-H)
xi.dynamis.mobList[zoneID][38 ].pos = { -27.114, -22.075, -26.941, 225 } -- ( 038 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][39 ].pos = { -44.921, -22.026, -43.388, 127 } -- ( 039 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][40 ].pos = { -79.26, -21.79, -53.194, 201 } -- (040-H)
xi.dynamis.mobList[zoneID][41 ].pos = { -94.169, -27, -52.06, 129 } -- (041-H)
xi.dynamis.mobList[zoneID][42 ].pos = { -112.867, -27, -42.33, 253 } -- (042-H)
xi.dynamis.mobList[zoneID][43 ].pos = { -98.25, -27.02, -6.92, 63 } -- (043-H)
xi.dynamis.mobList[zoneID][44 ].pos = { -75.824, -20, 65.71, 13, 0 } -- ( 044 )-Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][45 ].pos = { -88.107, -19.82, 64.57, 63, 0 } -- ( 045 )-Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][46 ].pos = { -88.119, -14.54, 47.74, 0 } -- ( 046 )-Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][47 ].pos = { -86.376, -13.76, 36.24, 0 } -- ( 047 )-Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][48 ].pos = { -74, -11.14, 16.16, 193 } -- ( 048 )-Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][49 ].pos = { -74.09, -11.09, 7.78, 125 } -- ( 049 )-Nightmare Leech (×2)
xi.dynamis.mobList[zoneID][50 ].pos = { -87.31, -12.64, 8.62, 4 } -- ( 050 )-Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][51 ].pos = { -89.58, -12.71, 6.76, 12 }  -- ( 051 )-Nightmare Leech (×3)
xi.dynamis.mobList[zoneID][52 ].pos = { -88.66, -20.06, -70.82, 122 } -- ( 052 )-Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][53 ].pos = { -89.36, -20.12, -69.05, 209 } -- ( 053 )-Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][54 ].pos = { -87.69, -14.42, -47.04, 0 } -- ( 054 )-Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][55 ].pos = { -84.038, -12.9, -34.33, 0 } -- ( 055 )-Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][56 ].pos = { -73.84, -10.86, -22.94, 30 } -- ( 056 )-Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][57 ].pos = { -74.12, -11.12, -9.12, 119 } -- ( 057 )-Nightmare Makara (×2)
xi.dynamis.mobList[zoneID][58 ].pos = { -87.10, -12.55, -8.09, 112 } -- ( 058 )-Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][59 ].pos = { -90.97, -13.04, -7.25, 30 } -- ( 059 )-Nightmare Makara (×3)
xi.dynamis.mobList[zoneID][60 ].pos = { 26.645, -36.03, 26.80, 95 } -- ( 060 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][61 ].pos = { 46.02, -36.01, 43.65, 0 } -- ( 061 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][62 ].pos = { 80.81, -36.20, 44.08, 128 } -- (062-D)
xi.dynamis.mobList[zoneID][63 ].pos = { 78.73, -34.37, 59.60, 67 } -- (063-D)
xi.dynamis.mobList[zoneID][64 ].pos = { 80.92, -38.75, 26.42, 151 } -- (064-D)
xi.dynamis.mobList[zoneID][65 ].pos = { 93.67, -41, 40.09, 123 } -- (065-D)
xi.dynamis.mobList[zoneID][66 ].pos = { 113.12, -41, 41.79, 126 } -- (066-D)
xi.dynamis.mobList[zoneID][67 ].pos = { 98.33, -41.01, 6.71, 191 } -- (067-D)
xi.dynamis.mobList[zoneID][68 ].pos = { 26.18, -35.92, -25.99, 0 } -- ( 068 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][69 ].pos = { 47.43, -36.06, -43.24, 0 } -- ( 069 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][70 ].pos = { 80.73, -36.19, -43.01, 125 } -- (070-D)
xi.dynamis.mobList[zoneID][71 ].pos = { 79.37, -34.78, -57.62, 196 } -- (071-D)
xi.dynamis.mobList[zoneID][72 ].pos = { 82.25, -39.20, -25.12, 105 } -- (072-D)
xi.dynamis.mobList[zoneID][73 ].pos = { 93.95, -41, -44.25, 127 } -- (073-D)
xi.dynamis.mobList[zoneID][74 ].pos = { 112.95, -41, -42.22, 125 } -- (074-D)
xi.dynamis.mobList[zoneID][75 ].pos = { 98.22, -41, -6.71, 67 } -- (075-D)
xi.dynamis.mobList[zoneID][76 ].pos = { 86.83, -33.93, 65.52, 0 } -- ( 076 )-Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][77 ].pos = { 88.14, -28, 39.44, 0 } -- ( 077 )-Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][78 ].pos = { 87.68, -33.72, -60.55, 0 } -- ( 078 )-Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][79 ].pos = { 87.56, -28, -37.52, 0 } -- ( 079 )-Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][80 ].pos = { 73.95, -25.05, 21.39, 0 } -- ( 080 )-Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][81 ].pos = { 70.23, -25, 4.81, 0 } -- ( 081 )-Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][82 ].pos = { 74, -25, -21.02, 0 } -- ( 082 )-Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][83 ].pos = { 26.645, -36.03, 26.80, 95 }-- ( 083 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][84 ].pos = { 46.02, -36.01, 43.65, 0 } -- ( 084 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][85 ].pos = { 80.81, -36.20, 44.08, 128 } -- (085-D)
xi.dynamis.mobList[zoneID][86 ].pos = { 78.73, -34.37, 59.60, 67 }  -- (086-D)
xi.dynamis.mobList[zoneID][87 ].pos = { 80.92, -38.75, 26.42, 151 } -- (087-D)
xi.dynamis.mobList[zoneID][88 ].pos = { 93.67, -41, 40.09, 123 } -- (088-D)
xi.dynamis.mobList[zoneID][89 ].pos = { 113.12, -41, 41.79, 126 } -- (089-D)
xi.dynamis.mobList[zoneID][90 ].pos = { 43.37, -36.1, 42.54, 250 }  -- (090-D)
xi.dynamis.mobList[zoneID][91 ].pos = { 26.18, -35.92, -25.99, 0 } -- ( 091 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][92 ].pos = { 47.43, -36.06, -43.24, 0 } -- ( 092 )-Nightmare Hornet (×3)
xi.dynamis.mobList[zoneID][93 ].pos = { 80.73, -36.19, -43.01, 125 } -- (093-D)
xi.dynamis.mobList[zoneID][94 ].pos = { 79.37, -34.78, -57.62, 196 } -- (094-D)
xi.dynamis.mobList[zoneID][95 ].pos = { 82.25, -39.20, -25.12, 105 } -- (095-D)
xi.dynamis.mobList[zoneID][96 ].pos = { 93.95, -41, -44.25, 127 } -- (096-D)
xi.dynamis.mobList[zoneID][97 ].pos = { 112.95, -41, -42.22, 125 } -- (097-D)
xi.dynamis.mobList[zoneID][98 ].pos = { 43.37, -36.1, -42.54, 0 } -- (098-D)
xi.dynamis.mobList[zoneID][99 ].pos = { 86.83, -33.93, 65.52, 0 } -- ( 099 )-Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][100].pos = { 88.14, -28, 39.44, 0 } -- ( 100 )-Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][101].pos = { 87.68, -33.72, -60.55, 0 } -- ( 101 )-Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][102].pos = { 87.56, -28, -37.52, 0 } -- ( 102 )-Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][103].pos = { 73.95, -25.05, 21.39, 0 } -- ( 103 )-Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][104].pos = { 70.23, -25, 4.81, 0 } -- ( 104 )-Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][105].pos = { 74, -25, -21.02, 0 } -- ( 105 )-Nightmare Cluster (×3)
xi.dynamis.mobList[zoneID][106].pos = { 0.17, -24.77, 67, 70 } -- ( 106 )-Umbral Diabolos
xi.dynamis.mobList[zoneID][107].pos = { -12.29, -27.71, 89.71, 54 } -- ( 107 )-Umbral Diabolos
xi.dynamis.mobList[zoneID][108].pos = { -2.58, -27.95, 105.45, 127 } -- ( 108 )-Umbral Diabolos
xi.dynamis.mobList[zoneID][109].pos = { -15.71, -27.92, 110.71, 57 } -- ( 109 )-Umbral Diabolos
xi.dynamis.mobList[zoneID][110].pos = { -35.94, -27.23, 119.30, 230 } -- ( 110 )-Diabolos Club
xi.dynamis.mobList[zoneID][111].pos = { -43.83, -29.67, 155.47, 33 } -- ( 111 )-Diabolos Heart
xi.dynamis.mobList[zoneID][112].pos = { 3.67, -29.69, 152.06, 103 } -- ( 112 )-Diabolos Spade
xi.dynamis.mobList[zoneID][113].pos = { 8.28, -26.28, 123.05, 143 } -- ( 113 )-Diabolos Diamond
xi.dynamis.mobList[zoneID][252].pos = { -35.94, -27.23, 119.30, 230 } -- ( 110 )-Diabolos Club

----------------------------------------------------------------------------------------------------
--                                    Setup of Mob Functions                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--             Patrol Paths             --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].patrolPath = {xpos1,ypos1,zpos1, xpos2,ypos2,zpos2,  xpos3,ypos3,zpos3}
xi.dynamis.mobList[zoneID].patrolPaths =
    {
        4, 5, 10, 11, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27,
        28, 29, 30, 31, 32, 33, 38, 39, 44, 45, 46, 47, 56, 57, 58,
        59, 60, 61, 68, 69, 76, 77, 78, 79, 80, 81, 82, 83, 84, 91, 92
    }

xi.dynamis.mobList[zoneID][4  ].patrolPath = { { -26.358, -21.97, 26.411 }, { -40.109, 22.232, 40.212 } }
xi.dynamis.mobList[zoneID][5  ].patrolPath = { { -48.085, -22.051, 43.469 }, { -63.012, -22.03, 43.799 } }
xi.dynamis.mobList[zoneID][10 ].patrolPath = { { -27.114, -22.075, -26.941 }, { -37.896, -22.169, -37.871 } }
xi.dynamis.mobList[zoneID][11 ].patrolPath = { { -44.921, -22.026, -43.388 }, { -63.904, -22.028, -43.865 } }
xi.dynamis.mobList[zoneID][16 ].patrolPath = { { -75.824, -20, 65.71 }, { -88.177, -19.96, 66.99 } }
xi.dynamis.mobList[zoneID][17 ].patrolPath = { { -88.107, -19.82, 64.57 }, { -88.06, -15.29, 49.79 } }
xi.dynamis.mobList[zoneID][18 ].patrolPath = { { -88.119, -14.54, 47.74 }, { -87.79, -14, 36.53 } }
xi.dynamis.mobList[zoneID][19 ].patrolPath = { { -86.376, -13.76, 36.24 }, { -77.85, -10.89, 28.93 } }
xi.dynamis.mobList[zoneID][20 ].patrolPath = { { -74, -11.14, 16.16 }, { -73.76, -11.08, 8.89 } }
xi.dynamis.mobList[zoneID][21 ].patrolPath = { { -74.09, -11.09, 7.78 }, { -74.10, -11.91, 2.04 } }
xi.dynamis.mobList[zoneID][22 ].patrolPath = { { -87.31, -12.64, 8.62 }, { -87.68, -13.36, 1.44 } }
xi.dynamis.mobList[zoneID][23 ].patrolPath = { { -89.58, -12.71, 6.76 }, { -79.12, -11.34, 7.71 } }
xi.dynamis.mobList[zoneID][24 ].patrolPath = { { -88.66, -20.06, -70.82 }, { -77.18, -20, -68.71 } }
xi.dynamis.mobList[zoneID][25 ].patrolPath = { { -89.36, -20.12, -69.05 }, { -88.007, -15.33, -49.93 } }
xi.dynamis.mobList[zoneID][26 ].patrolPath = { { -87.69, -14.42, -47.04 }, { -86.76, -13.87, -36.38 } }
xi.dynamis.mobList[zoneID][27 ].patrolPath = { { -84.038, -12.9, -34.33 }, { -74.28, -10.79, -23.86 } }
xi.dynamis.mobList[zoneID][28 ].patrolPath = { { -73.84, -10.86, -22.94 }, { -73.969, -11.141, -13.271 } }
xi.dynamis.mobList[zoneID][29 ].patrolPath = { { -74.12, -11.12, -9.12 }, { -73.91, -11.86, -1.56 } }
xi.dynamis.mobList[zoneID][30 ].patrolPath = { { -87.10, -12.55, -8.09 }, { -87.68, -13.36, -1.24 } }
xi.dynamis.mobList[zoneID][31 ].patrolPath = { { -90.97, -13.04, -7.25 }, { -78.84, -11.23, -7.36 } }
xi.dynamis.mobList[zoneID][32 ].patrolPath = { { -26.358, -21.97, 26.411 }, { -40.109, 22.232, 40.212 } }
xi.dynamis.mobList[zoneID][33 ].patrolPath = { { -48.085, -22.051, 43.469 }, { -63.012, -22.03, 43.799 } }
xi.dynamis.mobList[zoneID][38 ].patrolPath = { { -27.114, -22.075, -26.941 }, { -37.896, -22.169, -37.871 } }
xi.dynamis.mobList[zoneID][39 ].patrolPath = { { -44.921, -22.026, -43.388 }, { -63.904, -22.028, -43.865 } }
xi.dynamis.mobList[zoneID][44 ].patrolPath = { { -75.824, -20, 65.71 }, { -88.177, -19.96, 66.99 } }
xi.dynamis.mobList[zoneID][45 ].patrolPath = { { -88.107, -19.82, 64.57 }, { -88.06, -15.29, 49.79 } }
xi.dynamis.mobList[zoneID][46 ].patrolPath = { { -88.119, -14.54, 47.74 }, { -87.79, -14, 36.53 } }
xi.dynamis.mobList[zoneID][47 ].patrolPath = { { -86.376, -13.76, 36.24 }, { -77.85, -10.89, 28.93 } }
xi.dynamis.mobList[zoneID][56 ].patrolPath = { { -73.84, -10.86, -22.94 }, { -73.969, -11.141, -13.271 } }
xi.dynamis.mobList[zoneID][57 ].patrolPath = { { -74.12, -11.12, -9.12 }, { -73.91, -11.86, -1.56 } }
xi.dynamis.mobList[zoneID][58 ].patrolPath = { { -87.10, -12.55, -8.09 }, { -87.68, -13.36, -1.24 } }
xi.dynamis.mobList[zoneID][59 ].patrolPath = { { -90.97, -13.04, -7.25 }, { -78.84, -11.23, -7.36 } }
xi.dynamis.mobList[zoneID][60 ].patrolPath = { { 26.645, -36.03, 26.80 }, { 40.232, -36.24, 40.01 } }
xi.dynamis.mobList[zoneID][61 ].patrolPath = { { 46.02, -36.01, 43.65 }, { 61.50, -36.01, 43.96 } }
xi.dynamis.mobList[zoneID][68 ].patrolPath = { { 26.18, -35.92, -25.99 }, { 40.67, -36.20, -40.54 } }
xi.dynamis.mobList[zoneID][69 ].patrolPath = { { 47.43, -36.06, -43.24 }, { 62.50, -36.01, -43.90 } }
xi.dynamis.mobList[zoneID][76 ].patrolPath = { { 86.83, -33.93, 65.52 }, { 87.79, -28.30, 46.23 } }
xi.dynamis.mobList[zoneID][77 ].patrolPath = { { 88.14, -28, 39.44 }, { 73.93, -24.82, 24.32 } }
xi.dynamis.mobList[zoneID][78 ].patrolPath = { { 87.68, -33.72, -60.55 }, { 88.10, -28, -42.12 } }
xi.dynamis.mobList[zoneID][79 ].patrolPath = { { 87.56, -28, -37.52 }, { 74.64, -24.83, -24.88 } }
xi.dynamis.mobList[zoneID][80 ].patrolPath = { { 73.95, -25.05, 21.39 }, { 73.93, -24.79, 7.95 } }
xi.dynamis.mobList[zoneID][81 ].patrolPath = { { 70.23, -25, 4.81 }, { 70.23, -25, -4.23 } }
xi.dynamis.mobList[zoneID][82 ].patrolPath = { { 74, -25, -21.02 }, { 73.81, -24.79, -6.64 } }
xi.dynamis.mobList[zoneID][83 ].patrolPath = { { 26.645, -36.03, 26.80 }, { 40.232, -36.24, 40.01 } }
xi.dynamis.mobList[zoneID][84 ].patrolPath = { { 46.02, -36.01, 43.65 }, { 61.50, -36.01, 43.96 } }
xi.dynamis.mobList[zoneID][91 ].patrolPath = { { 26.18, -35.92, -25.99 }, { 40.67, -36.20, -40.54 } }
xi.dynamis.mobList[zoneID][92 ].patrolPath = { { 47.43, -36.06, -43.24 }, { 62.50, -36.01, -43.90 } }

------------------------------------------
--          Statue Eye Colors           --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eye.BLUE -- Flags for blue eyes. (HP)
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eye.GREEN -- Flags for green eyes. (MP)

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].timeExtension = 15

xi.dynamis.mobList[zoneID].timeExtensionList = { 1, 3 }
xi.dynamis.mobList[zoneID][1].timeExtension = 15 -- Nightmare Bugard
xi.dynamis.mobList[zoneID][3].timeExtension = 30 -- Nightmare Antlion
