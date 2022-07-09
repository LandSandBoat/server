----------------------------------------------------------------------------------------------------
--                                      Dynamis-Qufim                                             --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/quf.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/quf.html        --
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
local zoneID = xi.zone.DYNAMIS_QUFIM
local i = 1
xi = xi or {} -- Ignore me I just set the global.
xi.dynamis = xi.dynamis or {} -- Ignore me I just set the global.
xi.dynamis.mobList = xi.dynamis.mobList or { } -- Ignore me I just set the global.
xi.dynamis.mobList[zoneID] = { } -- Ignore me, I just start the table.
xi.dynamis.mobList[zoneID].nmchildren = { }
xi.dynamis.mobList[zoneID].mobchildren = { }
xi.dynamis.mobList[zoneID].maxWaves = 2 -- Put in number of max waves

while i <= 279 do
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

-- Sea Monk NM Area
xi.dynamis.mobList[zoneID][1  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil}     -- (001-Q)
xi.dynamis.mobList[zoneID][2  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil}     -- (002-Q)
-- Southwest AreaStatue"Quadav"
xi.dynamis.mobList[zoneID][3  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil}     -- (003-Q)
xi.dynamis.mobList[zoneID][4  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil}     -- (004-Q)
xi.dynamis.mobList[zoneID][5  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil}     -- (005-Q)
xi.dynamis.mobList[zoneID][6  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil}     -- (006-Q)
xi.dynamis.mobList[zoneID][7  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil}     -- (007-Q)
xi.dynamis.mobList[zoneID][8  ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}          -- (008-Y)
xi.dynamis.mobList[zoneID][9  ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}          -- (009-Y)
xi.dynamis.mobList[zoneID][10 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}          -- (010-Y)
xi.dynamis.mobList[zoneID][11 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}          -- (011-Y)
xi.dynamis.mobList[zoneID][12 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}          -- (012-Y)
xi.dynamis.mobList[zoneID][13 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}          -- (013-Y)
xi.dynamis.mobList[zoneID][14 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}          -- (014-Y)
xi.dynamis.mobList[zoneID][15 ].info = {"Statue", "Manifest Icon", "Yagudo", nil, nil}          -- (015-Y)
-- Northeast Area
xi.dynamis.mobList[zoneID][16 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}        -- (016-O)
xi.dynamis.mobList[zoneID][17 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}        -- (017-O)
xi.dynamis.mobList[zoneID][18 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}        -- (018-O)
xi.dynamis.mobList[zoneID][19 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}        -- (019-O)
xi.dynamis.mobList[zoneID][20 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}        -- (020-O)
xi.dynamis.mobList[zoneID][21 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}        -- (021-O)
xi.dynamis.mobList[zoneID][22 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}        -- (022-O)
xi.dynamis.mobList[zoneID][23 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}        -- (023-O)
xi.dynamis.mobList[zoneID][24 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil}        -- (024-O)
xi.dynamis.mobList[zoneID][25 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}         -- (025-G)
xi.dynamis.mobList[zoneID][26 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}         -- (026-G)
-- Boss Area
xi.dynamis.mobList[zoneID][27 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}         -- (027-G)
xi.dynamis.mobList[zoneID][28 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}         -- (028-G)
xi.dynamis.mobList[zoneID][29 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}         -- (029-G)
xi.dynamis.mobList[zoneID][30 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}         -- (030-G)
xi.dynamis.mobList[zoneID][31 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}         -- (031-G)
-- Golem NM Area
xi.dynamis.mobList[zoneID][32 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}         -- (032-G)
xi.dynamis.mobList[zoneID][33 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}         -- (033-G)
xi.dynamis.mobList[zoneID][34 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}         -- (034-G)
xi.dynamis.mobList[zoneID][35 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}         -- (035-G)
-- Giant Bat NM Area
xi.dynamis.mobList[zoneID][36 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}         -- (036-G)
xi.dynamis.mobList[zoneID][37 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}         -- (037-G)
xi.dynamis.mobList[zoneID][38 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}         -- (038-G)
xi.dynamis.mobList[zoneID][39 ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}         -- (039-G)
-- Sea Monk NM Area
xi.dynamis.mobList[zoneID][43 ].info = {"Elemental", "Water Elemental", nil, nil, "water_killed"}       -- (043) (Reduces Antaeus' resistance to water)
xi.dynamis.mobList[zoneID][40 ].info = {"NM", "Scolopendra", nil, nil, "scolopendra_killed"}            -- (040) (Reduces Antaeus' HP regeneration rate)
-- Southwest Area
xi.dynamis.mobList[zoneID][44 ].info = {"Elemental", "Fire Elemental", nil, nil, "fire_killed"}         -- (044) (Reduces Antaeus' resistance to fire)
-- Giant Bat Area
xi.dynamis.mobList[zoneID][45 ].info = {"Elemental", "Thunder Elemental", nil, nil, "thunder_killed"}   -- (045) (Reduces Antaeus' resistance to thunder)
xi.dynamis.mobList[zoneID][41 ].info = {"NM", "Stringes", nil, nil, "stringes_killed"}                  -- (041) (Reduces Antaeus' physical attack damage)
-- Northeast Area
xi.dynamis.mobList[zoneID][46 ].info = {"Elemental", "Air Elemental", nil, nil, "air_killed"}           -- (046) (Reduces Antaeus' resistance to wind)
xi.dynamis.mobList[zoneID][47 ].info = {"Elemental", "Light Elemental", nil, nil, "light_killed"}       -- (047) (Reduces Antaeus' resistance to light)
-- Boss Area
xi.dynamis.mobList[zoneID][48 ].info = {"Elemental", "Ice Elemental", nil, nil, "ice_killed"}           -- (048) (Reduces Antaeus' resistance to ice)
xi.dynamis.mobList[zoneID][64 ].info = {"NM", "Antaeus", nil, nil, "MegaBoss_Killed"}                   -- (064) (Spawns 065-138)
-- Golem NM Area
xi.dynamis.mobList[zoneID][49 ].info = {"Elemental", "Earth Elemental", nil, nil, "earth_killed"}       -- (049) (Reduces Antaeus' resistance to earth)
xi.dynamis.mobList[zoneID][50 ].info = {"Elemental", "Dark Elemental", nil, nil, "dark_killed"}         -- (050) (Reduces Antaeus' resistance to dark)
xi.dynamis.mobList[zoneID][42 ].info = {"NM", "Suttung", nil, nil, "suttung_killed"}                    -- (042) (Reduces Antaeus' magic damage resistance)
-- Nightmare Stirge
xi.dynamis.mobList[zoneID][51 ].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  -- 051-Nightmare Stirge (×4)
xi.dynamis.mobList[zoneID][244].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][245].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][246].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][52 ].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  -- 052-Nightmare Stirge (×4)
xi.dynamis.mobList[zoneID][247].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][248].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][249].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][53 ].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  -- 053-Nightmare Stirge (×4)
xi.dynamis.mobList[zoneID][250].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][251].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][252].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][62 ].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  -- 062-Nightmare Stirge (×3)
xi.dynamis.mobList[zoneID][253].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][254].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][63 ].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  -- 063-Nightmare Stirge (×4)
xi.dynamis.mobList[zoneID][255].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][256].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][257].info = {"Nightmare", "Nightmare Stirge", nil, nil, nil}  --
-- Nightmare Roc
xi.dynamis.mobList[zoneID][58 ].info = {"Nightmare", "Nightmare Roc", nil, nil, nil}     -- 058-Nightmare Roc (×3)
xi.dynamis.mobList[zoneID][258].info = {"Nightmare", "Nightmare Roc", nil, nil, nil}     --
xi.dynamis.mobList[zoneID][259].info = {"Nightmare", "Nightmare Roc", nil, nil, nil}     --
xi.dynamis.mobList[zoneID][61 ].info = {"Nightmare", "Nightmare Roc", nil, nil, nil}     -- 061-Nightmare Roc (×3)
xi.dynamis.mobList[zoneID][260].info = {"Nightmare", "Nightmare Roc", nil, nil, nil}     --
xi.dynamis.mobList[zoneID][261].info = {"Nightmare", "Nightmare Roc", nil, nil, nil}     --
-- Nightmare Snoll
xi.dynamis.mobList[zoneID][54 ].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   -- 054-Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][262].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][263].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][264].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][55 ].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   -- 055-Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][265].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][266].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][267].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][56 ].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   -- 056-Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][268].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][269].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][270].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][57 ].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   -- 057-Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][271].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][272].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][273].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][59 ].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   -- 059-Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][274].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][275].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][276].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][60 ].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   -- 060-Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][277].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][278].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][279].info = {"Nightmare", "Nightmare Snoll", nil, nil, nil}   --
-- Southwest Area
xi.dynamis.mobList[zoneID][65].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}   -- (065-G)
xi.dynamis.mobList[zoneID][66].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}   -- (066-G)
xi.dynamis.mobList[zoneID][67].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}   -- (067-G)
xi.dynamis.mobList[zoneID][68].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}   -- (068-G)
-- Northeast Area
xi.dynamis.mobList[zoneID][69].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}   -- (069-G)
xi.dynamis.mobList[zoneID][70].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}   -- (070-G)
-- Central Area
xi.dynamis.mobList[zoneID][71].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}   -- (071-G)
xi.dynamis.mobList[zoneID][72].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}   -- (072-G)
xi.dynamis.mobList[zoneID][73].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}   -- (073-G)
xi.dynamis.mobList[zoneID][74].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}   -- (074-G)
xi.dynamis.mobList[zoneID][75].info = {"Statue", "Goblin Replica", "Goblin", nil, nil}   -- (075-G)
-- Nightmare Weapon
xi.dynamis.mobList[zoneID][76 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 076-Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][139].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][140].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][77 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 077-Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][141].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][142].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][78 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 078-Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][143].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][144].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][79 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 079-Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][145].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][146].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][80 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 080-Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][147].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][148].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][81 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 081-Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][149].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][150].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][82 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 082-Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][151].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][152].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][83 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 083-Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][153].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][154].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][84 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 084-Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][155].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][156].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][85 ].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  -- 085-Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][157].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][158].info = {"Nightmare", "Nightmare Weapon", nil, nil, nil}  --
-- Nightmare Kraken
xi.dynamis.mobList[zoneID][86 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 086-Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][159].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][87 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 087-Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][160].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][88 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 088-Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][161].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][89 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 089-Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][162].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][90 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 090-Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][163].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][91 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 091-Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][164].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][92 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 092-Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][165].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][93 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 093-Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][166].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][94 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 094-Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][167].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][95 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 095-Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][168].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][96 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 096-Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][169].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][97 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 097-Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][170].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][98 ].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  -- 098-Nightmare Kraken (×3)
xi.dynamis.mobList[zoneID][171].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][172].info = {"Nightmare", "Nightmare Kraken", nil, nil, nil}  --
-- Nightmare Tiger
xi.dynamis.mobList[zoneID][99 ].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   -- 099-Nightmare Tiger (×4)
xi.dynamis.mobList[zoneID][173].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][174].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][175].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][100].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   -- 100-Nightmare Tiger (×4)
xi.dynamis.mobList[zoneID][176].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][177].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][178].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][101].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   -- 101-Nightmare Tiger (×4)
xi.dynamis.mobList[zoneID][179].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][180].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][181].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][102].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   -- 102-Nightmare Tiger (×5)
xi.dynamis.mobList[zoneID][182].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][183].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][184].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][185].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][103].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   -- 103-Nightmare Tiger (×5)
xi.dynamis.mobList[zoneID][186].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][187].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][188].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][189].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][104].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   -- 104-Nightmare Tiger (×5)
xi.dynamis.mobList[zoneID][190].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][191].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][192].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][193].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][105].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   -- 105-Nightmare Tiger (×5)
xi.dynamis.mobList[zoneID][194].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][195].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][196].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
xi.dynamis.mobList[zoneID][197].info = {"Nightmare", "Nightmare Tiger", nil, nil, nil}   --
-- Nightmare Raptor
xi.dynamis.mobList[zoneID][106].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 106-Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][198].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][107].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 107-Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][199].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][108].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 108-Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][200].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][109].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 109-Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][201].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][110].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 110-Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][202].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][111].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 111-Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][203].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][112].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 112-Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][204].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][113].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 113-Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][205].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][114].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 114-Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][206].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][115].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 115-Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][207].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][116].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 116-Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][208].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][117].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  -- 117-Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][209].info = {"Nightmare", "Nightmare Raptor", nil, nil, nil}  --
--Nightmare Diremite
xi.dynamis.mobList[zoneID][118].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 118-Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][210].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][119].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 119-Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][211].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][120].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 120-Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][212].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][121].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 121-Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][213].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][122].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 122-Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][214].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][123].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 123-Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][215].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][124].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 124-Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][216].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][125].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 125-Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][217].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][126].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 126-Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][218].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][127].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 127-Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][219].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][128].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 128-Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][220].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][129].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 129-Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][221].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
xi.dynamis.mobList[zoneID][130].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} -- 130-Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][222].info = {"Nightmare", "Nightmare Diremite", nil, nil, nil} --
-- Nightmare Gaylas
xi.dynamis.mobList[zoneID][131].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 131-Nightmare Gaylas (×3)
xi.dynamis.mobList[zoneID][223].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][224].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][132].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 132-Nightmare Gaylas (×3)
xi.dynamis.mobList[zoneID][225].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][226].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][133].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 133-Nightmare Gaylas (×3)
xi.dynamis.mobList[zoneID][227].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][228].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][134].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 134-Nightmare Gaylas (×4)
xi.dynamis.mobList[zoneID][229].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][230].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][231].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][135].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 135-Nightmare Gaylas (×4)
xi.dynamis.mobList[zoneID][232].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][233].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][234].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][136].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 136-Nightmare Gaylas (×4)
xi.dynamis.mobList[zoneID][235].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][236].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][237].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][137].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 137-Nightmare Gaylas (×4)
xi.dynamis.mobList[zoneID][238].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][239].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][240].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][138].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  -- 138-Nightmare Gaylas (×4)
xi.dynamis.mobList[zoneID][241].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][242].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --
xi.dynamis.mobList[zoneID][243].info = {"Nightmare", "Nightmare Gaylas", nil, nil, nil}  --

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
    1 , -- (001-Q) Adamantking Effigy
    2 , -- (002-Q) Adamantking Effigy
    3 , -- (003-Q) Adamantking Effigy
    4 , -- (004-Q) Adamantking Effigy
    5 , -- (005-Q) Adamantking Effigy
    6 , -- (006-Q) Adamantking Effigy
    7 , -- (007-Q) Adamantking Effigy
    8 , -- (008-Y) Manifest Icon
    9 , -- (009-Y) Manifest Icon
    10, -- (010-Y) Manifest Icon
    11, -- (011-Y) Manifest Icon
    12, -- (012-Y) Manifest Icon
    13, -- (013-Y) Manifest Icon
    14, -- (014-Y) Manifest Icon
    15, -- (015-Y) Manifest Icon
    16, -- (016-O) Serjeant Tombstone
    17, -- (017-O) Serjeant Tombstone
    18, -- (018-O) Serjeant Tombstone
    19, -- (019-O) Serjeant Tombstone
    20, -- (020-O) Serjeant Tombstone
    21, -- (021-O) Serjeant Tombstone
    22, -- (022-O) Serjeant Tombstone
    23, -- (023-O) Serjeant Tombstone
    24, -- (024-O) Serjeant Tombstone
    25, -- (025-G) Goblin Replica
    26, -- (026-G) Goblin Replica
    27, -- (027-G) Goblin Replica
    32, -- (032-G) Goblin Replica
    33, -- (033-G) Goblin Replica
    34, -- (034-G) Goblin Replica
    35, -- (035-G) Goblin Replica
    36, -- (036-G) Goblin Replica
    37, -- (037-G) Goblin Replica
    38, -- (038-G) Goblin Replica
    39, -- (039-G) Goblin Replica
    -- Wave 1 Nightmare Mobs
    51, -- ( 051 ) Nightmare Stirge (×4)
    52, -- ( 052 ) Nightmare Stirge (×4)
    53, -- ( 053 ) Nightmare Stirge (×4)
    62, -- ( 062 ) Nightmare Stirge (×3)
    63, -- ( 063 ) Nightmare Stirge (×4)
    58, -- ( 058 ) Nightmare Roc (×3)
    61, -- ( 061 ) Nightmare Roc (×3)
    54, -- ( 054 ) Nightmare Snoll (×4)
    55, -- ( 055 ) Nightmare Snoll (×4)
    56, -- ( 056 ) Nightmare Snoll (×4)
    57, -- ( 057 ) Nightmare Snoll (×4)
    59, -- ( 059 ) Nightmare Snoll (×4)
    60, -- ( 060 ) Nightmare Snoll (×4)
    -- Wave 1 Elementals and NMs
    43, -- ( 043 ) Water Elemental
    40, -- ( 040 ) Scolopendra
    44, -- ( 044 ) Fire Elemental
    45, -- ( 045 ) Thunder Elemental
    41, -- ( 041 ) Stringes
    46, -- ( 046 ) Air Elemental
    47, -- ( 047 ) Light Elemental
    48, -- ( 048 ) Ice Elemental
    64, -- ( 064 ) Antaeus
    49, -- ( 049 ) Earth Elemental
    50, -- ( 050 ) Dark Elemental
    42  -- ( 042 ) Suttung
}

