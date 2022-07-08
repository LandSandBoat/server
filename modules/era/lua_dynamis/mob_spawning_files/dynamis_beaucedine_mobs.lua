----------------------------------------------------------------------------------------------------
--                                      Dynamis-Beaucedine                                        --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/bea.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/bcd.html        --
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
local zoneID = xi.zone.DYNAMIS_BEAUCEDINE
local i = 1
xi = xi or {} -- Ignore me I just set the global.
xi.dynamis = xi.dynamis or {} -- Ignore me I just set the global.
xi.dynamis.mobList = xi.dynamis.mobList or { } -- Ignore me I just set the global.
xi.dynamis.mobList[zoneID] = { } -- Ignore me, I just start the table.
xi.dynamis.mobList[zoneID].nmchildren = { }
xi.dynamis.mobList[zoneID].mobchildren = { }
xi.dynamis.mobList[zoneID].maxWaves = 2 -- Put in number of max waves
xi.dynamis.mobList[zoneID].patrolPaths = { }

while i <= 227 do
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

xi.dynamis.mobList[zoneID][1  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (001-Q)
xi.dynamis.mobList[zoneID][2  ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (002-O)
xi.dynamis.mobList[zoneID][3  ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (003-Y)
xi.dynamis.mobList[zoneID][4  ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil} -- (004-G)
xi.dynamis.mobList[zoneID][5  ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (005-Y) (HP)
xi.dynamis.mobList[zoneID][6  ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (006-Q)
xi.dynamis.mobList[zoneID][7  ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (007-O)
xi.dynamis.mobList[zoneID][8  ].info = {"Statue", "Goblin Replica", "Goblin", nil, nil} -- (008-G) (MP)
xi.dynamis.mobList[zoneID][9  ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (009-Y)
xi.dynamis.mobList[zoneID][10 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (010-Y) (15)
xi.dynamis.mobList[zoneID][11 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (011-Y)
xi.dynamis.mobList[zoneID][12 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (012-Y) (MP)
xi.dynamis.mobList[zoneID][13 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (013-Y) (HP)
xi.dynamis.mobList[zoneID][14 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (014-Y)
xi.dynamis.mobList[zoneID][15 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (015-Y)
xi.dynamis.mobList[zoneID][16 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (016-Y)
xi.dynamis.mobList[zoneID][17 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (017-Y)
xi.dynamis.mobList[zoneID][18 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (018-Y) (HP)
xi.dynamis.mobList[zoneID][19 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (019-Y) (MP)
xi.dynamis.mobList[zoneID][20 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (020-Y) (15)
xi.dynamis.mobList[zoneID][21 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (021-Y)
xi.dynamis.mobList[zoneID][22 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (022-Y) (MP)
xi.dynamis.mobList[zoneID][23 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (023-Y) (HP)
xi.dynamis.mobList[zoneID][24 ].info = {"NM"    , "Dynamis Icon", "Yagudo", nil, nil} -- ( 024 )
xi.dynamis.mobList[zoneID][25 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (025-Y) (MP)
xi.dynamis.mobList[zoneID][26 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (026-Y)
xi.dynamis.mobList[zoneID][27 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (027-Y) (MP)
xi.dynamis.mobList[zoneID][28 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (028-Y) (HP)
xi.dynamis.mobList[zoneID][29 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (029-Y)
xi.dynamis.mobList[zoneID][30 ].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (030-Y) (HP)
xi.dynamis.mobList[zoneID][31 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (031-G) (15)
xi.dynamis.mobList[zoneID][32 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (032-G)
xi.dynamis.mobList[zoneID][33 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (033-G)
xi.dynamis.mobList[zoneID][34 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (034-G)
xi.dynamis.mobList[zoneID][35 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (035-G)
xi.dynamis.mobList[zoneID][36 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (036-G)
xi.dynamis.mobList[zoneID][37 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (037-G) (HP)
xi.dynamis.mobList[zoneID][38 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (038-G) (MP)
xi.dynamis.mobList[zoneID][39 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (039-G)
xi.dynamis.mobList[zoneID][40 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (040-G) (MP)
xi.dynamis.mobList[zoneID][41 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (041-G) (HP)
xi.dynamis.mobList[zoneID][42 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (042-G)
xi.dynamis.mobList[zoneID][43 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (043-G)
xi.dynamis.mobList[zoneID][44 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (044-G) (HP)
xi.dynamis.mobList[zoneID][45 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (045-G) (MP)
xi.dynamis.mobList[zoneID][46 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (046-G) (15)
xi.dynamis.mobList[zoneID][47 ].info = {"NM"    , "Dynamis Statue", "Goblin", nil, nil} -- ( 047 )
xi.dynamis.mobList[zoneID][48 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (048-G)
xi.dynamis.mobList[zoneID][49 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (049-G) (MP)
xi.dynamis.mobList[zoneID][50 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (050-G)
xi.dynamis.mobList[zoneID][51 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (051-G) (HP)
xi.dynamis.mobList[zoneID][52 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (052-G) (MP)
xi.dynamis.mobList[zoneID][53 ].info = {"Statue", "Goblin Statue", "Goblin", nil, nil} -- (053-G) (HP)
xi.dynamis.mobList[zoneID][54 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (054-Q)
xi.dynamis.mobList[zoneID][55 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (055-Q)
xi.dynamis.mobList[zoneID][56 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (056-Q) (HP)
xi.dynamis.mobList[zoneID][57 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (057-Q) (MP)
xi.dynamis.mobList[zoneID][58 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (058-Q)
xi.dynamis.mobList[zoneID][59 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (059-Q) (HP)
xi.dynamis.mobList[zoneID][60 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (060-Q)
xi.dynamis.mobList[zoneID][61 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (061-Q) (MP)
xi.dynamis.mobList[zoneID][62 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (062-Q)
xi.dynamis.mobList[zoneID][63 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (063-Q) (15)
xi.dynamis.mobList[zoneID][64 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (064-Q)
xi.dynamis.mobList[zoneID][65 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (065-Q) (HP)
xi.dynamis.mobList[zoneID][66 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (066-Q) (15)
xi.dynamis.mobList[zoneID][67 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (067-Q) (MP)
xi.dynamis.mobList[zoneID][68 ].info = {"NM"    , "Dynamis Effigy", "Quadav", nil, nil} -- ( 068 )
xi.dynamis.mobList[zoneID][69 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (069-Q)
xi.dynamis.mobList[zoneID][70 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (070-Q) (HP)
xi.dynamis.mobList[zoneID][71 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (071-Q)
xi.dynamis.mobList[zoneID][72 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (072-Q) (MP)
xi.dynamis.mobList[zoneID][73 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (073-Q)
xi.dynamis.mobList[zoneID][74 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (074-Q) (HP)
xi.dynamis.mobList[zoneID][75 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (075-Q)
xi.dynamis.mobList[zoneID][76 ].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (076-Q) (MP)
xi.dynamis.mobList[zoneID][77 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (077-O)
xi.dynamis.mobList[zoneID][78 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (078-O) (HP)
xi.dynamis.mobList[zoneID][79 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (079-O)
xi.dynamis.mobList[zoneID][80 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (080-O) (MP)
xi.dynamis.mobList[zoneID][81 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (081-O)
xi.dynamis.mobList[zoneID][82 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (082-O) (MP)
xi.dynamis.mobList[zoneID][83 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (083-O) (15)
xi.dynamis.mobList[zoneID][84 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (084-O) (HP)
xi.dynamis.mobList[zoneID][85 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (085-O)
xi.dynamis.mobList[zoneID][86 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (086-O) (HP)
xi.dynamis.mobList[zoneID][87 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (087-O) (15)
xi.dynamis.mobList[zoneID][88 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (088-O) (MP)
xi.dynamis.mobList[zoneID][89 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (089-O)
xi.dynamis.mobList[zoneID][90 ].info = {"NM"    , "Dynamis Tombstone", "Orc", nil, nil} -- ( 090 )
xi.dynamis.mobList[zoneID][91 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (091-O) (HP)
xi.dynamis.mobList[zoneID][92 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (092-O)
xi.dynamis.mobList[zoneID][93 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (093-O)
xi.dynamis.mobList[zoneID][94 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (094-O) (MP)
xi.dynamis.mobList[zoneID][95 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (095-O) (HP)
xi.dynamis.mobList[zoneID][96 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (096-O)
xi.dynamis.mobList[zoneID][97 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (097-O)
xi.dynamis.mobList[zoneID][98 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (098-O) (MP)
xi.dynamis.mobList[zoneID][99 ].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (099-O)
xi.dynamis.mobList[zoneID][100].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (100-Q)
xi.dynamis.mobList[zoneID][101].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (101-Y)
xi.dynamis.mobList[zoneID][102].info = {"Statue", "Goblin Replica", "Goblin", nil, nil} -- (102-G)
xi.dynamis.mobList[zoneID][103].info = {"Statue", "Adamantking Effigy", "Quadav", nil, nil} -- (103-Q) (HP)
xi.dynamis.mobList[zoneID][104].info = {"Statue", "Goblin Replica", "Goblin", nil, nil} -- (104-G) (MP)
xi.dynamis.mobList[zoneID][105].info = {"Statue", "Serjeant Tombstone", "Orc", nil, nil} -- (105-O) (HP)
xi.dynamis.mobList[zoneID][106].info = {"Statue", "Avatar Icon", "Yagudo", nil, nil} -- (106-Y) (MP)
xi.dynamis.mobList[zoneID][107].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (107-H)
xi.dynamis.mobList[zoneID][108].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (108-H)
xi.dynamis.mobList[zoneID][109].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (109-H)
xi.dynamis.mobList[zoneID][110].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (110-H)
xi.dynamis.mobList[zoneID][111].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (111-H)
xi.dynamis.mobList[zoneID][112].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (112-H)
xi.dynamis.mobList[zoneID][113].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (113-H)
xi.dynamis.mobList[zoneID][114].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (114-H)
xi.dynamis.mobList[zoneID][115].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (115-H)
xi.dynamis.mobList[zoneID][116].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (116-H)
xi.dynamis.mobList[zoneID][117].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (117-H)
xi.dynamis.mobList[zoneID][118].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (118-H)
xi.dynamis.mobList[zoneID][119].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (119-H)
xi.dynamis.mobList[zoneID][120].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (120-H) (15)
xi.dynamis.mobList[zoneID][121].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (121-H)
xi.dynamis.mobList[zoneID][122].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (122-H)
xi.dynamis.mobList[zoneID][123].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (123-H)
xi.dynamis.mobList[zoneID][124].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (124-H)
xi.dynamis.mobList[zoneID][125].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (125-H)
xi.dynamis.mobList[zoneID][126].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (126-H)
xi.dynamis.mobList[zoneID][127].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (127-H)
xi.dynamis.mobList[zoneID][128].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (128-H)
xi.dynamis.mobList[zoneID][129].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (129-H)
xi.dynamis.mobList[zoneID][130].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (130-H)
xi.dynamis.mobList[zoneID][131].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (131-H)
xi.dynamis.mobList[zoneID][132].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (132-H)
xi.dynamis.mobList[zoneID][133].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (133-H)
xi.dynamis.mobList[zoneID][134].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (134-H)
xi.dynamis.mobList[zoneID][135].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (135-H)
xi.dynamis.mobList[zoneID][136].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (136-H)
xi.dynamis.mobList[zoneID][137].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (137-H)
xi.dynamis.mobList[zoneID][138].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (138-H)
xi.dynamis.mobList[zoneID][139].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (139-H)
xi.dynamis.mobList[zoneID][140].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (140-H)
xi.dynamis.mobList[zoneID][141].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (141-H)
xi.dynamis.mobList[zoneID][142].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (142-H)
xi.dynamis.mobList[zoneID][143].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (143-H)
xi.dynamis.mobList[zoneID][144].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (144-H)
xi.dynamis.mobList[zoneID][145].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (145-H)
xi.dynamis.mobList[zoneID][146].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (146-H)
xi.dynamis.mobList[zoneID][147].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (147-H) (15)
xi.dynamis.mobList[zoneID][148].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (148-H)
xi.dynamis.mobList[zoneID][149].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (149-H)
xi.dynamis.mobList[zoneID][150].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (150-H)
xi.dynamis.mobList[zoneID][151].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (151-H)
xi.dynamis.mobList[zoneID][152].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (152-H)
xi.dynamis.mobList[zoneID][153].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (153-H)
xi.dynamis.mobList[zoneID][154].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (154-H)
xi.dynamis.mobList[zoneID][155].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (155-H)
xi.dynamis.mobList[zoneID][156].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (156-H)
xi.dynamis.mobList[zoneID][157].info = {"Statue", "Vanguard Eye", nil, nil, "157_killed"} -- (157-H)
xi.dynamis.mobList[zoneID][158].info = {"NM", "Dagourmarche", "Hydra", nil, nil} -- ( 158 ) Attest. NM (Dagourmarche) (DRG+SMN+BST)
xi.dynamis.mobList[zoneID][159].info = {"NM", "Quiebitiel", "Hydra", nil, nil} -- ( 159 ) Attest. NM (Quiebitiel) (BLM+WHM+BRD)
xi.dynamis.mobList[zoneID][160].info = {"NM", "Goublefaupe", "Hydra", nil, nil} -- ( 160 ) Attest. NM (Goublefaupe) (RDM+PLD+WAR)
xi.dynamis.mobList[zoneID][161].info = {"NM", "Mildaunegeux", "Hydra", nil, nil} -- ( 161 ) Attest. NM (Mildaunegeux) (MNK+NIN+THF)
xi.dynamis.mobList[zoneID][162].info = {"NM", "Velosareon", "Hydra", nil, nil} -- ( 162 ) Attest. NM (Velosareon) (DRK+SAM+RNG)
xi.dynamis.mobList[zoneID][163].info = {"NM", "Angra Mainyu", "Hydra", nil, nil} -- ( 163 ) Ahriman NM (Angra Mainyu)
xi.dynamis.mobList[zoneID][164].info = {"NM", "Fire Pukis", nil, nil, nil} --   Fire Pukis
xi.dynamis.mobList[zoneID][165].info = {"NM", "Poison Pukis", nil, nil, nil} -- Poison Pukis
xi.dynamis.mobList[zoneID][166].info = {"NM", "Wind Pukis", nil, nil, nil} --   Wind Pukis
xi.dynamis.mobList[zoneID][167].info = {"NM", "Petro Pukis", nil, nil, nil} --  Petro Pukis
xi.dynamis.mobList[zoneID][168].info = {"NM", "Xaa Chau the Roctalon", "Yagudo", nil, nil} -- MNK
xi.dynamis.mobList[zoneID][169].info = {"NM", "Maa Zaua the Wyrmkeeper", "Yagudo", nil, nil} -- DRG
xi.dynamis.mobList[zoneID][170].info = {"NM", "Soo Jopo the Fiendking", "Yagudo", nil, nil} -- BST
xi.dynamis.mobList[zoneID][171].info = {"NM", "Hee Mida the Meticulous", "Yagudo", nil, nil} -- RNG
xi.dynamis.mobList[zoneID][172].info = {"NM", "Xhoo Fuza the Sublime", "Yagudo", nil, nil} -- BRD
xi.dynamis.mobList[zoneID][173].info = {"NM", "Puu Timu the Phantasmal", "Yagudo", nil, nil} -- SMN
xi.dynamis.mobList[zoneID][174].info = {"NM", "Foo Peku the Bloodcloak", "Yagudo", nil, nil} -- WAR
xi.dynamis.mobList[zoneID][175].info = {"NM", "Koo Saxu the Everfast", "Yagudo", nil, nil} -- WHM
xi.dynamis.mobList[zoneID][176].info = {"NM", "Kuu Xuka the Nimble", "Yagudo", nil, nil} -- NIN
xi.dynamis.mobList[zoneID][177].info = {"NM", "Guu Waji the Preacher", "Yagudo", nil, nil} -- PLD
xi.dynamis.mobList[zoneID][178].info = {"NM", "Nee Huxa the Judgemental", "Yagudo", nil, nil} -- DRK
xi.dynamis.mobList[zoneID][179].info = {"NM", "Caa Xaza the Madpiercer", "Yagudo", nil, nil} -- RDM
xi.dynamis.mobList[zoneID][180].info = {"NM", "Bhuu Wjato the Firepool", "Yagudo", nil, nil} -- BLM
xi.dynamis.mobList[zoneID][181].info = {"NM", "Droprix Granitepalms", "Goblin", nil, nil} -- MNK
xi.dynamis.mobList[zoneID][182].info = {"NM", "Ascetox Ratgums", "Goblin", nil, nil} -- BLM
xi.dynamis.mobList[zoneID][183].info = {"NM", "Bordox Kittyback", "Goblin", nil, nil} -- THF
xi.dynamis.mobList[zoneID][184].info = {"NM", "Draklix Scalecrust", "Goblin", nil, nil} -- DRG
xi.dynamis.mobList[zoneID][185].info = {"NM", "Swypestix Tigershins", "Goblin", nil, nil} -- NIN
xi.dynamis.mobList[zoneID][186].info = {"NM", "Shisox Widebrow", "Goblin", nil, nil} -- SAM
xi.dynamis.mobList[zoneID][187].info = {"NM", "Gibberox Pimplebeak", "Goblin", nil, nil} -- RDM
xi.dynamis.mobList[zoneID][188].info = {"NM", "Morblox Chubbychin", "Goblin", nil, nil} -- SMN
xi.dynamis.mobList[zoneID][189].info = {"NM", "Moltenox Stubthumbs", "Goblin", nil, nil} -- WAR
xi.dynamis.mobList[zoneID][190].info = {"NM", "Slinkix Trufflesniff", "Goblin", nil, nil} -- RNG
xi.dynamis.mobList[zoneID][191].info = {"NM", "Ruffbix Jumbolobes", "Goblin", nil, nil} -- PLD
xi.dynamis.mobList[zoneID][192].info = {"NM", "Routsix Rubbertendon", "Goblin", nil, nil} -- BST
xi.dynamis.mobList[zoneID][193].info = {"NM", "Whistix Toadthroat", "Goblin", nil, nil} -- BRD
xi.dynamis.mobList[zoneID][194].info = {"NM", "Ji'Fhu Infiltrator", "Quadav", nil, nil} -- THF
xi.dynamis.mobList[zoneID][195].info = {"NM", "Ta'Hyu Gallanthunter", "Quadav", nil, nil} -- DRK
xi.dynamis.mobList[zoneID][196].info = {"NM", "Mu'Gha Legionkiller", "Quadav", nil, nil} -- PLD
xi.dynamis.mobList[zoneID][197].info = {"NM", "Mi'Rhe Whisperblade", "Quadav", nil, nil} -- NIN
xi.dynamis.mobList[zoneID][198].info = {"NM", "Nu'Bhi Spiraleye", "Quadav", nil, nil} -- BRD
xi.dynamis.mobList[zoneID][199].info = {"NM", "Be'Zhe Keeprazer", "Quadav", nil, nil} -- SMN
xi.dynamis.mobList[zoneID][200].info = {"NM", "Na'Hya Floodmaker", "Quadav", nil, nil} -- RDM
xi.dynamis.mobList[zoneID][201].info = {"NM", "So'Zho Metalbender", "Quadav", nil, nil} -- MNK
xi.dynamis.mobList[zoneID][202].info = {"NM", "Ga'Fho Venomtouch", "Quadav", nil, nil} -- WHM
xi.dynamis.mobList[zoneID][203].info = {"NM", "De'Bho Pyrohand", "Quadav", nil, nil} -- BLM
xi.dynamis.mobList[zoneID][204].info = {"NM", "So'Gho Adderhandler", "Quadav", nil, nil} -- BST
xi.dynamis.mobList[zoneID][205].info = {"NM", "Go'Tyo Magenapper", "Quadav", nil, nil} -- DRG
xi.dynamis.mobList[zoneID][206].info = {"NM", "Ji'Khu Towercleaver", "Quadav", nil, nil} -- SAM
xi.dynamis.mobList[zoneID][207].info = {"NM", "Deathcaller Bidfbid", "Orc", nil, nil} -- SMN
xi.dynamis.mobList[zoneID][208].info = {"NM", "Taruroaster Biggsjig", "Orc", nil, nil} -- BLM
xi.dynamis.mobList[zoneID][209].info = {"NM", "Heavymail Djidzbad", "Orc", nil, nil} -- PLD
xi.dynamis.mobList[zoneID][210].info = {"NM", "Skinmask Ugghfogg", "Orc", nil, nil} -- DRK
xi.dynamis.mobList[zoneID][211].info = {"NM", "Lockbuster Zapdjipp", "Orc", nil, nil} -- THF
xi.dynamis.mobList[zoneID][212].info = {"NM", "Cobraclaw Buchzvotch", "Orc", nil, nil} -- MNK
xi.dynamis.mobList[zoneID][213].info = {"NM", "Galkarider Retzpratz", "Orc", nil, nil} -- RNG
xi.dynamis.mobList[zoneID][214].info = {"NM", "Drakefeast Wubmfub", "Orc", nil, nil} -- DRG
xi.dynamis.mobList[zoneID][215].info = {"NM", "Spinalsucker Galflmall", "Orc", nil, nil} -- RDM
xi.dynamis.mobList[zoneID][216].info = {"NM", "Elvaanlopper Grokdok", "Orc", nil, nil} -- SAM
xi.dynamis.mobList[zoneID][217].info = {"NM", "Humegutter Adzjbadj", "Orc", nil, nil} -- WAR
xi.dynamis.mobList[zoneID][218].info = {"NM", "Mithraslaver Debhabob", "Orc", nil, nil} -- BST
xi.dynamis.mobList[zoneID][219].info = {"NM", "Wraithdancer Gidbnod", "Orc", nil, nil} -- WHM
xi.dynamis.mobList[zoneID][220].info = {"NM", "Gu'Nha Wallstormer", "Quadav", nil, nil} -- WAR
xi.dynamis.mobList[zoneID][221].info = {"NM", "Gu'Khu Dukesniper", "Quadav", nil, nil} -- RNG
xi.dynamis.mobList[zoneID][222].info = {"NM", "Brewnix Bittypupils", "Goblin", nil, nil} -- WHM
xi.dynamis.mobList[zoneID][223].info = {"NM", "Tocktix Thinlids", "Goblin", nil, nil} -- DRK
xi.dynamis.mobList[zoneID][224].info = {"NM", "Ultrasonic Zeknajak", "Orc", nil, nil} -- BRD
xi.dynamis.mobList[zoneID][225].info = {"NM", "Jeunoraider Gepkzip", "Orc", nil, nil} -- NIN
xi.dynamis.mobList[zoneID][226].info = {"NM", "Ryy Qihi the Idolrobber", "Yagudo", nil, nil} -- THF
xi.dynamis.mobList[zoneID][227].info = {"NM", "Knii Hoqo the Bisector", "Yagudo", nil, nil} -- SAM

----------------------------------------------------------------------------------------------------
--                                    Setup of Wave Spawning                                      --
----------------------------------------------------------------------------------------------------

---------------------------------------------
--           Wave Defeat Reqs.          --
--------------------------------------------
--xi.dynamis.mobList[zoneID].waveDefeatRequirements[2] = {zone:getLocalVar("MegaBoss_Killed") == 1}

xi.dynamis.mobList[zoneID].waveDefeatRequirements =
{
    { }, -- Do not touch this is wave 1
    {"157_killed"} -- Spawns paper NMs
}

------------------------------------------
--            Wave Spawning             --
-- Note: Wave 1 spawns at start.        --
------------------------------------------
--xi.dynamis.mobList[zoneID].wave# = { MobIndex#1, MobIndex#2, MobIndex#3 }

xi.dynamis.mobList[zoneID][1].wave =
{
    3  , -- (003-Y)   Avatar Icon
    1  , -- (001-Q)   Adamantking Effigy
    2  , -- (002-O)   Serjeant Tombstone
    4  , -- (004-G)   Goblin Replica
    7  , -- (007-O)   Serjeant Tombstone
    6  , -- (006-Q)   Adamantking Effigy
    5  , -- (005-Y)   Avatar Icon
    8  , -- (008-G)   Goblin Replica
    10 , -- (010-Y)   Avatar Icon
    9  , -- (009-Y)   Avatar Icon
    11 , -- (011-Y)   Avatar Icon
    13 , -- (013-Y)   Avatar Icon
    12 , -- (012-Y)   Avatar Icon
    15 , -- (015-Y)   Avatar Icon
    16 , -- (016-Y)   Avatar Icon
    17 , -- (017-Y)   Avatar Icon
    14 , -- (014-Y)   Avatar Icon
    18 , -- (018-Y)   Avatar Icon
    19 , -- (019-Y)   Avatar Icon
    20 , -- (020-Y)   Avatar Icon
    21 , -- (021-Y)   Avatar Icon
    23 , -- (023-Y)   Avatar Icon
    22 , -- (022-Y)   Avatar Icon
    28 , -- (028-Y)   Avatar Icon
    27 , -- (027-Y)   Avatar Icon
    29 , -- (029-Y)   Avatar Icon
    26 , -- (026-Y)   Avatar Icon
    30 , -- (030-Y)   Avatar Icon
    25 , -- (025-Y)   Avatar Icon
    24 , -- (024- )   Dynamis Icon
    31 , -- (031-G)   Goblin Statue
    33 , -- (033-G)   Goblin Statue
    32 , -- (032-G)   Goblin Statue
    34 , -- (034-G)   Goblin Statue
    35 , -- (035-G)   Goblin Statue
    36 , -- (036-G)   Goblin Statue
    37 , -- (037-G)   Goblin Statue
    38 , -- (038-G)   Goblin Statue
    48 , -- (048-G)   Goblin Statue
    50 , -- (050-G)   Goblin Statue
    51 , -- (051-G)   Goblin Statue
    49 , -- (049-G)   Goblin Statue
    52 , -- (052-G)   Goblin Statue
    53 , -- (053-G)   Goblin Statue
    47 , -- (047- )   Dynamis Statue
    39 , -- (039-G)   Goblin Statue
    41 , -- (041-G)   Goblin Statue
    40 , -- (040-G)   Goblin Statue
    43 , -- (043-G)   Goblin Statue
    42 , -- (042-G)   Goblin Statue
    44 , -- (044-G)   Goblin Statue
    45 , -- (045-G)   Goblin Statue
    46 , -- (046-G)   Goblin Statue
    56 , -- (056-Q)   Adamantking Effigy
    54 , -- (054-Q)   Adamantking Effigy
    55 , -- (055-Q)   Adamantking Effigy
    57 , -- (057-Q)   Adamantking Effigy
    68 , -- (068- )   Dynamis Effigy
    76 , -- (076-Q)   Adamantking Effigy
    75 , -- (075-Q)   Adamantking Effigy
    74 , -- (074-Q)   Adamantking Effigy
    73 , -- (073-Q)   Adamantking Effigy
    72 , -- (072-Q)   Adamantking Effigy
    71 , -- (071-Q)   Adamantking Effigy
    70 , -- (070-Q)   Adamantking Effigy
    69 , -- (069-Q)   Adamantking Effigy
    58 , -- (058-Q)   Adamantking Effigy
    59 , -- (059-Q)   Adamantking Effigy
    60 , -- (060-Q)   Adamantking Effigy
    61 , -- (061-Q)   Adamantking Effigy
    62 , -- (062-Q)   Adamantking Effigy
    63 , -- (063-Q)   Adamantking Effigy
    65 , -- (065-Q)   Adamantking Effigy
    64 , -- (064-Q)   Adamantking Effigy
    67 , -- (067-Q)   Adamantking Effigy
    66 , -- (066-Q)   Adamantking Effigy
    90 , -- (090- )   Dynamis Tombstone
    91 , -- (091-O)   Serjeant Tombstone
    92 , -- (092-O)   Serjeant Tombstone
    93 , -- (093-O)   Serjeant Tombstone
    94 , -- (094-O)   Serjeant Tombstone
    98 , -- (098-O)   Serjeant Tombstone
    97 , -- (097-O)   Serjeant Tombstone
    96 , -- (096-O)   Serjeant Tombstone
    95 , -- (095-O)   Serjeant Tombstone
    77 , -- (077-O)   Serjeant Tombstone
    78 , -- (078-O)   Serjeant Tombstone
    79 , -- (079-O)   Serjeant Tombstone
    80 , -- (080-O)   Serjeant Tombstone
    81 , -- (081-O)   Serjeant Tombstone
    84 , -- (084-O)   Serjeant Tombstone
    83 , -- (083-O)   Serjeant Tombstone
    82 , -- (082-O)   Serjeant Tombstone
    85 , -- (085-O)   Serjeant Tombstone
    86 , -- (086-O)   Serjeant Tombstone
    87 , -- (087-O)   Serjeant Tombstone
    88 , -- (088-O)   Serjeant Tombstone
    89 , -- (089-O)   Serjeant Tombstone
    99 , -- (099-O)   Serjeant Tombstone
    100, -- (100-Q)   Adanantking Effigy
    101, -- (101-Y)   Avatar Icon
    102, -- (102-G)   Goblin Replica
    103, -- (103-Q)   Adamantking Effigy
    104, -- (104-G)   Goblin Replica
    105, -- (105-O)   Serjeant Tombstone
    106, -- (106-Y)   Avatar Icon
    107, -- (107-H)   Vanguard Eye
    118, -- (118-H)   Vanguard Eye
    117, -- (117-H)   Vanguard Eye
    116, -- (116-H)   Vanguard Eye
    115, -- (115-H)   Vanguard Eye
    114, -- (114-H)   Vanguard Eye
    119, -- (119-H)   Vanguard Eye
    113, -- (113-H)   Vanguard Eye
    112, -- (112-H)   Vanguard Eye
    108, -- (108-H)   Vanguard Eye
    111, -- (111-H)   Vanguard Eye
    110, -- (110-H)   Vanguard Eye
    109, -- (109-H)   Vanguard Eye
    122, -- (122-H)   Vanguard Eye
    121, -- (121-H)   Vanguard Eye
    123, -- (123-H)   Vanguard Eye
    124, -- (124-H)   Vanguard Eye
    125, -- (125-H)   Vanguard Eye
    126, -- (126-H)   Vanguard Eye
    127, -- (127-H)   Vanguard Eye
    128, -- (128-H)   Vanguard Eye
    129, -- (129-H)   Vanguard Eye
    130, -- (130-H)   Vanguard Eye
    131, -- (131-H)   Vanguard Eye
    132, -- (132-H)   Vanguard Eye
    133, -- (133-H)   Vanguard Eye
    136, -- (136-H)   Vanguard Eye
    134, -- (134-H)   Vanguard Eye
    135, -- (135-H)   Vanguard Eye
    137, -- (137-H)   Vanguard Eye
    138, -- (138-H)   Vanguard Eye
    139, -- (139-H)   Vanguard Eye
    140, -- (140-H)   Vanguard Eye
    141, -- (141-H)   Vanguard Eye
    142, -- (142-H)   Vanguard Eye
    143, -- (143-H)   Vanguard Eye
    144, -- (144-H)   Vanguard Eye
    145, -- (145-H)   Vanguard Eye
    146, -- (146-H)   Vanguard Eye
    148, -- (148-H)   Vanguard Eye
    147, -- (147-H)   Vanguard Eye
    149, -- (149-H)   Vanguard Eye
    150, -- (150-H)   Vanguard Eye
    151, -- (151-H)   Vanguard Eye
    152, -- (152-H)   Vanguard Eye
    153, -- (153-H)   Vanguard Eye
    154, -- (154-H)   Vanguard Eye
    155, -- (155-H)   Vanguard Eye
    156, -- (156-H)   Vanguard Eye
    157, -- (157-H)   Vanguard Eye
    163  -- (163- )   Angra Mainyu
}

xi.dynamis.mobList[zoneID][2].wave =
{
    160, -- ( 160 ) Attest. NM (Goublefaupe)
    159, -- ( 159 ) Attest. NM (Quiebitiel)
    161, -- ( 161 ) Attest. NM (Mildaunegeux)
    162, -- ( 162 ) Attest. NM (Velosareon)
    158  -- ( 158 ) Attest. NM (Dagourmarche)
}

----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

xi.dynamis.mobList[zoneID][3  ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil  } --   1 THF  1 RNG
xi.dynamis.mobList[zoneID][1  ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } --   1 WHM  1 SAM
xi.dynamis.mobList[zoneID][2  ].mobchildren = {   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 WAR  1 BLM
xi.dynamis.mobList[zoneID][4  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil  } --   1 DRK  1 BRD
xi.dynamis.mobList[zoneID][7  ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  } --   1 MNK  1 DRG
xi.dynamis.mobList[zoneID][6  ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil  } --   1 PLD  1 BST
xi.dynamis.mobList[zoneID][5  ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } --   1 RDM  1 NIN
xi.dynamis.mobList[zoneID][8  ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1  } --   1 THF  1 SMN
xi.dynamis.mobList[zoneID][10 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } --   1 WHM  1 BRD
xi.dynamis.mobList[zoneID][9  ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 PLD
xi.dynamis.mobList[zoneID][11 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  } --   1 DRK
xi.dynamis.mobList[zoneID][13 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } --   1 WAR  1 BST
xi.dynamis.mobList[zoneID][12 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1  } --   1 SAM  1 SMN
xi.dynamis.mobList[zoneID][15 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 MNK
xi.dynamis.mobList[zoneID][16 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 RDM
xi.dynamis.mobList[zoneID][17 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  } --   1 DRK
xi.dynamis.mobList[zoneID][14 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 BLM
xi.dynamis.mobList[zoneID][18 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 PLD
xi.dynamis.mobList[zoneID][19 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 WAR
xi.dynamis.mobList[zoneID][20 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } --   1 NIN
xi.dynamis.mobList[zoneID][23 ].mobchildren = { nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 BLM  1 RDM
xi.dynamis.mobList[zoneID][22 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil  } --   1 RNG  1 NIN
xi.dynamis.mobList[zoneID][28 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } --   1 WHM  1 BST
xi.dynamis.mobList[zoneID][27 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1  } --   1 BRD  1 SMN
xi.dynamis.mobList[zoneID][29 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 PLD
xi.dynamis.mobList[zoneID][26 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 WAR
xi.dynamis.mobList[zoneID][30 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  } --   1 MNK  1 DRG
xi.dynamis.mobList[zoneID][25 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil  } --   1 THF  1 SAM
xi.dynamis.mobList[zoneID][31 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } --   1 BST
xi.dynamis.mobList[zoneID][33 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } --   1 WHM  1 RNG
xi.dynamis.mobList[zoneID][32 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } --   1 RDM  1 SAM
xi.dynamis.mobList[zoneID][34 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } --   1 NIN
xi.dynamis.mobList[zoneID][35 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 WAR
xi.dynamis.mobList[zoneID][36 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  } --   1 DRK
xi.dynamis.mobList[zoneID][37 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  } --   1 PLD  1 SAM
xi.dynamis.mobList[zoneID][38 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  } --   1 WHM  1 DRG
xi.dynamis.mobList[zoneID][48 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 BLM
xi.dynamis.mobList[zoneID][50 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 THF
xi.dynamis.mobList[zoneID][51 ].mobchildren = { nil,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 MNK  1 RDM
xi.dynamis.mobList[zoneID][49 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil  } --   1 DRK  1 NIN
xi.dynamis.mobList[zoneID][52 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } --   1 SAM
xi.dynamis.mobList[zoneID][53 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  } --   1 DRG
xi.dynamis.mobList[zoneID][39 ].mobchildren = {   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 WAR  1 WHM
xi.dynamis.mobList[zoneID][41 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 PLD
xi.dynamis.mobList[zoneID][40 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 BLM
xi.dynamis.mobList[zoneID][43 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } --   1 MNK  1 BRD
xi.dynamis.mobList[zoneID][42 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } --   1 RNG
xi.dynamis.mobList[zoneID][44 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1  } --   1 DRG  1 SMN
xi.dynamis.mobList[zoneID][45 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil  } --   1 PLD  1 BST
xi.dynamis.mobList[zoneID][46 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 THF
xi.dynamis.mobList[zoneID][56 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 WAR  1 RDM
xi.dynamis.mobList[zoneID][54 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } --   1 NIN
xi.dynamis.mobList[zoneID][55 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } --   1 RNG
xi.dynamis.mobList[zoneID][57 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil  } --   1 BRD  1 DRG
xi.dynamis.mobList[zoneID][76 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  } --   1 SMN
xi.dynamis.mobList[zoneID][75 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 WAR
xi.dynamis.mobList[zoneID][74 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } --   1 RDM  1 BRD
xi.dynamis.mobList[zoneID][73 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } --   1 RNG
xi.dynamis.mobList[zoneID][72 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } --   1 NIN
xi.dynamis.mobList[zoneID][71 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 PLD
xi.dynamis.mobList[zoneID][70 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil  } --   1 THF  1 DRK
xi.dynamis.mobList[zoneID][69 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 MNK
xi.dynamis.mobList[zoneID][58 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 BLM
xi.dynamis.mobList[zoneID][59 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  } --   1 DRK
xi.dynamis.mobList[zoneID][60 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } --   1 BST
xi.dynamis.mobList[zoneID][61 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 WAR
xi.dynamis.mobList[zoneID][62 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } --   1 SAM
xi.dynamis.mobList[zoneID][63 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil  } --   1 THF  1 RNG
xi.dynamis.mobList[zoneID][65 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  } --   1 MNK  1 SMN
xi.dynamis.mobList[zoneID][64 ].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 WHM  1 BLM
xi.dynamis.mobList[zoneID][67 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil  } --   1 BST  1 DRG
xi.dynamis.mobList[zoneID][66 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 WAR
xi.dynamis.mobList[zoneID][91 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 THF
xi.dynamis.mobList[zoneID][92 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } --   1 RNG
xi.dynamis.mobList[zoneID][93 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 BLM
xi.dynamis.mobList[zoneID][94 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil  } --   1 PLD  1 BRD
xi.dynamis.mobList[zoneID][98 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 MNK
xi.dynamis.mobList[zoneID][97 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  } --   1 DRK
xi.dynamis.mobList[zoneID][96 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } --   1 NIN
xi.dynamis.mobList[zoneID][95 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1  } --   1 THF  1 SMN
xi.dynamis.mobList[zoneID][77 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } --   1 WHM  1 RNG
xi.dynamis.mobList[zoneID][78 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil  } --   1 SAM  1 NIN
xi.dynamis.mobList[zoneID][79 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } --   1 BST
xi.dynamis.mobList[zoneID][80 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil  } --   1 PLD  1 BRD
xi.dynamis.mobList[zoneID][81 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 WAR  1 RDM
xi.dynamis.mobList[zoneID][84 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } --   1 RNG
xi.dynamis.mobList[zoneID][83 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 MNK
xi.dynamis.mobList[zoneID][82 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  } --   1 DRG
xi.dynamis.mobList[zoneID][85 ].mobchildren = { nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 WHM  1 RDM
xi.dynamis.mobList[zoneID][86 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  } --   1 SMN
xi.dynamis.mobList[zoneID][87 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } --   1 BST
xi.dynamis.mobList[zoneID][88 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } --   1 NIN
xi.dynamis.mobList[zoneID][89 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil  } --   1 DRK  1 SAM
xi.dynamis.mobList[zoneID][99 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 BLM
xi.dynamis.mobList[zoneID][100].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  } --   1 SMN
xi.dynamis.mobList[zoneID][101].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 RDM
xi.dynamis.mobList[zoneID][102].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 MNK
xi.dynamis.mobList[zoneID][107].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil  } --   1 MNK  1 BRD  1 RNG
xi.dynamis.mobList[zoneID][118].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 WHM
xi.dynamis.mobList[zoneID][117].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } --   1 BLM  1 NIN
xi.dynamis.mobList[zoneID][116].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil  } --   1 PLD  1 DRG
xi.dynamis.mobList[zoneID][115].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } --   1 WAR  1 RNG
xi.dynamis.mobList[zoneID][114].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } --   1 RDM  1 SAM
xi.dynamis.mobList[zoneID][119].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1  } --   1 THF  1 SMN
xi.dynamis.mobList[zoneID][113].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  } --   1 DRK
xi.dynamis.mobList[zoneID][112].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } --   1 WAR  1 BST
xi.dynamis.mobList[zoneID][108].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 MNK
xi.dynamis.mobList[zoneID][111].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } --   1 BST
xi.dynamis.mobList[zoneID][120].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  } --   1 WHM  1 SMN
xi.dynamis.mobList[zoneID][110].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 RDM
xi.dynamis.mobList[zoneID][109].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 THF
xi.dynamis.mobList[zoneID][122].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 BLM
xi.dynamis.mobList[zoneID][121].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  } --   1 DRG
xi.dynamis.mobList[zoneID][123].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  } --   1 DRK
xi.dynamis.mobList[zoneID][124].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 PLD
xi.dynamis.mobList[zoneID][125].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } --   1 WAR  1 BRD
xi.dynamis.mobList[zoneID][126].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 WHM
xi.dynamis.mobList[zoneID][127].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } --   1 BST
xi.dynamis.mobList[zoneID][128].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1  } --   1 PLD  1 SMN
xi.dynamis.mobList[zoneID][129].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } --   1 BRD
xi.dynamis.mobList[zoneID][130].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } --   1 RNG
xi.dynamis.mobList[zoneID][131].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } --   1 BLM  1 NIN
xi.dynamis.mobList[zoneID][132].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 MNK
xi.dynamis.mobList[zoneID][133].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 RDM
xi.dynamis.mobList[zoneID][136].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil  } --   1 THF  1 DRG
xi.dynamis.mobList[zoneID][134].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } --   1 SAM
xi.dynamis.mobList[zoneID][135].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  } --   1 DRK
xi.dynamis.mobList[zoneID][137].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 MNK  1 WHM
xi.dynamis.mobList[zoneID][138].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } --   1 BST
xi.dynamis.mobList[zoneID][139].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } --   1 NIN
xi.dynamis.mobList[zoneID][140].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 BLM
xi.dynamis.mobList[zoneID][141].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  } --   1 SMN
xi.dynamis.mobList[zoneID][142].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  } --   1 DRG
xi.dynamis.mobList[zoneID][143].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } --   1 SAM
xi.dynamis.mobList[zoneID][144].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } --   1 RNG
xi.dynamis.mobList[zoneID][145].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 PLD
xi.dynamis.mobList[zoneID][146].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 WAR
xi.dynamis.mobList[zoneID][148].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil  } --   1 PLD  1 BRD
xi.dynamis.mobList[zoneID][147].mobchildren = { nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 RDM  1 THF
xi.dynamis.mobList[zoneID][149].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  } --   1 DRG
xi.dynamis.mobList[zoneID][150].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil  } --   1 BRD  1 RNG
xi.dynamis.mobList[zoneID][151].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } --   1 BLM
xi.dynamis.mobList[zoneID][152].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } --   1 NIN
xi.dynamis.mobList[zoneID][154].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } --   1 BST
xi.dynamis.mobList[zoneID][155].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  } --   1 SMN
xi.dynamis.mobList[zoneID][156].mobchildren = { nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  } --   1 MNK  1 DRK
xi.dynamis.mobList[zoneID][157].mobchildren = { nil, nil,   1, nil,   1,   1, nil, nil, nil, nil, nil,   1,   1, nil, nil  } --   1 WHM  1 RDM  1 THF  1 SAM  1 NIN
xi.dynamis.mobList[zoneID][160].mobchildren = {   2, nil, nil, nil,   2, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  } --   2 WAR  2 RDM  2 PLD
xi.dynamis.mobList[zoneID][159].mobchildren = { nil, nil,   2,   2, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil  } --   2 WHM  2 BLM  2 BRD
xi.dynamis.mobList[zoneID][161].mobchildren = { nil,   2, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil,   2, nil, nil  } --   2 MNK  2 THF  2 NIN
xi.dynamis.mobList[zoneID][162].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil,   2,   2, nil, nil, nil  } --   2 DRK  2 RNG  2 SAM
xi.dynamis.mobList[zoneID][158].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil,   2,   2  } --   2 BST  2 DRG  2 SMN

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].nmchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

xi.dynamis.mobList[zoneID][10 ].nmchildren = { true,  168                  } -- (010-Y) Spawns -> MNK NM (Xaa Chau the Roctalon)
xi.dynamis.mobList[zoneID][15 ].nmchildren = { true,  170                  } -- (015-Y) Spawns -> BST NM (Soo Jopo the Fiendking)
xi.dynamis.mobList[zoneID][17 ].nmchildren = { true,  171                  } -- (017-Y) Spawns -> RNG NM (Hee Mida the Meticulous)
xi.dynamis.mobList[zoneID][14 ].nmchildren = { true,  169                  } -- (014-Y) Spawns -> DRG NM (Maa Zaua the Wyrmkeeper)
xi.dynamis.mobList[zoneID][19 ].nmchildren = { true,  172                  } -- (019-Y) Spawns -> BRD NM (Xhoo Fuza the Sublime)
xi.dynamis.mobList[zoneID][20 ].nmchildren = { true,  173                  } -- (020-Y) Spawns -> SMN NM (Puu Timu the Phantasmal)
xi.dynamis.mobList[zoneID][21 ].nmchildren = { true,  174                  } -- (021-Y) Spawns -> WAR NM (Foo Peku the Bloodcloak)
xi.dynamis.mobList[zoneID][29 ].nmchildren = { true,  180                  } -- (029-Y) Spawns -> BLM NM (Bhuu Wjato the Firepool)
xi.dynamis.mobList[zoneID][26 ].nmchildren = { true,  179                  } -- (026-Y) Spawns -> RDM NM (Caa Xaza the Madpiercer)
xi.dynamis.mobList[zoneID][24 ].nmchildren = { true,  175, 176, 177, 178   } -- ( 024 ) Spawns -> WHM NM (Koo Saxu the Everfast),   NIN NM (Kuu Xuka the Nimble),    PLD NM (Guu Waji the Preacher), DRK NM (Nee Huxa the Judgmental)
xi.dynamis.mobList[zoneID][31 ].nmchildren = { true,  181                  } -- (031-G) Spawns -> MNK NM (Droprix Granitepalms)
xi.dynamis.mobList[zoneID][34 ].nmchildren = { true,  182                  } -- (034-G) Spawns -> BLM NM (Ascetox Ratgums)
xi.dynamis.mobList[zoneID][35 ].nmchildren = { true,  183                  } -- (035-G) Spawns -> THF NM (Bordox Kittyback)
xi.dynamis.mobList[zoneID][52 ].nmchildren = { true,  192                  } -- (052-G) Spawns -> BST NM (Routsix Rubbertendon)
xi.dynamis.mobList[zoneID][53 ].nmchildren = { true,  193                  } -- (053-G) Spawns -> BRD NM (Whistrix Toadthroat)
xi.dynamis.mobList[zoneID][47 ].nmchildren = { true,  188, 189, 190, 191   } -- ( 047 ) Spawns -> SMN NM (Morblox Chubbychin),      WAR NM (Moltenox Stubthumbs),    RNG NM (Slinkix Trufflesniff),  PLD NM (Ruffbix Jumbolobes)
xi.dynamis.mobList[zoneID][41 ].nmchildren = { true,  185                  } -- (041-G) Spawns -> NIN NM (Swypestix Tigershins)
xi.dynamis.mobList[zoneID][40 ].nmchildren = { true,  184                  } -- (040-G) Spawns -> DRG NM (Draklix Scalecrust)
xi.dynamis.mobList[zoneID][42 ].nmchildren = { true,  186                  } -- (042-G) Spawns -> SAM NM (Shisox Widebrow)
xi.dynamis.mobList[zoneID][46 ].nmchildren = { true,  187                  } -- (046-G) Spawns -> RDM NM (Gibberox Pimplebeak)
xi.dynamis.mobList[zoneID][54 ].nmchildren = { true,  194                  } -- (054-Q) Spawns -> THF NM (Ji'Fhu Infiltrator)
xi.dynamis.mobList[zoneID][55 ].nmchildren = { true,  195                  } -- (055-Q) Spawns -> DRK NM (Ta'Hyu Gallanthunter)
xi.dynamis.mobList[zoneID][68 ].nmchildren = { true,  201, 202, 203, 204   } -- ( 068 ) Spawns -> MNK NM (So'Zho Metalbender),      WHM NM (Ga'Fho Venomtouch),      BLM NM (De'Bho Pyrohand),       BST NM (So'Gho Adderhandler)
xi.dynamis.mobList[zoneID][76 ].nmchildren = { true,  206                  } -- (076-Q) Spawns -> SAM NM (Ji'Khu Towercleaver)
xi.dynamis.mobList[zoneID][72 ].nmchildren = { true,  205                  } -- (072-Q) Spawns -> DRG NM (Go'Tyo Magenapper)
xi.dynamis.mobList[zoneID][58 ].nmchildren = { true,  196                  } -- (058-Q) Spawns -> PLD NM (Mu'Gha Legionkiller)
xi.dynamis.mobList[zoneID][60 ].nmchildren = { true,  197                  } -- (060-Q) Spawns -> NIN NM (Mi'Rhe Whisperblade)
xi.dynamis.mobList[zoneID][62 ].nmchildren = { true,  198                  } -- (062-Q) Spawns -> BRD NM (Nu'Bhi Spiraleye)
xi.dynamis.mobList[zoneID][63 ].nmchildren = { true,  199                  } -- (063-Q) Spawns -> SMN NM (Be'Zhe Keeprazer)
xi.dynamis.mobList[zoneID][66 ].nmchildren = { true,  200                  } -- (066-Q) Spawns -> RDM NM (Na'Hya Floodmaker)
xi.dynamis.mobList[zoneID][90 ].nmchildren = { true,  214, 215, 216, 217   } -- ( 090 ) Spawns -> DRG NM (Drakefeast Wubmfub),      RDM NM (Spinalsucker Galflmall), SAM NM (Elvaanlopper Grokdok),  WAR NM (Humegutter Adzjbadj)
xi.dynamis.mobList[zoneID][91 ].nmchildren = { true,  218                  } -- (091-O) Spawns -> BST NM (Mithraslaver Debhabob)
xi.dynamis.mobList[zoneID][98 ].nmchildren = { true,  219                  } -- (098-O) Spawns -> WHM NM (Wraithdancer Gidbnod)
xi.dynamis.mobList[zoneID][79 ].nmchildren = { true,  207                  } -- (079-O) Spawns -> SMN NM (Deathcaller Bidfbid)
xi.dynamis.mobList[zoneID][84 ].nmchildren = { true,  210                  } -- (084-O) Spawns -> DRK NM (Skinmask Ugghfogg)
xi.dynamis.mobList[zoneID][83 ].nmchildren = { true,  209                  } -- (083-O) Spawns -> PLD NM (Heavymail Djidzbad)
xi.dynamis.mobList[zoneID][82 ].nmchildren = { true,  208                  } -- (082-O) Spawns -> BLM NM (Taruroaster Biggsjig)
xi.dynamis.mobList[zoneID][86 ].nmchildren = { true,  211                  } -- (086-O) Spawns -> THF NM (Lockbuster Zapdjipp)
xi.dynamis.mobList[zoneID][87 ].nmchildren = { true,  212                  } -- (087-O) Spawns -> MNK NM (Cobraclaw Buchzvotch)
xi.dynamis.mobList[zoneID][88 ].nmchildren = { true,  213                  } -- (088-O) Spawns -> RNG NM (Galkarider Retzpratz)
xi.dynamis.mobList[zoneID][103].nmchildren = { true,  220, 221             } -- (103-Q) Spawns -> WAR NM (Gu'Nha Wallstormer),      RNG NM (Gu'Khu Dukesniper)
xi.dynamis.mobList[zoneID][104].nmchildren = { true,  222, 223             } -- (104-G) Spawns -> WHM NM (Brewnix Bittypupils),     DRK NM (Tocktix Thinlids)
xi.dynamis.mobList[zoneID][105].nmchildren = { true,  224, 225             } -- (105-O) Spawns -> BRD NM (Ultrasonic Zeknajak),     NIN NM (Jeunoraider Gepkzip)
xi.dynamis.mobList[zoneID][106].nmchildren = { true,  226, 227             } -- (106-Y) Spawns -> THF NM (Ryy Qihi the Idolrobber), SAM NM (Knii Hoqo the Bisector)
xi.dynamis.mobList[zoneID][117].nmchildren = { false, 120                  } -- (117-H) Spawns -> Vanguard Eye ( 120 )
xi.dynamis.mobList[zoneID][163].nmchildren = { true,  164, 165, 166, 167   } -- ( 163 ) Ahriman NM (Angra Mainyu)


------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].pos = {xpos, ypos, zpos, rot}

xi.dynamis.mobList[zoneID][3  ].pos = { -279.0733, -39.1011, -341.9998, 8     } -- (003-Y) Avatar Icon
xi.dynamis.mobList[zoneID][1  ].pos = { -260.1787, -39.0101, -362.4289, 70    } -- (001-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][2  ].pos = { -239.1913, -40.0000, -362.8879, 156   } -- (002-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][4  ].pos = { -232.9155, -39.8400, -335.9303, 127   } -- (004-G) Goblin Replica
xi.dynamis.mobList[zoneID][7  ].pos = { -285.3470, -40.0557, -315.7200, 244   } -- (007-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][6  ].pos = { -297.7608, -39.8339, -272.4887, 14    } -- (006-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][5  ].pos = { -263.2965, -40.9416, -300.3301, 95    } -- (005-Y) Avatar Icon
xi.dynamis.mobList[zoneID][8  ].pos = { -310.9539, -40.1066, -287.0196, 17    } -- (008-G) Goblin Replica
xi.dynamis.mobList[zoneID][10 ].pos = { -194.2248, -39.7044, -211.3219, 149   } -- (010-Y) Avatar Icon
xi.dynamis.mobList[zoneID][9  ].pos = { -180.1325, -39.5770, -205.7526, 190   } -- (009-Y) Avatar Icon
xi.dynamis.mobList[zoneID][11 ].pos = { -192.1449, -39.8455, -227.0389, 107   } -- (011-Y) Avatar Icon
xi.dynamis.mobList[zoneID][13 ].pos = { -167.3895, -39.7587, -212.6639, 236   } -- (013-Y) Avatar Icon
xi.dynamis.mobList[zoneID][12 ].pos = { -179.9195, -39.6378, -234.3385, 60    } -- (012-Y) Avatar Icon
xi.dynamis.mobList[zoneID][15 ].pos = {  -49.6709, -39.7176, -202.2746, 147   } -- (015-Y) Avatar Icon
xi.dynamis.mobList[zoneID][16 ].pos = {  -15.7695, -40.4197, -223.8477, 148   } -- (016-Y) Avatar Icon
xi.dynamis.mobList[zoneID][17 ].pos = {   18.3990, -40.2073, -202.0281, 153   } -- (017-Y) Avatar Icon
xi.dynamis.mobList[zoneID][14 ].pos = {  -56.6927, -40.1790, -211.7740, 155   } -- (014-Y) Avatar Icon
xi.dynamis.mobList[zoneID][18 ].pos = {  -33.1590, -40.1141, -193.4986, 60    } -- (018-Y) Avatar Icon
xi.dynamis.mobList[zoneID][19 ].pos = {  -37.0947, -40.5000, -254.2856, 175   } -- (019-Y) Avatar Icon
xi.dynamis.mobList[zoneID][20 ].pos = {  -82.8389, -40.1366, -259.2798, 5     } -- (020-Y) Avatar Icon
xi.dynamis.mobList[zoneID][21 ].pos = {  118.0029, -40.0000, -1.4011, 253     } -- (021-Y) Avatar Icon
xi.dynamis.mobList[zoneID][23 ].pos = {   72.3558, -40.0457, -6.2216, 249     } -- (023-Y) Avatar Icon
xi.dynamis.mobList[zoneID][22 ].pos = {   73.2736, -39.8664, 4.0085, 254      } -- (022-Y) Avatar Icon
xi.dynamis.mobList[zoneID][28 ].pos = {   92.3657, -41.3116, 67.6632, 95      } -- (028-Y) Avatar Icon
xi.dynamis.mobList[zoneID][27 ].pos = {   83.8304, -40.0000, 75.9769, 97      } -- (027-Y) Avatar Icon
xi.dynamis.mobList[zoneID][29 ].pos = {   90.8688, -40.6044, 59.7961, 10      } -- (029-Y) Avatar Icon
xi.dynamis.mobList[zoneID][26 ].pos = {   73.7746, -39.8908, 72.4544, 95      } -- (026-Y) Avatar Icon
xi.dynamis.mobList[zoneID][30 ].pos = {   79.1487, -39.1406, 57.2114, 90      } -- (030-Y) Avatar Icon
xi.dynamis.mobList[zoneID][25 ].pos = {   72.2687, -39.6224, 64.4010, 92      } -- (025-Y) Avatar Icon
xi.dynamis.mobList[zoneID][24 ].pos = {   85.0448, -39.9585, 70.5809, 96      } -- ( 024 ) Dynamis Icon
xi.dynamis.mobList[zoneID][31 ].pos = { -135.8315, -60.5272, -197.7793, 224   } -- (031-G) Goblin Statue
xi.dynamis.mobList[zoneID][33 ].pos = { -144.8487, -59.7218, -189.4915, 235   } -- ( 033 ) Goblin Statue
xi.dynamis.mobList[zoneID][32 ].pos = { -127.8651, -59.3734, -206.4330, 208   } -- (032-G) Goblin Statue
xi.dynamis.mobList[zoneID][34 ].pos = {  -43.1630, -59.8697, -113.3710, 255   } -- (034-G) Goblin Statue
xi.dynamis.mobList[zoneID][35 ].pos = {  -40.4508, -59.7970, -128.0826, 246   } -- (035-G) Goblin Statue
xi.dynamis.mobList[zoneID][36 ].pos = {  -35.7644, -59.1369, -142.6632, 235   } -- (036-G) Goblin Statue
xi.dynamis.mobList[zoneID][37 ].pos = {  -16.7373, -60.5292, -135.3285, 126   } -- (037-G) Goblin Statue
xi.dynamis.mobList[zoneID][38 ].pos = {   -7.3716, -59.6279, -148.7619, 115   } -- (038-G) Goblin Statue
xi.dynamis.mobList[zoneID][48 ].pos = {   81.3941, -59.9388, -74.7523, 109    } -- (048-G) Goblin Statue
xi.dynamis.mobList[zoneID][50 ].pos = {   72.3541, -59.9692, -51.4561, 126    } -- (050-G) Goblin Statue
xi.dynamis.mobList[zoneID][51 ].pos = {   73.7183, -59.8871, -38.8825, 123    } -- (051-G) Goblin Statue
xi.dynamis.mobList[zoneID][49 ].pos = {   77.3184, -59.1610, -63.1964, 128    } -- (049-G) Goblin Statue
xi.dynamis.mobList[zoneID][52 ].pos = {   90.8498, -59.6799, -35.1627, 109    } -- (052-G) Goblin Statue
xi.dynamis.mobList[zoneID][53 ].pos = {  102.1677, -61.0401, -53.2106, 111    } -- (053-G) Goblin Statue
xi.dynamis.mobList[zoneID][47 ].pos = {   85.8646, -59.7906, -50.6917, 117    } -- ( 047 ) Dynamis Statue
xi.dynamis.mobList[zoneID][39 ].pos = {   -6.0992, -59.5607, 60.9312, 242     } -- (039-G) Goblin Statue
xi.dynamis.mobList[zoneID][41 ].pos = {   -5.4384, -59.9930, 85.6257, 9       } -- (041-G) Goblin Statue
xi.dynamis.mobList[zoneID][40 ].pos = {   16.6093, -59.7430, 64.7391, 139     } -- (040-G) Goblin Statue
xi.dynamis.mobList[zoneID][43 ].pos = {   28.0952, -61.6794, 149.9339, 15     } -- (043-G) Goblin Statue
xi.dynamis.mobList[zoneID][42 ].pos = {   53.0996, -60.4462, 161.8882, 108    } -- (042-G) Goblin Statue
xi.dynamis.mobList[zoneID][44 ].pos = {   71.8310, -60.8405, 209.4839, 74     } -- (044-G) Goblin Statue
xi.dynamis.mobList[zoneID][45 ].pos = {   88.7690, -60.6208, 210.0924, 33     } -- (045-G) Goblin Statue
xi.dynamis.mobList[zoneID][46 ].pos = {  113.1226, -59.8573, 203.7245, 114    } -- (046-G) Goblin Statue
xi.dynamis.mobList[zoneID][56 ].pos = {  160.4106, -19.7059, 30.0949, 124     } -- (056-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][54 ].pos = {  168.1705, -19.4408, 15.7383, 134     } -- (054-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][55 ].pos = {  166.2367, -19.4045, 26.2815, 132     } -- (055-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][57 ].pos = {  162.6362, -19.6409, 11.2047, 141     } -- (057-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][68 ].pos = {  257.6411, -21.1347, -142.0784, 131   } -- ( 068 ) Dynamis Effigy
xi.dynamis.mobList[zoneID][76 ].pos = {  255.8613, -19.2185, -119.8784, 125   } -- (076-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][75 ].pos = {  273.8611, -19.8943, -116.1189, 114   } -- (075-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][74 ].pos = {  293.3825, -20.2153, -127.9682, 119   } -- (074-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][73 ].pos = {  256.3311, -19.2941, -165.6130, 130   } -- (073-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][72 ].pos = {  227.9596, -21.2556, -146.4416, 143   } -- (072-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][71 ].pos = {  230.3858, -19.9755, -132.9917, 139   } -- (071-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][70 ].pos = {  232.3072, -19.8166, -124.0341, 143   } -- (070-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][69 ].pos = {  243.9701, -20.2420, -110.1599, 143   } -- (069-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][58 ].pos = {   82.2491, -20.0000, -195.9017, 134   } -- (058-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][59 ].pos = {   72.8168, -19.8691, -212.5843, 150   } -- (059-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][60 ].pos = {   66.0040, -19.8042, -221.2624, 150   } -- (060-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][61 ].pos = {   60.7676, -19.0500, -235.8141, 150   } -- (061-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][62 ].pos = {   59.9181, -19.2985, -250.7721, 139   } -- (062-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][63 ].pos = {  137.6571, -20.3000, -197.3645, 82    } -- (063-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][65 ].pos = {  -63.1991, -21.0329, -293.5439, 163   } -- (065-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][64 ].pos = {  -42.4831, -19.5290, -287.9989, 179   } -- (064-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][67 ].pos = {  -74.3709, -20.1062, -332.8462, 151   } -- (067-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][66 ].pos = {  -80.6846, -20.7738, -270.7316, 55    } -- (066-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][90 ].pos = {  350.0000, 0.1359, -155.9000, 128     } -- ( 090 ) Dynamis Tombstone
xi.dynamis.mobList[zoneID][91 ].pos = {  335.0000, 0.6565, -163.8019, 128     } -- (091-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][92 ].pos = {  345.0000, 0.0874, -163.8019, 128     } -- (092-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][93 ].pos = {  355.0000, 0.0627, -163.8019, 128     } -- (093-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][94 ].pos = {  365.0000, 0.0749, -163.8019, 128     } -- (094-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][98 ].pos = {  335.0000, 0.2920, -148.0000, 128     } -- (098-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][97 ].pos = {  345.0000, 0.5045, -148.0000, 128     } -- (097-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][96 ].pos = {  355.0000, 0.5428, -148.0000, 128     } -- (096-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][95 ].pos = {  365.0000, 0.4668, -148.0000, 128     } -- (095-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][77 ].pos = {  -21.0316, 0.2199, -320.4573, 38      } -- (077-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][78 ].pos = {  -28.5544, 0.0000, -305.9902, 24      } -- (078-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][79 ].pos = {  -48.0951, -0.0097, -302.7363, 244    } -- (079-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][80 ].pos = {  -58.3921, 0.1868, -314.9998, 195     } -- (080-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][81 ].pos = {  -60.2255, 0.2000, -332.1296, 201     } -- (081-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][84 ].pos = { -116.1668, 0.4220, -372.3102, 16      } -- (084-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][83 ].pos = { -114.2561, 0.4379, -386.6913, 241     } -- (083-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][82 ].pos = { -100.6849, 0.9646, -396.2882, 206     } -- (082-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][85 ].pos = {  405.0992, 0.4061, -5.5113, 144       } -- (085-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][86 ].pos = {  406.4566, -0.0185, 10.1297, 144      } -- (086-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][87 ].pos = {  408.7980, 1.0967, 22.5814,	144       } -- (087-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][88 ].pos = {  409.5340, -1.7055, 33.6995, 144      } -- (088-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][89 ].pos = {  408.8476, -0.4056, 46.6788, 144      } -- (089-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][99 ].pos = {  263.4912, -0.97039, 58.8165, 29      } -- (099-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][100].pos = {  268.7820, -0.5453, 70.0471, 19       } -- (100-Q) Adanantking Effigy
xi.dynamis.mobList[zoneID][101].pos = {  267.6158, 0.4338, 83.5243, 31        } -- (101-Y) Avatar Icon
xi.dynamis.mobList[zoneID][102].pos = {  260.9484, -0.5514, 98.2945, 41       } -- (102-G) Goblin Replica
xi.dynamis.mobList[zoneID][103].pos = {  264.6924, 0.7262, 243.3394, 59       } -- (103-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][104].pos = {  285.0459, -0.0535, 242.4564, 101     } -- (104-G) Goblin Replica
xi.dynamis.mobList[zoneID][105].pos = {  287.2189, -0.0928, 230.3786, 133     } -- (105-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][106].pos = {  288.0384, -0.1970, 205.6502, 129     } -- (106-Y) Avatar Icon
xi.dynamis.mobList[zoneID][107].pos = {  -44.0915, -63.6540, 99.7354, 255     } -- (107-H) Vanguard Eye
xi.dynamis.mobList[zoneID][118].pos = {  -40.3174, -79.6383, 113.0489, 133    } -- (118-H) Vanguard Eye
xi.dynamis.mobList[zoneID][117].pos = {  -29.2701, -80.3479, 123.5728, 138    } -- (117-H) Vanguard Eye
xi.dynamis.mobList[zoneID][116].pos = {  -30.9502, -79.7086, 134.8122, 131    } -- (116-H) Vanguard Eye
xi.dynamis.mobList[zoneID][115].pos = {  -39.4031, -80.1331, 166.6385, 76     } -- (115-H) Vanguard Eye
xi.dynamis.mobList[zoneID][114].pos = {  -96.4499, -79.6777, 146.0539, 101    } -- (114-H) Vanguard Eye
xi.dynamis.mobList[zoneID][119].pos = {  -83.3049, -80.0000, 121.3884, 130    } -- (119-H) Vanguard Eye
xi.dynamis.mobList[zoneID][113].pos = { -123.5741, -79.2257, 144.2114, 55     } -- (113-H) Vanguard Eye
xi.dynamis.mobList[zoneID][112].pos = { -112.6828, -79.8353, 162.7629, 55     } -- (112-H) Vanguard Eye
xi.dynamis.mobList[zoneID][108].pos = { -140.6943, -79.7930, 140.1634, 55     } -- (108-H) Vanguard Eye
xi.dynamis.mobList[zoneID][111].pos = { -138.7632, -79.0630, 161.4096, 55     } -- (111-H) Vanguard Eye
xi.dynamis.mobList[zoneID][120].pos = { -127.9832, -80.0000, 189.8156, 55     } -- (120-H) Vanguard Eye
xi.dynamis.mobList[zoneID][110].pos = { -154.8108, -79.9417, 155.8926, 55     } -- (110-H) Vanguard Eye
xi.dynamis.mobList[zoneID][109].pos = { -160.5700, -79.3930, 134.1153, 55     } -- (109-H) Vanguard Eye
xi.dynamis.mobList[zoneID][122].pos = {  -71.0217, -79.8245, 74.5786, 126     } -- (122-H) Vanguard Eye
xi.dynamis.mobList[zoneID][121].pos = {  -71.5218, -80.0654, 86.2477, 126     } -- (121-H) Vanguard Eye
xi.dynamis.mobList[zoneID][123].pos = {  -22.0972, -80.7410, 64.2880, 178     } -- (123-H) Vanguard Eye
xi.dynamis.mobList[zoneID][124].pos = {  -24.0412, -79.9206, 9.5265, 185      } -- (124-H) Vanguard Eye
xi.dynamis.mobList[zoneID][125].pos = {  -62.9328, -80.0783, -51.2713, 196    } -- (125-H) Vanguard Eye
xi.dynamis.mobList[zoneID][126].pos = {  -88.6876, -80.9274, -64.3945, 234    } -- (126-H) Vanguard Eye
xi.dynamis.mobList[zoneID][127].pos = { -101.6736, -80.0000, -119.9976, 183   } -- (127-H) Vanguard Eye
xi.dynamis.mobList[zoneID][128].pos = { -118.1774, -80.0000, -137.8634, 246   } -- (128-H) Vanguard Eye
xi.dynamis.mobList[zoneID][129].pos = { -144.3036, -80.5000, -163.8153, 181   } -- (129-H) Vanguard Eye
xi.dynamis.mobList[zoneID][130].pos = { -168.8876, -79.6787, -165.5847, 195   } -- (130-H) Vanguard Eye
xi.dynamis.mobList[zoneID][131].pos = { -164.6790, -79.1044, -139.3900, 255   } -- (131-H) Vanguard Eye
xi.dynamis.mobList[zoneID][132].pos = { -174.2991, -79.3748, -116.3493, 65    } -- (132-H) Vanguard Eye
xi.dynamis.mobList[zoneID][133].pos = { -175.4636, -79.6582, -132.1770, 64    } -- (133-H) Vanguard Eye
xi.dynamis.mobList[zoneID][136].pos = { -245.4614, -80.1574, -126.6808, 11    } -- (136-H) Vanguard Eye
xi.dynamis.mobList[zoneID][134].pos = { -193.0234, -80.0800, -127.0653, 64    } -- (134-H) Vanguard Eye
xi.dynamis.mobList[zoneID][135].pos = { -179.9060, -79.3061, -113.0376, 60    } -- (135-H) Vanguard Eye
xi.dynamis.mobList[zoneID][137].pos = { -241.0599, -80.0729, -114.5646, 15    } -- (137-H) Vanguard Eye
xi.dynamis.mobList[zoneID][138].pos = { -292.4296, -80.5000, -113.2843, 16    } -- (138-H) Vanguard Eye
xi.dynamis.mobList[zoneID][139].pos = { -281.6393, -79.1325, -97.3740, 19     } -- (139-H) Vanguard Eye
xi.dynamis.mobList[zoneID][140].pos = { -280.3488, -80.0000, -76.3263, 70     } -- (140-H) Vanguard Eye
xi.dynamis.mobList[zoneID][141].pos = { -152.9554, -100.1509, 6.9910, 121     } -- (141-H) Vanguard Eye
xi.dynamis.mobList[zoneID][142].pos = { -137.0686, -99.6546, -16.1596, 130    } -- (142-H) Vanguard Eye
xi.dynamis.mobList[zoneID][143].pos = { -136.4481, -100.3073, -52.0000, 129   } -- (143-H) Vanguard Eye
xi.dynamis.mobList[zoneID][144].pos = { -124.3648, -99.6392, -68.7928, 135    } -- (144-H) Vanguard Eye
xi.dynamis.mobList[zoneID][145].pos = { -126.0454, -99.5554, -102.0939, 183   } -- (145-H) Vanguard Eye
xi.dynamis.mobList[zoneID][146].pos = { -103.1679, -100.3910, -54.7808, 151   } -- (146-H) Vanguard Eye
xi.dynamis.mobList[zoneID][148].pos = {  -65.4576, -99.7153, 60.5501, 74      } -- (148-H) Vanguard Eye
xi.dynamis.mobList[zoneID][147].pos = {  -61.8848, -101.1865, 23.1000, 91     } -- (147-H) Vanguard Eye
xi.dynamis.mobList[zoneID][149].pos = { -245.7510, -99.8712, 11.2572, 3       } -- (149-H) Vanguard Eye
xi.dynamis.mobList[zoneID][150].pos = { -246.2604, -99.4197, 23.7584, 3       } -- (150-H) Vanguard Eye
xi.dynamis.mobList[zoneID][151].pos = { -244.2214, -100.0123, 37.5050, 3      } -- (151-H) Vanguard Eye
xi.dynamis.mobList[zoneID][152].pos = { -298.8714, -99.7872, 38.3348, 49      } -- (152-H) Vanguard Eye
xi.dynamis.mobList[zoneID][153].pos = { -309.1874, -100.0000, 55.2101, 27     } -- (153-H) Vanguard Eye
xi.dynamis.mobList[zoneID][154].pos = { -345.4541, -100.0125, 65.2495, 12     } -- (154-H) Vanguard Eye
xi.dynamis.mobList[zoneID][155].pos = { -361.3637, -99.4463, 106.4152, 54     } -- (155-H) Vanguard Eye
xi.dynamis.mobList[zoneID][156].pos = { -338.0219, -101.0014, 104.1122, 118   } -- (156-H) Vanguard Eye
xi.dynamis.mobList[zoneID][157].pos = { -339.8712, -100.2500, 136.2033, 63    } -- (157-H) Vanguard Eye
xi.dynamis.mobList[zoneID][163].pos = {  280.0817, 20.0000, 536.5154, 65      } -- ( 163 ) Angra Mainyu
xi.dynamis.mobList[zoneID][164].pos = {  275.2877, 20, 544.6065, 63           } -- Fire Pukis
xi.dynamis.mobList[zoneID][165].pos = {  283.5459, 20, 545.8229, 63           } -- Poison Pukis
xi.dynamis.mobList[zoneID][166].pos = {  285.7335, 20, 532.6114, 63           } -- Wind Pukis
xi.dynamis.mobList[zoneID][167].pos = {  274.4853, 20, 532.4368, 63           } -- Petro Pukis
xi.dynamis.mobList[zoneID][160].pos = {  100.1128, -20.2500, 137.1149, 63     } -- ( 160 ) Attest. NM (Goublefaupe) (RDM+PLD+WAR)
xi.dynamis.mobList[zoneID][159].pos = {  -20.0183, -60.2500, -64.0732, 62     } -- ( 159 ) Attest. NM (Quiebitiel) (BLM+WHM+BRD)
xi.dynamis.mobList[zoneID][161].pos = {   60.1032, -0.2500, -336.3712, 191    } -- ( 161 ) Attest. NM (Mildaunegeux) (MNK+NIN+THF)
xi.dynamis.mobList[zoneID][162].pos = {  263.2100, -0.2500, -19.8968, 253     } -- ( 162 ) Attest. NM (Velosareon) (DRK+SAM+RNG)
xi.dynamis.mobList[zoneID][158].pos = { -176.4133, -40.2500, -219.9464,   0   } -- ( 158 ) Attest. NM (Dagourmarche) (DRG+SMN+BST)

----------------------------------------------------------------------------------------------------
--                                    Setup of Mob Functions                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Statue Eye Colors           --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eye.BLUE -- Flags for blue eyes. (HP)
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eye.GREEN -- Flags for green eyes. (MP)

xi.dynamis.mobList[zoneID][5  ].eyes = xi.dynamis.eye.BLUE  -- (005-Y) (HP) Avatar Icon
xi.dynamis.mobList[zoneID][13 ].eyes = xi.dynamis.eye.BLUE  -- (013-Y) (HP) Avatar Icon
xi.dynamis.mobList[zoneID][18 ].eyes = xi.dynamis.eye.BLUE  -- (018-Y) (HP) Avatar Icon
xi.dynamis.mobList[zoneID][23 ].eyes = xi.dynamis.eye.BLUE  -- (023-Y) (HP) Avatar Icon
xi.dynamis.mobList[zoneID][30 ].eyes = xi.dynamis.eye.BLUE  -- (030-Y) (HP) Avatar Icon
xi.dynamis.mobList[zoneID][37 ].eyes = xi.dynamis.eye.BLUE  -- (037-G) (HP) Goblin Statue
xi.dynamis.mobList[zoneID][51 ].eyes = xi.dynamis.eye.BLUE  -- (051-G) (HP) Goblin Statue
xi.dynamis.mobList[zoneID][53 ].eyes = xi.dynamis.eye.BLUE  -- (053-G) (HP) Goblin Statue
xi.dynamis.mobList[zoneID][41 ].eyes = xi.dynamis.eye.BLUE  -- (041-G) (HP) Goblin Statue
xi.dynamis.mobList[zoneID][44 ].eyes = xi.dynamis.eye.BLUE  -- (044-G) (HP) Goblin Statue
xi.dynamis.mobList[zoneID][56 ].eyes = xi.dynamis.eye.BLUE  -- (056-Q) (HP) Adamantking Effigy
xi.dynamis.mobList[zoneID][74 ].eyes = xi.dynamis.eye.BLUE  -- (074-Q) (HP) Adamantking Effigy
xi.dynamis.mobList[zoneID][70 ].eyes = xi.dynamis.eye.BLUE  -- (070-Q) (HP) Adamantking Effigy
xi.dynamis.mobList[zoneID][59 ].eyes = xi.dynamis.eye.BLUE  -- (059-Q) (HP) Adamantking Effigy
xi.dynamis.mobList[zoneID][65 ].eyes = xi.dynamis.eye.BLUE  -- (065-Q) (HP) Adamantking Effigy
xi.dynamis.mobList[zoneID][91 ].eyes = xi.dynamis.eye.BLUE  -- (091-O) (HP) Serjeant Tombstone
xi.dynamis.mobList[zoneID][78 ].eyes = xi.dynamis.eye.BLUE  -- (078-O) (HP) Serjeant Tombstone
xi.dynamis.mobList[zoneID][84 ].eyes = xi.dynamis.eye.BLUE  -- (084-O) (HP) Serjeant Tombstone
xi.dynamis.mobList[zoneID][86 ].eyes = xi.dynamis.eye.BLUE  -- (086-O) (HP) Serjeant Tombstone
xi.dynamis.mobList[zoneID][103].eyes = xi.dynamis.eye.BLUE  -- (103-Q) (HP) Adamantking Effigy
xi.dynamis.mobList[zoneID][105].eyes = xi.dynamis.eye.BLUE  -- (105-O) (HP) Serjeant Tombstone
xi.dynamis.mobList[zoneID][8  ].eyes = xi.dynamis.eye.GREEN -- (008-G) (MP) Goblin Replica
xi.dynamis.mobList[zoneID][12 ].eyes = xi.dynamis.eye.GREEN -- (012-Y) (MP) Avatar Icon
xi.dynamis.mobList[zoneID][22 ].eyes = xi.dynamis.eye.GREEN -- (022-Y) (MP) Avatar Icon
xi.dynamis.mobList[zoneID][27 ].eyes = xi.dynamis.eye.GREEN -- (027-Y) (MP) Avatar Icon
xi.dynamis.mobList[zoneID][25 ].eyes = xi.dynamis.eye.GREEN -- (025-Y) (MP) Avatar Icon
xi.dynamis.mobList[zoneID][38 ].eyes = xi.dynamis.eye.GREEN -- (038-G) (MP) Goblin Statue
xi.dynamis.mobList[zoneID][49 ].eyes = xi.dynamis.eye.GREEN -- (049-G) (MP) Goblin Statue
xi.dynamis.mobList[zoneID][52 ].eyes = xi.dynamis.eye.GREEN -- (052-G) (MP) Goblin Statue
xi.dynamis.mobList[zoneID][40 ].eyes = xi.dynamis.eye.GREEN -- (040-G) (MP) Goblin Statue
xi.dynamis.mobList[zoneID][45 ].eyes = xi.dynamis.eye.GREEN -- (045-G) (MP) Goblin Statue
xi.dynamis.mobList[zoneID][57 ].eyes = xi.dynamis.eye.GREEN -- (057-Q) (MP) Adamantking Effigy
xi.dynamis.mobList[zoneID][76 ].eyes = xi.dynamis.eye.GREEN -- (076-Q) (MP) Adamantking Effigy
xi.dynamis.mobList[zoneID][72 ].eyes = xi.dynamis.eye.GREEN -- (072-Q) (MP) Adamantking Effigy
xi.dynamis.mobList[zoneID][61 ].eyes = xi.dynamis.eye.GREEN -- (061-Q) (MP) Adamantking Effigy
xi.dynamis.mobList[zoneID][67 ].eyes = xi.dynamis.eye.GREEN -- (067-Q) (MP) Adamantking Effigy
xi.dynamis.mobList[zoneID][94 ].eyes = xi.dynamis.eye.GREEN -- (094-O) (MP) Serjeant Tombstone
xi.dynamis.mobList[zoneID][98 ].eyes = xi.dynamis.eye.GREEN -- (098-O) (MP) Serjeant Tombstone
xi.dynamis.mobList[zoneID][80 ].eyes = xi.dynamis.eye.GREEN -- (080-O) (MP) Serjeant Tombstone
xi.dynamis.mobList[zoneID][82 ].eyes = xi.dynamis.eye.GREEN -- (082-O) (MP) Serjeant Tombstone
xi.dynamis.mobList[zoneID][88 ].eyes = xi.dynamis.eye.GREEN -- (088-O) (MP) Serjeant Tombstone
xi.dynamis.mobList[zoneID][104].eyes = xi.dynamis.eye.GREEN -- (104-G) (MP) Goblin Replica
xi.dynamis.mobList[zoneID][106].eyes = xi.dynamis.eye.GREEN -- (106-Y) (MP) Avatar Icon

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].timeExtension = 15

xi.dynamis.mobList[zoneID].timeExtensionList = {10, 20, 31, 46, 63, 66, 83, 87, 120, 147}
xi.dynamis.mobList[zoneID][10 ].timeExtension = 15 -- (010-Y) Avatar Icon
xi.dynamis.mobList[zoneID][20 ].timeExtension = 15 -- (020-Y) Avatar Icon
xi.dynamis.mobList[zoneID][31 ].timeExtension = 15 -- (031-G) Goblin Statue
xi.dynamis.mobList[zoneID][46 ].timeExtension = 15 -- (046-G) Goblin Statue
xi.dynamis.mobList[zoneID][63 ].timeExtension = 15 -- (063-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][66 ].timeExtension = 15 -- (066-Q) Adamantking Effigy
xi.dynamis.mobList[zoneID][83 ].timeExtension = 15 -- (083-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][87 ].timeExtension = 15 -- (087-O) Serjeant Tombstone
xi.dynamis.mobList[zoneID][120].timeExtension = 15 -- (120-H) Vanguard Eye
xi.dynamis.mobList[zoneID][147].timeExtension = 15 -- (147-H) Vanguard Eye