xi.dynamis.mobList[zoneID][2].wave =
{
    76 , --  ( 076 ) Nightmare Weapon (×3)
    77 , --  ( 077 ) Nightmare Weapon (×3)
    78 , --  ( 078 ) Nightmare Weapon (×3)
    79 , --  ( 079 ) Nightmare Weapon (×3)
    80 , --  ( 080 ) Nightmare Weapon (×3)
    81 , --  ( 081 ) Nightmare Weapon (×3)
    82 , --  ( 082 ) Nightmare Weapon (×3)
    83 , --  ( 083 ) Nightmare Weapon (×3)
    84 , --  ( 084 ) Nightmare Weapon (×3)
    85 , --  ( 085 ) Nightmare Weapon (×3)
    86 , --  ( 086 ) Nightmare Kraken (×2)
    87 , --  ( 087 ) Nightmare Kraken (×2)
    88 , --  ( 088 ) Nightmare Kraken (×2)
    89 , --  ( 089 ) Nightmare Kraken (×2)
    90 , --  ( 090 ) Nightmare Kraken (×2)
    91 , --  ( 091 ) Nightmare Kraken (×2)
    92 , --  ( 092 ) Nightmare Kraken (×2)
    93 , --  ( 093 ) Nightmare Kraken (×2)
    94 , --  ( 094 ) Nightmare Kraken (×2)
    95 , --  ( 095 ) Nightmare Kraken (×2)
    96 , --  ( 096 ) Nightmare Kraken (×2)
    97 , --  ( 097 ) Nightmare Kraken (×2)
    98 , --  ( 098 ) Nightmare Kraken (×3)
    99 , --  ( 099 ) Nightmare Tiger (×4)
    100, --  ( 100 ) Nightmare Tiger (×4)
    101, --  ( 101 ) Nightmare Tiger (×4)
    102, --  ( 102 ) Nightmare Tiger (×5)
    103, --  ( 103 ) Nightmare Tiger (×5)
    104, --  ( 104 ) Nightmare Tiger (×5)
    105, --  ( 105 ) Nightmare Tiger (×5)
    106, --  ( 106 ) Nightmare Raptor (×2)
    107, --  ( 107 ) Nightmare Raptor (×2)
    108, --  ( 108 ) Nightmare Raptor (×2)
    109, --  ( 109 ) Nightmare Raptor (×2)
    110, --  ( 110 ) Nightmare Raptor (×2)
    111, --  ( 111 ) Nightmare Raptor (×2)
    112, --  ( 112 ) Nightmare Raptor (×2)
    113, --  ( 113 ) Nightmare Raptor (×2)
    114, --  ( 114 ) Nightmare Raptor (×2)
    115, --  ( 115 ) Nightmare Raptor (×2)
    116, --  ( 116 ) Nightmare Raptor (×2)
    117, --  ( 117 ) Nightmare Raptor (×2)
    118, --  ( 118 ) Nightmare Diremite (×2)
    119, --  ( 119 ) Nightmare Diremite (×2)
    120, --  ( 120 ) Nightmare Diremite (×2)
    121, --  ( 121 ) Nightmare Diremite (×2)
    122, --  ( 122 ) Nightmare Diremite (×2)
    123, --  ( 123 ) Nightmare Diremite (×2)
    124, --  ( 124 ) Nightmare Diremite (×2)
    125, --  ( 125 ) Nightmare Diremite (×2)
    126, --  ( 126 ) Nightmare Diremite (×2)
    127, --  ( 127 ) Nightmare Diremite (×2)
    128, --  ( 128 ) Nightmare Diremite (×2)
    129, --  ( 129 ) Nightmare Diremite (×2)
    130, --  ( 130 ) Nightmare Diremite (×2)
    131, --  ( 131 ) Nightmare Gaylas (×3)
    132, --  ( 132 ) Nightmare Gaylas (×3)
    133, --  ( 133 ) Nightmare Gaylas (×3)
    134, --  ( 134 ) Nightmare Gaylas (×4)
    135, --  ( 135 ) Nightmare Gaylas (×4)
    136, --  ( 136 ) Nightmare Gaylas (×4)
    137, --  ( 137 ) Nightmare Gaylas (×4)
    138, --  ( 138 ) Nightmare Gaylas (×4)
    65 , --  (065-G) Goblin Replica
    66 , --  (066-G) Goblin Replica
    67 , --  (067-G) Goblin Replica
    68 , --  (068-G) Goblin Replica
    69 , --  (069-G) Goblin Replica
    70 , --  (070-G) Goblin Replica
    71 , --  (071-G) Goblin Replica
    72 , --  (072-G) Goblin Replica
    73 , --  (073-G) Goblin Replica
    74 , --  (074-G) Goblin Replica
    75   --  (075-G) Goblin Replica
}

----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

-- Boss Area
xi.dynamis.mobList[zoneID][27 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }    -- 1 BST
xi.dynamis.mobList[zoneID][28 ].mobchildren = {   1, nil, nil,   1,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }    -- 1 WAR  1 BLM  1 RDM  1 PLD
xi.dynamis.mobList[zoneID][29 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }    -- 1 DRG
xi.dynamis.mobList[zoneID][30 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  }    -- 1 SMN
xi.dynamis.mobList[zoneID][31 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil,   1, nil, nil,   1,   1, nil, nil, nil  }    -- 1 WHM  1 DRK  1 RNG  1 SAM
-- Northeast
xi.dynamis.mobList[zoneID][16 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }    -- 1 MNK  1 WHM  1 NIN
xi.dynamis.mobList[zoneID][17 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }    -- 1 PLD
xi.dynamis.mobList[zoneID][18 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil  }    -- 1 BRD  1 DRG
xi.dynamis.mobList[zoneID][19 ].mobchildren = { nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }    -- 1 BLM  1 RDM
xi.dynamis.mobList[zoneID][20 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }    -- 1 DRK
xi.dynamis.mobList[zoneID][21 ].mobchildren = { nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1  }    -- 1 MNK  1 THF  1 SMN
xi.dynamis.mobList[zoneID][22 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }    -- 1 DRK
xi.dynamis.mobList[zoneID][24 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1,   1, nil, nil, nil  }    -- 1 WAR  1 BST  1 RNG  1 SAM
xi.dynamis.mobList[zoneID][25 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil,   1  }    -- 1 THF  1 BRD  1 SMN
xi.dynamis.mobList[zoneID][26 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil  }    -- 1 MNK  1 NIN  1 DRG
-- Sea Monk NM Area
xi.dynamis.mobList[zoneID][1  ].mobchildren = { nil,   1, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }    -- 1 MNK  1 BLM  1 THF
xi.dynamis.mobList[zoneID][2  ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }    -- 1 WAR  1 RDM  1 NIN
-- Southwest
xi.dynamis.mobList[zoneID][3  ].mobchildren = { nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  }    -- 1 WHM  1 PLD  1 SAM
xi.dynamis.mobList[zoneID][4  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil  }    -- 1 BST  1 RNG
xi.dynamis.mobList[zoneID][5  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1,   1, nil  }    -- 1 DRK  1 NIN  1 DRG
xi.dynamis.mobList[zoneID][6  ].mobchildren = { nil, nil, nil, nil,   1, nil,   1, nil,   1,   1,   1, nil, nil, nil, nil  }    -- 1 RDM  1 PLD  1 BST  1 BRD  1 RNG
xi.dynamis.mobList[zoneID][7  ].mobchildren = {   1, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  }    -- 1 WAR  1 WHM  1 BLM  1 SMN
xi.dynamis.mobList[zoneID][8  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil  }    -- 1 DRK  1 SAM
xi.dynamis.mobList[zoneID][9  ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil  }    -- 1 WAR  1 RDM  1 BRD  1 RNG
xi.dynamis.mobList[zoneID][10 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  }    -- 1 SMN
xi.dynamis.mobList[zoneID][11 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil  }    -- 1 BST  1 NIN
xi.dynamis.mobList[zoneID][13 ].mobchildren = { nil,   1,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }    -- 1 MNK  1 WHM  1 THF
xi.dynamis.mobList[zoneID][14 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }    -- 1 DRG
xi.dynamis.mobList[zoneID][15 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  }    -- 1 BLM  1 PLD  1 SAM
-- Golem NM Area
xi.dynamis.mobList[zoneID][32 ].mobchildren = { nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1  }    -- 1 RDM  1 THF  1 SMN
xi.dynamis.mobList[zoneID][33 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1,   1, nil  }    -- 1 BRD  1 NIN  1 DRG
-- Giant Bat NM Area
xi.dynamis.mobList[zoneID][36 ].mobchildren = {   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }    -- 1 WAR  1 BLM  1 BST
xi.dynamis.mobList[zoneID][37 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil  }    -- 1 WHM  1 DRK  1 RNG
-- Wave 2 based on https://enedin.be/dyna/html/zone/frame_quf2.htm
-- Southwest
xi.dynamis.mobList[zoneID][65 ].mobchildren = { nil,   1, nil, nil, nil,   1, nil, nil, nil,   1,   1, nil, nil, nil, nil  }    -- 1 MNK  1 THF  1 BRD  1 RNG
xi.dynamis.mobList[zoneID][66 ].mobchildren = { nil,   1,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1  }    -- 1 MNK  1 WHM  1 PLD  1 SMN
xi.dynamis.mobList[zoneID][67 ].mobchildren = {   1,   1, nil,   1,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }    -- 1 WAR  1 MNK  1 BLM  1 RDM  1 SAM
xi.dynamis.mobList[zoneID][68 ].mobchildren = { nil, nil,   1, nil, nil, nil,   1,   1,   1, nil, nil, nil, nil, nil, nil  }    -- 1 WHM  1 PLD  1 DRK  1 BST
-- Northeast
xi.dynamis.mobList[zoneID][69 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil,   1, nil,   1, nil  }    -- 1 THF  1 BRD  1 SAM  1 DRG
xi.dynamis.mobList[zoneID][70 ].mobchildren = {   1, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }    -- 1 WAR  1 BLM  1 RDM  1 NIN

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].nmchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

-- Wave 1
xi.dynamis.mobList[zoneID][64 ].nmchildren = { true, 28, 29, 30, 31        } -- ( 064 ) Gigas NM (Antaeus) (Spawns 065-138)
xi.dynamis.mobList[zoneID][51 ].nmchildren = { true, 244, 245, 246         } -- ( 051 ) Nightmare Stirge (×4)
xi.dynamis.mobList[zoneID][52 ].nmchildren = { true, 247, 248, 249         } -- ( 052 ) Nightmare Stirge (×4)
xi.dynamis.mobList[zoneID][53 ].nmchildren = { true, 250, 251, 252         } -- ( 053 ) Nightmare Stirge (×4)
xi.dynamis.mobList[zoneID][62 ].nmchildren = { true, 253, 254              } -- ( 062 ) Nightmare Stirge (×3)
xi.dynamis.mobList[zoneID][63 ].nmchildren = { true, 255, 256, 257         } -- ( 063 ) Nightmare Stirge (×4)
xi.dynamis.mobList[zoneID][61 ].nmchildren = { true, 260, 261              } -- ( 061 ) Nightmare Roc (×3)
xi.dynamis.mobList[zoneID][58 ].nmchildren = { true, 258, 259              } -- ( 058 ) Nightmare Roc (×3)
xi.dynamis.mobList[zoneID][54 ].nmchildren = { true, 262, 263, 264         } -- ( 054 ) Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][55 ].nmchildren = { true, 265, 266, 267         } -- ( 055 ) Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][56 ].nmchildren = { true, 268, 269, 270         } -- ( 056 ) Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][57 ].nmchildren = { true, 271, 272, 273         } -- ( 057 ) Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][59 ].nmchildren = { true, 274, 275, 276         } -- ( 059 ) Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][60 ].nmchildren = { true, 277, 278, 279         } -- ( 060 ) Nightmare Snoll (×4)

-- Wave 2nmchildren
xi.dynamis.mobList[zoneID][76 ].nmchildren = { true, 139, 140              } -- ( 076 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][77 ].nmchildren = { true, 141, 142              } -- ( 077 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][78 ].nmchildren = { true, 143, 144              } -- ( 078 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][79 ].nmchildren = { true, 145, 146              } -- ( 079 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][80 ].nmchildren = { true, 147, 148              } -- ( 080 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][81 ].nmchildren = { true, 149, 150              } -- ( 081 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][82 ].nmchildren = { true, 151, 152              } -- ( 082 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][83 ].nmchildren = { true, 153, 154              } -- ( 083 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][84 ].nmchildren = { true, 155, 156              } -- ( 084 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][85 ].nmchildren = { true, 157, 158              } -- ( 085 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][86 ].nmchildren = { true, 159                   } -- ( 086 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][87 ].nmchildren = { true, 160                   } -- ( 087 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][88 ].nmchildren = { true, 161                   } -- ( 088 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][89 ].nmchildren = { true, 162                   } -- ( 089 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][90 ].nmchildren = { true, 163                   } -- ( 090 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][91 ].nmchildren = { true, 164                   } -- ( 091 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][92 ].nmchildren = { true, 165                   } -- ( 092 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][93 ].nmchildren = { true, 166                   } -- ( 093 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][94 ].nmchildren = { true, 167                   } -- ( 094 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][95 ].nmchildren = { true, 168                   } -- ( 095 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][96 ].nmchildren = { true, 169                   } -- ( 096 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][97 ].nmchildren = { true, 170                   } -- ( 097 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][98 ].nmchildren = { true, 171, 172              } -- ( 098 ) Nightmare Kraken (×3)
xi.dynamis.mobList[zoneID][99 ].nmchildren = { true, 173, 174, 175         } -- ( 099 ) Nightmare Tiger (×4)
xi.dynamis.mobList[zoneID][100].nmchildren = { true, 176, 177, 178         } -- ( 100 ) Nightmare Tiger (×4)
xi.dynamis.mobList[zoneID][101].nmchildren = { true, 179, 180, 181         } -- ( 101 ) Nightmare Tiger (×4)
xi.dynamis.mobList[zoneID][102].nmchildren = { true, 182, 183, 184, 185    } -- ( 102 ) Nightmare Tiger (×5)
xi.dynamis.mobList[zoneID][103].nmchildren = { true, 186, 187, 188, 189    } -- ( 103 ) Nightmare Tiger (×5)
xi.dynamis.mobList[zoneID][104].nmchildren = { true, 190, 191, 192, 193    } -- ( 104 ) Nightmare Tiger (×5)
xi.dynamis.mobList[zoneID][105].nmchildren = { true, 194, 195, 196, 197    } -- ( 105 ) Nightmare Tiger (×5)
xi.dynamis.mobList[zoneID][106].nmchildren = { true, 198                   } -- ( 106 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][107].nmchildren = { true, 199                   } -- ( 107 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][108].nmchildren = { true, 200                   } -- ( 108 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][109].nmchildren = { true, 201                   } -- ( 109 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][110].nmchildren = { true, 202                   } -- ( 110 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][111].nmchildren = { true, 203                   } -- ( 111 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][112].nmchildren = { true, 204                   } -- ( 112 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][113].nmchildren = { true, 205                   } -- ( 113 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][114].nmchildren = { true, 206                   } -- ( 114 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][115].nmchildren = { true, 207                   } -- ( 115 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][116].nmchildren = { true, 208                   } -- ( 116 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][117].nmchildren = { true, 209                   } -- ( 117 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][118].nmchildren = { true, 210                   } -- ( 118 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][119].nmchildren = { true, 211                   } -- ( 119 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][120].nmchildren = { true, 212                   } -- ( 120 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][121].nmchildren = { true, 213                   } -- ( 121 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][122].nmchildren = { true, 214                   } -- ( 122 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][123].nmchildren = { true, 215                   } -- ( 123 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][124].nmchildren = { true, 216                   } -- ( 124 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][125].nmchildren = { true, 217                   } -- ( 125 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][126].nmchildren = { true, 218                   } -- ( 126 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][127].nmchildren = { true, 219                   } -- ( 127 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][128].nmchildren = { true, 220                   } -- ( 128 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][129].nmchildren = { true, 221                   } -- ( 129 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][130].nmchildren = { true, 222                   } -- ( 130 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][131].nmchildren = { true, 223, 224              } -- ( 131 ) Nightmare Gaylas (×3)
xi.dynamis.mobList[zoneID][132].nmchildren = { true, 225, 226              } -- ( 132 ) Nightmare Gaylas (×3)
xi.dynamis.mobList[zoneID][133].nmchildren = { true, 227, 228              } -- ( 133 ) Nightmare Gaylas (×3)
xi.dynamis.mobList[zoneID][134].nmchildren = { true, 229, 230, 231         } -- ( 134 ) Nightmare Gaylas (×4)
xi.dynamis.mobList[zoneID][135].nmchildren = { true, 232, 233, 234         } -- ( 135 ) Nightmare Gaylas (×4)
xi.dynamis.mobList[zoneID][136].nmchildren = { true, 235, 236, 237         } -- ( 136 ) Nightmare Gaylas (×4)
xi.dynamis.mobList[zoneID][137].nmchildren = { true, 238, 239, 240         } -- ( 137 ) Nightmare Gaylas (×4)
xi.dynamis.mobList[zoneID][138].nmchildren = { true, 241, 242, 243         } -- ( 138 ) Nightmare Gaylas (×4)

------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].pos = {xpos, ypos, zpos, rot}

-- Statues Wave 1 and Wave 2
xi.dynamis.mobList[zoneID][1  ].pos = { -260.608, -19.032, 43.783, 6    } -- (001-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][2  ].pos = { -249.283, -19.988, 45.831, 6    } -- (002-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][3  ].pos = { -207.631, -19.944, 106.263, 28  } -- (003-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][4  ].pos = { -193.663, -19.635, 131.329, 68  } -- (004-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][5  ].pos = { -205.758, -20.089, 162.879, 203 } -- (005-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][6  ].pos = { -118.681, -20.019, 195.651, 27   } -- (006-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][7  ].pos = { -116.667, -19.829, 207.454, 48  } -- (007-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][8  ].pos = { -1.307, -19.138, -17.269, 129   } -- (008-Y) Manifest Icon
xi.dynamis.mobList[zoneID][9  ].pos = { 13.437, -20.824, -21.301, 128   } -- (009-Y) Manifest Icon
xi.dynamis.mobList[zoneID][10 ].pos = { 37.826, -19.383, -14.216, 237   } -- (010-Y) Manifest Icon
xi.dynamis.mobList[zoneID][11 ].pos = { 60.955, -19.612, 11.245, 81     } -- (011-Y) Manifest Icon
xi.dynamis.mobList[zoneID][12 ].pos = { 81.461, -19.891, 6.198, 107     } -- (012-Y) Manifest Icon
xi.dynamis.mobList[zoneID][13 ].pos = { 93.956, -20.051, -14.926, 137   } -- (013-Y) Manifest Icon
xi.dynamis.mobList[zoneID][14 ].pos = { 109.566, -19.994, -6.029, 113   } -- (014-Y) Manifest Icon
xi.dynamis.mobList[zoneID][15 ].pos = { 121.584, -20.000, 0.963, 180    } -- (015-Y) Manifest Icon
xi.dynamis.mobList[zoneID][16 ].pos = { 140.120, -19.025, 75.671, 154   } -- (016-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][17 ].pos = { 138.601, -19.895, 65.463, 165   } -- (017-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][18 ].pos = { 151.705, -19.830, 68.108, 146   } -- (018-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][19 ].pos = { 101.349, -20.176, 150.119, 38   } -- (019-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][20 ].pos = { 111.338, -19.739, 150.965, 48   } -- (020-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][21 ].pos = { 55.335, -19.323, 234.979, 79    } -- (021-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][22 ].pos = { 56.364, -20.275, 249.147, 44    } -- (022-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][23 ].pos = { 0.556, -20.427, 242.431, 50     } -- (023-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][24 ].pos = { 1.133, -19.029, 260.556, 129    } -- (024-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][25 ].pos = { -91.348, -19.634, 242.081, 171  } -- (025-G) Goblin Replica
xi.dynamis.mobList[zoneID][26 ].pos = { -85.062, -19.723, 267.683, 91   } -- (026-G) Goblin Replica
xi.dynamis.mobList[zoneID][27 ].pos = { -216.469, -19.178, 319.638, 255 } -- (027-G) Goblin Replica
xi.dynamis.mobList[zoneID][28 ].pos = { -254.048, -20.000, 300.553, 224 } -- (028-G) Goblin Replica
xi.dynamis.mobList[zoneID][29 ].pos = { -256.694, -20.000, 313.411, 231 } -- (029-G) Goblin Replica
xi.dynamis.mobList[zoneID][30 ].pos = { -253.725, -20.000, 329.286, 9   } -- (030-G) Goblin Replica
xi.dynamis.mobList[zoneID][31 ].pos = { -250.551, -19.933, 341.246, 43  } -- (031-G) Goblin Replica
xi.dynamis.mobList[zoneID][32 ].pos = { -288.097, -11.721, 475.140, 225 } -- (032-G) Goblin Replica
xi.dynamis.mobList[zoneID][33 ].pos = { -312.791, -11.762, 483.752, 247 } -- (033-G) Goblin Replica
xi.dynamis.mobList[zoneID][34 ].pos = { -546.876, -8.836, 416.088, 8    } -- (034-G) Goblin Replica
xi.dynamis.mobList[zoneID][35 ].pos = { -550.221, -7.494, 422.123, 13   } -- (035-G) Goblin Replica
xi.dynamis.mobList[zoneID][36 ].pos = { 174.031, 20.747, -202.030, 204  } -- (036-G) Goblin Replica
xi.dynamis.mobList[zoneID][37 ].pos = { 163.990, 20.081, -208.679, 232  } -- (037-G) Goblin Replica
xi.dynamis.mobList[zoneID][38 ].pos = { 140.386, 17.982, -431.949, 214  } -- (038-G) Goblin Replica
xi.dynamis.mobList[zoneID][39 ].pos = { 142.936, 18.121, -436.945, 196  } -- (039-G) Goblin Replica
xi.dynamis.mobList[zoneID][65 ].pos = { -108.072, -20.30, 191.006, 154  } -- (065-G) Goblin Replica
xi.dynamis.mobList[zoneID][66 ].pos = { -112.225, -20.560, 188.736, 160 } -- (066-G) Goblin Replica
xi.dynamis.mobList[zoneID][67 ].pos = { -77.407, -19.770, 19.093, 134   } -- (067-G) Goblin Replica
xi.dynamis.mobList[zoneID][68 ].pos = { -59.591, -19.733, -2.097, 34    } -- (068-G) Goblin Replica
xi.dynamis.mobList[zoneID][69 ].pos = { 21.350, -19.769, 187.950, 155   } -- (069-G) Goblin Replica
xi.dynamis.mobList[zoneID][70 ].pos = { -2.647, -20.584, 191.007, 239   } -- (070-G) Goblin Replica
xi.dynamis.mobList[zoneID][71 ].pos = { -44.788, -20.040, 122.724, 162  } -- (071-G) Goblin Replica
xi.dynamis.mobList[zoneID][72 ].pos = { -45.871, -20.082, 75.716, 94    } -- (072-G) Goblin Replica
xi.dynamis.mobList[zoneID][73 ].pos = { 5.245, -20.007, 125.149, 223    } -- (073-G) Goblin Replica
xi.dynamis.mobList[zoneID][74 ].pos = { -7.265, -18.019, 101.000, 9     } -- (074-G) Goblin Replica
xi.dynamis.mobList[zoneID][75 ].pos = { -18.812, -17.300, 104.154, 9    } -- (075-G) Goblin Replica
-- Wave 1 Nightmare Mobs + NMs + Elementals Based on https://enedin.be/dyna/html/zone/frame_quf1.htm
xi.dynamis.mobList[zoneID][51 ].pos = { -61.614, -19.824, 36.806, 64    } -- ( 051 ) Nightmare Stirge (×4)
xi.dynamis.mobList[zoneID][52 ].pos = { 21.479, -19.832, 153.201, 79    } -- ( 052 ) Nightmare Stirge (×4)
xi.dynamis.mobList[zoneID][53 ].pos = { -60.969, -19.775, 153.545, 54   } -- ( 053 ) Nightmare Stirge (×4)
xi.dynamis.mobList[zoneID][62 ].pos = { 143.273, 21.394, -348.023, 144  } -- ( 062 ) Nightmare Stirge (×3)
xi.dynamis.mobList[zoneID][63 ].pos = { 153.181, 20.601, -370.837, 193  } -- ( 063 ) Nightmare Stirge (×4)
xi.dynamis.mobList[zoneID][63 ].pos = { 153.181, 20.601, -370.837, 193  } -- ( 063 ) Nightmare Stirge (×4)
xi.dynamis.mobList[zoneID][61 ].pos = { 153.580, -19.718, -20.217, 128  } -- ( 061 ) Nightmare Roc (×3)
xi.dynamis.mobList[zoneID][58 ].pos = { -221.369, -19.805, 437.399, 56  } -- ( 058 ) Nightmare Roc (×3)
xi.dynamis.mobList[zoneID][54 ].pos = { -136.073, -20.377, 344.4214, 102} -- ( 054 ) Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][55 ].pos = { -132.776, -19.527, 320.005, 118 } -- ( 055 ) Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][56 ].pos = { -156.819, -20.000, 362.471, 98  } -- ( 056 ) Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][57 ].pos = { -157.837, -19.317, 334.877, 115 } -- ( 057 ) Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][59 ].pos = { -475.226, -11.232, 385.530, 207 } -- ( 059 ) Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][60 ].pos = { -496.717, -12.481, 379.136, 236 } -- ( 060 ) Nightmare Snoll (×4)
xi.dynamis.mobList[zoneID][40 ].pos = { -264.477, -3.417, 24.961, 60    } -- ( 040 ) Scolopendra
xi.dynamis.mobList[zoneID][41 ].pos = { 149.787, 21.221, -409.158, 185  } -- ( 041 ) Stringes
xi.dynamis.mobList[zoneID][64 ].pos = { -257.040, -20.000, 319.628, 254 } -- ( 064 ) Antaeus
xi.dynamis.mobList[zoneID][42 ].pos = { -535.544, -13.042, 386.895, 51  } -- ( 042 ) Suttung
xi.dynamis.mobList[zoneID][43 ].pos = { -278.296, -19.902, 74.020, 57   } -- ( 043 ) Water Elemental
xi.dynamis.mobList[zoneID][44 ].pos = { 19.150, -19.260, -86.259, 193   } -- ( 044 ) Fire Elemental
xi.dynamis.mobList[zoneID][45 ].pos = { 158.148, 20.219, -230.048, 184  } -- ( 045 ) Thunder Elemental
xi.dynamis.mobList[zoneID][46 ].pos = { 163.632, -19.481, 133.232, 94   } -- ( 046 ) Air Elemental
xi.dynamis.mobList[zoneID][47 ].pos = { 29.825, -19.906, 288.771, 77    } -- ( 047 ) Light Elemental
xi.dynamis.mobList[zoneID][48 ].pos = { -214.001, -19.742, 392.671, 60  } -- ( 048 ) Ice Elemental
xi.dynamis.mobList[zoneID][49 ].pos = { -338.197, -12.949, 531.737, 70  } -- ( 049 ) Earth Elemental
xi.dynamis.mobList[zoneID][50 ].pos = { -428.031, -12.956, 337.849, 136 } -- ( 050 ) Dark Elemental
-- Wave 2 Nightmare Mobs Based on https://enedin.be/dyna/html/zone/frame_quf2.htm
xi.dynamis.mobList[zoneID][76 ].pos = { -121.628, -19.756, 208.912, 96  } -- ( 076 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][77 ].pos = { -134.926, -19.311, 196.783, 161 } -- ( 077 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][78 ].pos = { -146.120, -20.016, 210.193, 132 } -- ( 078 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][79 ].pos = { -130.309, -19.514, 223.921, 94  } -- ( 079 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][80 ].pos = { -152.466, -19.784, 228.106, 80  } -- ( 080 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][81 ].pos = { -180.295, -19.421, 234.489, 124 } -- ( 081 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][82 ].pos = { -179.492, -19.027, 202.111, 128 } -- ( 082 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][83 ].pos = { -204.581, -19.972, 196.347, 177 } -- ( 083 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][84 ].pos = { -232.019, -19.347, 217.225, 225 } -- ( 084 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][85 ].pos = { -223.150, -19.996, 252.186, 131 } -- ( 085 ) Nightmare Weapon (×3)
xi.dynamis.mobList[zoneID][86 ].pos = { -218.359, -19.083, 38.272, 239  } -- ( 086 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][87 ].pos = { -243.159, -20.207, 27.225, 198  } -- ( 087 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][88 ].pos = { -250.003, -20.170, 47.660, 69   } -- ( 088 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][89 ].pos = { -265.529, -19.342, 39.694, 8    } -- ( 089 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][90 ].pos = { -276.600, -19.065, 61.284, 83   } -- ( 090 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][91 ].pos = { -294.936, -20.308, 50.588, 29   } -- ( 091 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][92 ].pos = { -282.784, -19.906, 23.687, 238  } -- ( 092 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][93 ].pos = { -277.102, -20.299, 87.588, 87   } -- ( 093 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][94 ].pos = { -311.925, -19.710, 58.419, 10   } -- ( 094 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][95 ].pos = { -332.640, -20.770, 56.555, 26   } -- ( 095 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][96 ].pos = { -341.548, -20.000, 40.281, 235  } -- ( 096 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][97 ].pos = { -304.406, -13.677, 26.310, 162  } -- ( 097 ) Nightmare Kraken (×2)
xi.dynamis.mobList[zoneID][98 ].pos = { -287.617, -6.243, 14.683, 150   } -- ( 098 ) Nightmare Kraken (×3)
xi.dynamis.mobList[zoneID][99 ].pos = { -5.263, -19.257, -17.494, 134   } -- ( 099 ) Nightmare Tiger (×4)
xi.dynamis.mobList[zoneID][100].pos = { 9.803, -19.711, 2.171, 83       } -- ( 100 ) Nightmare Tiger (×4)
xi.dynamis.mobList[zoneID][101].pos = { 16.809, -19.160, -37.493, 160   } -- ( 101 ) Nightmare Tiger (×4)
xi.dynamis.mobList[zoneID][102].pos = { 31.847, -19.619, -23.678, 129   } -- ( 102 ) Nightmare Tiger (×5)
xi.dynamis.mobList[zoneID][103].pos = { 26.496, -19.454, 2.021, 98      } -- ( 103 ) Nightmare Tiger (×5)
xi.dynamis.mobList[zoneID][104].pos = { 42.812, -19.072, -18.570, 125   } -- ( 104 ) Nightmare Tiger (×5)
xi.dynamis.mobList[zoneID][105].pos = { 42.515, -20.000, -43.731, 152   } -- ( 105 ) Nightmare Tiger (×5)
xi.dynamis.mobList[zoneID][106].pos = { 130.669, -19.668, 82.273, 117   } -- ( 106 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][107].pos = { 148.374, -19.620, 76.792, 122   } -- ( 107 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][108].pos = { 160.662, -19.133, 97.363, 111   } -- ( 108 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][109].pos = { 145.314, -19.913, 105.753, 129  } -- ( 109 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][110].pos = { 123.742, -19.506, 107.013, 90   } -- ( 110 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][111].pos = { 119.467, -20.012, 123.786, 77   } -- ( 111 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][112].pos = { 139.221, -19.040, 121.758, 128  } -- ( 112 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][113].pos = { 157.073, -20.000, 120.170, 126  } -- ( 113 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][114].pos = { 162.310, -19.547, 147.419, 96   } -- ( 114 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][115].pos = { 146.681, -19.473, 160.135, 96   } -- ( 115 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][116].pos = { 123.247, -19.623, 148.440, 78   } -- ( 116 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][117].pos = { 196.789, -20.000, 119.545, 127  } -- ( 117 ) Nightmare Raptor (×2)
xi.dynamis.mobList[zoneID][118].pos = { -270.470, -10.747, 487.465, 231 } -- ( 118 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][119].pos = { -275.038, -11.989, 471.655, 162 } -- ( 119 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][120].pos = { -284.911, -12.086, 484.757, 245 } -- ( 120 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][121].pos = { -296.533, -11.751, 491.319, 54  } -- ( 121 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][122].pos = { -300.984, -11.000, 478.629, 248 } -- ( 122 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][123].pos = { -298.767, -12.114, 463.578, 218 } -- ( 123 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][124].pos = { -308.469, -12.394, 456.989, 202 } -- ( 124 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][125].pos = { -320.408, -12.000, 472.749, 7   } -- ( 125 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][126].pos = { -332.928, -12.946, 467.776, 207 } -- ( 126 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][127].pos = { -316.672, -11.611, 450.671, 221 } -- ( 127 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][128].pos = { -318.770, -11.912, 428.749, 215 } -- ( 128 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][129].pos = { -332.708, -11.348, 443.779, 234 } -- ( 129 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][130].pos = { -358.722, -12.000, 442.357, 2   } -- ( 130 ) Nightmare Diremite (×2)
xi.dynamis.mobList[zoneID][131].pos = { 255.054, -9.825, -20.566, 157   } -- ( 131 ) Nightmare Gaylas (×3)
xi.dynamis.mobList[zoneID][132].pos = { 209.686, 21.250, -150.013, 232  } -- ( 132 ) Nightmare Gaylas (×3)
xi.dynamis.mobList[zoneID][133].pos = { 191.926, 20.154, -154.146, 32   } -- ( 133 ) Nightmare Gaylas (×3)
xi.dynamis.mobList[zoneID][134].pos = { 198.768, 20.933, -175.515, 216  } -- ( 134 ) Nightmare Gaylas (×4)
xi.dynamis.mobList[zoneID][135].pos = { 185.369, 20.750, -195.772, 193  } -- ( 135 ) Nightmare Gaylas (×4)
xi.dynamis.mobList[zoneID][136].pos = { 162.382, 20.186, -194.457, 241  } -- ( 136 ) Nightmare Gaylas (×4)
xi.dynamis.mobList[zoneID][137].pos = { 153.565, 20.512, -214.524, 219  } -- ( 137 ) Nightmare Gaylas (×4)
xi.dynamis.mobList[zoneID][138].pos = { 165.904, 20.263, -235.467, 209  } -- ( 138 ) Nightmare Gaylas (×4)

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
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eye.BLUE -- Flags for blue eyes. (HP)
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eye.GREEN -- Flags for green eyes. (MP)

xi.dynamis.mobList[zoneID][25].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][26].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][27].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][34].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][35].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][72].eyes = xi.dynamis.eye.BLUE

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].timeExtension = 15

xi.dynamis.mobList[zoneID].timeExtensionList = {64}
xi.dynamis.mobList[zoneID][64].timeExtension = 60
