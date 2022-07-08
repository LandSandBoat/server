----------------------------------------------------------------------------------------------------
--                                      Dynamis-San d'Oria                                        --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/san.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/san.html        --
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
local zoneID = xi.zone.DYNAMIS_SAN_DORIA
local i = 1
xi = xi or {} -- Ignore me I just set the global.
xi.dynamis = xi.dynamis or {} -- Ignore me I just set the global.
xi.dynamis.mobList = xi.dynamis.mobList or { } -- Ignore me I just set the global.
xi.dynamis.mobList[zoneID] = { } -- Ignore me, I just start the table.
xi.dynamis.mobList[zoneID].nmchildren = { }
xi.dynamis.mobList[zoneID].mobchildren = { }
xi.dynamis.mobList[zoneID].maxWaves = 6 -- Put in number of max waves

while i <= 155 do
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

xi.dynamis.mobList[zoneID][1  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (001-O/S)
xi.dynamis.mobList[zoneID][2  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (002-O/S)
xi.dynamis.mobList[zoneID][3  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (003-O/S)
xi.dynamis.mobList[zoneID][4  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (004-O/S)
xi.dynamis.mobList[zoneID][5  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (005-O/S)
xi.dynamis.mobList[zoneID][6  ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (006-O/W)(MP)
xi.dynamis.mobList[zoneID][7  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (007-O/S)(15)
xi.dynamis.mobList[zoneID][8  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (008-O/S)
xi.dynamis.mobList[zoneID][9  ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (009-O/S)(15)
xi.dynamis.mobList[zoneID][10 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (010-O/W)(MP)
xi.dynamis.mobList[zoneID][11 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (011-O/S)
xi.dynamis.mobList[zoneID][12 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (012-O/W)(HP)
xi.dynamis.mobList[zoneID][13 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (013-O/S)
xi.dynamis.mobList[zoneID][14 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (014-O/W)(MP)
xi.dynamis.mobList[zoneID][15 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (015-O/W)(HP)
xi.dynamis.mobList[zoneID][16 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (016-O/S)
xi.dynamis.mobList[zoneID][17 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (017-O/S)
xi.dynamis.mobList[zoneID][18 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (018-O/S)
xi.dynamis.mobList[zoneID][19 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (019-O/S)
xi.dynamis.mobList[zoneID][20 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (020-O/S)
xi.dynamis.mobList[zoneID][21 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (021-O/S)
xi.dynamis.mobList[zoneID][22 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (022-O/S)
xi.dynamis.mobList[zoneID][23 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (023-O/S)
xi.dynamis.mobList[zoneID][24 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (024-O/S)
xi.dynamis.mobList[zoneID][25 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (025-O/S)
xi.dynamis.mobList[zoneID][26 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (026-O/S)(25)
xi.dynamis.mobList[zoneID][27 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (027-O/S)
xi.dynamis.mobList[zoneID][28 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (028-O/S)
xi.dynamis.mobList[zoneID][29 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (029-O/S)
xi.dynamis.mobList[zoneID][30 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (030-O/S)
xi.dynamis.mobList[zoneID][31 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (031-O/S)
xi.dynamis.mobList[zoneID][32 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (032-O/W)(MP)
xi.dynamis.mobList[zoneID][33 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (033-O/S)
xi.dynamis.mobList[zoneID][34 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (034-O/W)(HP)
xi.dynamis.mobList[zoneID][35 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (035-O/W)(MP)
xi.dynamis.mobList[zoneID][36 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (036-O/S)
xi.dynamis.mobList[zoneID][37 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (037-O/S)
xi.dynamis.mobList[zoneID][38 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (038-O/W)(MP)
xi.dynamis.mobList[zoneID][39 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (039-O/S)
xi.dynamis.mobList[zoneID][40 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (040-O/S)
xi.dynamis.mobList[zoneID][41 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (041-O/S)(30)
xi.dynamis.mobList[zoneID][42 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (042-O/S)
xi.dynamis.mobList[zoneID][43 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (043-O/S)
xi.dynamis.mobList[zoneID][44 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (044-O/W)(HP)
xi.dynamis.mobList[zoneID][45 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (045-O/S)
xi.dynamis.mobList[zoneID][46 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (046-O/S)
xi.dynamis.mobList[zoneID][47 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (047-O/W)(MP)
xi.dynamis.mobList[zoneID][48 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (048-O/S)
xi.dynamis.mobList[zoneID][49 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (049-O/S)
xi.dynamis.mobList[zoneID][50 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (050-O/S)
xi.dynamis.mobList[zoneID][51 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (051-O/S)
xi.dynamis.mobList[zoneID][52 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (052-O/W)(HP)
xi.dynamis.mobList[zoneID][53 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (053-O/S)
xi.dynamis.mobList[zoneID][54 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (054-O/S)
xi.dynamis.mobList[zoneID][55 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (055-O/S)
xi.dynamis.mobList[zoneID][56 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (056-O/S)
xi.dynamis.mobList[zoneID][57 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (057-O/S)
xi.dynamis.mobList[zoneID][58 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (058-O/S)
xi.dynamis.mobList[zoneID][59 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (059-O/W)(HP)
xi.dynamis.mobList[zoneID][60 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (060-O/W)(MP)
xi.dynamis.mobList[zoneID][61 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (061-O/S)
xi.dynamis.mobList[zoneID][62 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (062-O/W)(MP)
xi.dynamis.mobList[zoneID][63 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (063-O/S)
xi.dynamis.mobList[zoneID][64 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (064-O/S)(25)
xi.dynamis.mobList[zoneID][65 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (065-O/S)
xi.dynamis.mobList[zoneID][66 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (066-O/S)
xi.dynamis.mobList[zoneID][67 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (067-O/S)
xi.dynamis.mobList[zoneID][68 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (068-O/S)
xi.dynamis.mobList[zoneID][69 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (069-O/S)
xi.dynamis.mobList[zoneID][70 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (070-O/W)(MP)
xi.dynamis.mobList[zoneID][71 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (071-O/S)
xi.dynamis.mobList[zoneID][72 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (072-O/W)(HP)
xi.dynamis.mobList[zoneID][73 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (073-O/S)
xi.dynamis.mobList[zoneID][74 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (074-O/W)(10)
xi.dynamis.mobList[zoneID][75 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (075-O/S)
xi.dynamis.mobList[zoneID][76 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (076-O/W)(MP)
xi.dynamis.mobList[zoneID][77 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (077-O/S)
xi.dynamis.mobList[zoneID][78 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (078-O/W)(HP)
xi.dynamis.mobList[zoneID][79 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (079-O/W)(MP)
xi.dynamis.mobList[zoneID][80 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (080-O/S)
xi.dynamis.mobList[zoneID][81 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (081-O/W)(HP)
xi.dynamis.mobList[zoneID][82 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (082-O/S)
xi.dynamis.mobList[zoneID][83 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (083-O/W)(HP)
xi.dynamis.mobList[zoneID][84 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (084-O/W)(MP)
xi.dynamis.mobList[zoneID][85 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (085-O/W)(HP)
xi.dynamis.mobList[zoneID][86 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (086-O/W)(MP)
xi.dynamis.mobList[zoneID][87 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (087-O/S)
xi.dynamis.mobList[zoneID][88 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (088-O/S)
xi.dynamis.mobList[zoneID][89 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (089-O/S)
xi.dynamis.mobList[zoneID][90 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (090-O/S)
xi.dynamis.mobList[zoneID][91 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (091-O/W)(HP)
xi.dynamis.mobList[zoneID][92 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (092-O/W)(MP)
xi.dynamis.mobList[zoneID][93 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (093-O/S)
xi.dynamis.mobList[zoneID][94 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (094-O/S)
xi.dynamis.mobList[zoneID][95 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (095-O/S)
xi.dynamis.mobList[zoneID][96 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (096-O/S)
xi.dynamis.mobList[zoneID][97 ].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (097-O/W)(HP)
xi.dynamis.mobList[zoneID][98 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (098-O/S)
xi.dynamis.mobList[zoneID][99 ].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (099-O/S)
xi.dynamis.mobList[zoneID][100].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (100-O/S)
xi.dynamis.mobList[zoneID][101].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (101-O/S)
xi.dynamis.mobList[zoneID][102].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (102-O/S)
xi.dynamis.mobList[zoneID][103].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (103-O/W)(HP)
xi.dynamis.mobList[zoneID][104].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (104-O/W)(HP)
xi.dynamis.mobList[zoneID][105].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (105-O/S)
xi.dynamis.mobList[zoneID][106].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (106-O/S)
xi.dynamis.mobList[zoneID][107].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (107-O/W)(HP)
xi.dynamis.mobList[zoneID][108].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (108-O/W)(MP)
xi.dynamis.mobList[zoneID][110].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (110-O/W)(MP)
xi.dynamis.mobList[zoneID][111].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (111-O/W)(MP)
xi.dynamis.mobList[zoneID][112].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (112-O/S)
xi.dynamis.mobList[zoneID][113].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (113-O/W)(HP)
xi.dynamis.mobList[zoneID][114].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (114-O/S)
xi.dynamis.mobList[zoneID][115].info = {"Statue", "Warchief Tombstone", nil, nil, nil} -- (115-O/W)(HP)
xi.dynamis.mobList[zoneID][116].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (116-O/S)
xi.dynamis.mobList[zoneID][117].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (117-O/S)
xi.dynamis.mobList[zoneID][118].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (118-O/S)
xi.dynamis.mobList[zoneID][119].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (119-O/S)
xi.dynamis.mobList[zoneID][120].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (120-O/S)
xi.dynamis.mobList[zoneID][121].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (121-O/S)
xi.dynamis.mobList[zoneID][122].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (122-O/S)
xi.dynamis.mobList[zoneID][123].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (123-O/S)
xi.dynamis.mobList[zoneID][124].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (124-O/S)
xi.dynamis.mobList[zoneID][125].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (125-O/S)
xi.dynamis.mobList[zoneID][126].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (126-O/S)
xi.dynamis.mobList[zoneID][127].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (127-O/S)
xi.dynamis.mobList[zoneID][128].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (128-O/S)
xi.dynamis.mobList[zoneID][129].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (129-O/S)
xi.dynamis.mobList[zoneID][130].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (130-O/S)
xi.dynamis.mobList[zoneID][131].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (131-O/S)
xi.dynamis.mobList[zoneID][132].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (132-O/S)
xi.dynamis.mobList[zoneID][133].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (133-O/S)
xi.dynamis.mobList[zoneID][134].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (134-O/S)
xi.dynamis.mobList[zoneID][135].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (135-O/S)
xi.dynamis.mobList[zoneID][136].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (136-O/S)
xi.dynamis.mobList[zoneID][137].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (137-O/S)
xi.dynamis.mobList[zoneID][138].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (138-O/S)
xi.dynamis.mobList[zoneID][139].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (139-O/S)
xi.dynamis.mobList[zoneID][140].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (140-O/S)
xi.dynamis.mobList[zoneID][141].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (141-O/S)
xi.dynamis.mobList[zoneID][142].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (142-O/S)
xi.dynamis.mobList[zoneID][143].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (143-O/S)
xi.dynamis.mobList[zoneID][144].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (144-O/S)
xi.dynamis.mobList[zoneID][145].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (145-O/S)
xi.dynamis.mobList[zoneID][146].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (146-O/S)
xi.dynamis.mobList[zoneID][147].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (147-O/S)
xi.dynamis.mobList[zoneID][148].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (148-O/S)
xi.dynamis.mobList[zoneID][149].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (149-O/S)
xi.dynamis.mobList[zoneID][150].info = {"Statue", "Serjeant Tombstone", nil, nil, nil} -- (150-O/S)

-- NM's and Megaboss
xi.dynamis.mobList[zoneID][109].info = {"NM", "Overlord's Tombstone",     nil,   nil,    "MegaBoss_Killed" } -- ( 109 ) Overlord's Tombstone
xi.dynamis.mobList[zoneID][151].info = {"NM", "Wyrmgnasher Bjakdek",      "Orc", "DRG",  "Wyrmgnasher_Bjakdek_Killed"} -- DRG NM
xi.dynamis.mobList[zoneID][152].info = {"NM", "Reapertongue Gadgquok",    "Orc", "SMN",  "Reapertongue_Gadgquok_Killed"} -- SMN NM
xi.dynamis.mobList[zoneID][153].info = {"NM", "Voidstreaker Butchnotch",  "Orc", "NIN",  "Voidstreaker_Butchnotch_Killed"} -- NIN NM
xi.dynamis.mobList[zoneID][154].info = {"NM", "Battlechoir Gitchfotch",   "Orc", "BRD",  nil} -- BRD NM
xi.dynamis.mobList[zoneID][155].info = {"NM", "Soulsender Fugbrag",       "Orc", "BRD",  nil} -- BRD NM

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
    {"Voidstreaker_Butchnotch_Killed"},
    {"MegaBoss_Killed"},
    {"Wyrmgnasher_Bjakdek_Killed", "Reapertongue_Gadgquok_Killed"},
    {"Wyrmgnasher_Bjakdek_Killed"},
    {"Reapertongue_Gadgquok_Killed"}
}

------------------------------------------
--            Wave Spawning             --
-- Note: Wave 1 spawns at start.        --
------------------------------------------
--xi.dynamis.mobList[zoneID][MobIndex].waves = { 1,nil,nil }

-- Wave 1 Spawns on loading the zone

xi.dynamis.mobList[zoneID][1].wave =
{
    1  ,    -- (001-O/S)  Serjeant Tombstone
    2  ,    -- (002-O/S)  Serjeant Tombstone
    3  ,    -- (003-O/S)  Serjeant Tombstone
    4  ,    -- (004-O/S)  Serjeant Tombstone
    5  ,    -- (005-O/S)  Serjeant Tombstone
    6  ,    -- (006-O/W)  Serjeant Tombstone
    7  ,    -- (007-O/S)  Serjeant Tombstone
    8  ,    -- (008-O/S)  Serjeant Tombstone
    9  ,    -- (009-O/S)  Serjeant Tombstone
    10 ,    -- (010-O/W)  Serjeant Tombstone
    11 ,    -- (011-O/S)  Serjeant Tombstone
    12 ,    -- (012-O/W)  Serjeant Tombstone
    13 ,    -- (013-O/S)  Serjeant Tombstone
    14 ,    -- (014-O/W)  Serjeant Tombstone
    15 ,    -- (015-O/W)  Serjeant Tombstone
    16 ,    -- (016-O/S)  Serjeant Tombstone
    17 ,    -- (017-O/S)  Serjeant Tombstone
    18 ,    -- (018-O/S)  Serjeant Tombstone
    20 ,    -- (020-O/S)  Serjeant Tombstone
    22 ,    -- (022-O/S)  Serjeant Tombstone
    23 ,    -- (023-O/S)  Serjeant Tombstone
    24 ,    -- (024-O/S)  Serjeant Tombstone
    25 ,    -- (025-O/S)  Serjeant Tombstone
    26 ,    -- (026-O/S)  Serjeant Tombstone
    27 ,    -- (027-O/S)  Serjeant Tombstone
    28 ,    -- (028-O/S)  Serjeant Tombstone
    29 ,    -- (029-O/S)  Serjeant Tombstone
    30 ,    -- (030-O/S)  Serjeant Tombstone
    31 ,    -- (031-O/S)  Serjeant Tombstone
    32 ,    -- (032-O/W)  Serjeant Tombstone
    33 ,    -- (033-O/S)  Serjeant Tombstone
    34 ,    -- (034-O/W)  Serjeant Tombstone
    35 ,    -- (035-O/W)  Serjeant Tombstone
    37 ,    -- (037-O/S)  Serjeant Tombstone
    38 ,    -- (038-O/W)  Serjeant Tombstone
    39 ,    -- (039-O/S)  Serjeant Tombstone
    40 ,    -- (040-O/S)  Serjeant Tombstone
    41 ,    -- (041-O/S)  Serjeant Tombstone
    42 ,    -- (042-O/S)  Serjeant Tombstone
    43 ,    -- (043-O/S)  Serjeant Tombstone
    44 ,    -- (044-O/W)  Serjeant Tombstone
    45 ,    -- (045-O/S)  Serjeant Tombstone
    46 ,    -- (046-O/S)  Serjeant Tombstone
    47 ,    -- (047-O/W)  Serjeant Tombstone
    48 ,    -- (048-O/S)  Serjeant Tombstone
    49 ,    -- (049-O/S)  Serjeant Tombstone
    50 ,    -- (050-O/S)  Serjeant Tombstone
    51 ,    -- (051-O/S)  Serjeant Tombstone
    52 ,    -- (052-O/W)  Serjeant Tombstone
    53 ,    -- (053-O/S)  Serjeant Tombstone
    54 ,    -- (054-O/S)  Serjeant Tombstone
    55 ,    -- (055-O/S)  Serjeant Tombstone
    56 ,    -- (056-O/S)  Serjeant Tombstone
    57 ,    -- (057-O/S)  Serjeant Tombstone
    58 ,    -- (058-O/S)  Serjeant Tombstone
    59 ,    -- (059-O/W)  Serjeant Tombstone
    60 ,    -- (060-O/W)  Serjeant Tombstone
    61 ,    -- (061-O/S)  Serjeant Tombstone
    62 ,    -- (062-O/W)  Serjeant Tombstone
    63 ,    -- (063-O/S)  Serjeant Tombstone
    64 ,    -- (064-O/S)  Serjeant Tombstone
    65 ,    -- (065-O/S)  Serjeant Tombstone
    66 ,    -- (066-O/S)  Serjeant Tombstone
    67 ,    -- (067-O/S)  Serjeant Tombstone
    68 ,    -- (068-O/S)  Serjeant Tombstone
    69 ,    -- (069-O/S)  Serjeant Tombstone
    70 ,    -- (070-O/W)  Serjeant Tombstone
    71 ,    -- (071-O/S)  Serjeant Tombstone
    72 ,    -- (072-O/W)  Serjeant Tombstone
    73 ,    -- (073-O/S)  Serjeant Tombstone
    74 ,    -- (074-O/W)  Serjeant Tombstone
    75 ,    -- (075-O/S)  Serjeant Tombstone
    76 ,    -- (076-O/W)  Serjeant Tombstone
    77 ,    -- (077-O/S)  Serjeant Tombstone
    78 ,    -- (078-O/W)  Serjeant Tombstone
    79 ,    -- (079-O/W)  Serjeant Tombstone
    80 ,    -- (080-O/S)  Serjeant Tombstone
    81 ,    -- (081-O/W)  Serjeant Tombstone
    82 ,    -- (082-O/S)  Serjeant Tombstone
    83 ,    -- (083-O/W)  Serjeant Tombstone
    84 ,    -- (084-O/W)  Serjeant Tombstone
    85 ,    -- (085-O/W)  Serjeant Tombstone
    86 ,    -- (086-O/W)  Serjeant Tombstone
    87 ,    -- (087-O/S)  Serjeant Tombstone
    88 ,    -- (088-O/S)  Serjeant Tombstone
    89 ,    -- (089-O/S)  Serjeant Tombstone
    90 ,    -- (090-O/S)  Serjeant Tombstone
    91 ,    -- (091-O/W)  Serjeant Tombstone
    92 ,    -- (092-O/W)  Serjeant Tombstone
    93 ,    -- (093-O/S)  Serjeant Tombstone
    96 ,    -- (096-O/S)  Serjeant Tombstone
    97 ,    -- (097-O/W)  Serjeant Tombstone
    98 ,    -- (098-O/S)  Serjeant Tombstone
    99 ,    -- (099-O/S)  Serjeant Tombstone
    102,    -- (102-O/S)  Serjeant Tombstone
    103,    -- (103-O/W)  Serjeant Tombstone
    104,    -- (104-O/W)  Serjeant Tombstone
    105,    -- (105-O/S)  Serjeant Tombstone
    106,    -- (106-O/S)  Serjeant Tombstone
    107,    -- (107-O/W)  Serjeant Tombstone
    108     -- (108-O/W)  Serjeant Tombstone
}

-- Wave 2 spawns when Voidstreaker Butchnotch (NIN) is defeated
xi.dynamis.mobList[zoneID][2].wave =
{
    145,	-- (145-O/S)  Serjeant Tombstone
    146,	-- (146-O/S)  Serjeant Tombstone
    147,	-- (147-O/S)  Serjeant Tombstone
    149	    -- (149-O/S)  Serjeant Tombstone
}

-- Wave 3 spawns when Overlord's Tombstone (Mega Boss) is defeated
xi.dynamis.mobList[zoneID][3].wave =
{
    116,    -- (116-O/S)  Serjeant Tombstone
    117,    -- (117-O/S)  Serjeant Tombstone
    118,    -- (118-O/S)  Serjeant Tombstone
    119,    -- (119-O/S)  Serjeant Tombstone
    120,    -- (120-O/S)  Serjeant Tombstone
    121,    -- (121-O/S)  Serjeant Tombstone
    122,    -- (122-O/S)  Serjeant Tombstone
    123,    -- (123-O/S)  Serjeant Tombstone
    124,    -- (124-O/S)  Serjeant Tombstone
    125,    -- (125-O/S)  Serjeant Tombstone
    126,    -- (126-O/S)  Serjeant Tombstone
    127,    -- (127-O/S)  Serjeant Tombstone
    128,    -- (128-O/S)  Serjeant Tombstone
    129,    -- (129-O/S)  Serjeant Tombstone
    130,    -- (130-O/S)  Serjeant Tombstone
    131,    -- (131-O/S)  Serjeant Tombstone
    132,    -- (132-O/S)  Serjeant Tombstone
    133,    -- (133-O/S)  Serjeant Tombstone
    134,    -- (134-O/S)  Serjeant Tombstone
    135,    -- (135-O/S)  Serjeant Tombstone
    136,    -- (136-O/S)  Serjeant Tombstone
    137,    -- (137-O/S)  Serjeant Tombstone
    138,    -- (138-O/S)  Serjeant Tombstone
    139,    -- (139-O/S)  Serjeant Tombstone
    140,    -- (140-O/S)  Serjeant Tombstone
}

-- Kill of Wyrmgnasher Bjakdek and Reapertongue Gadgquok to spawn Overlords Tombstone
xi.dynamis.mobList[zoneID][4].wave =
{
    109     -- 109-Replica NM (Overlord's Tombstone)
}

-- Two statues spawn near entrance and opposite tent when Wyrmgnasher Bjakdek is killed

xi.dynamis.mobList[zoneID][5].wave =
{
    61,     -- (061-O/S)  Serjeant Tombstone
    143,    -- (143-O/S)  Serjeant Tombstone
    144     -- (144-O/S)  Serjeant Tombstone
}

-- Two statues spawn near entrance and opposite tent when Reapertongue Gadgquok is killed
xi.dynamis.mobList[zoneID][6].wave =
{
    36,     -- (036-O/S)  Serjeant Tombstone
    141,    -- (141-O/S)  Serjeant Tombstone
    142     -- (142-O/S)  Serjeant Tombstone
}

----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

xi.dynamis.mobList[zoneID][1  ].mobchildren = { 2,   nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR
xi.dynamis.mobList[zoneID][2  ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 MNK
xi.dynamis.mobList[zoneID][3  ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 MNK
xi.dynamis.mobList[zoneID][4  ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 RDM
xi.dynamis.mobList[zoneID][5  ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 RDM
xi.dynamis.mobList[zoneID][6  ].mobchildren = { nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 MNK
xi.dynamis.mobList[zoneID][8  ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil  } -- 1 PLD, 1 DRK
xi.dynamis.mobList[zoneID][9  ].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR
xi.dynamis.mobList[zoneID][10 ].mobchildren = { nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 RDM
xi.dynamis.mobList[zoneID][11 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  } -- 2 DRG
xi.dynamis.mobList[zoneID][12 ].mobchildren = { nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WHM
xi.dynamis.mobList[zoneID][13 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 THF
xi.dynamis.mobList[zoneID][14 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
xi.dynamis.mobList[zoneID][15 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  } -- 2 SAM
xi.dynamis.mobList[zoneID][17 ].mobchildren = { nil,   1, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 MNK, 2 BLM
xi.dynamis.mobList[zoneID][19 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } -- 2 BLM, 1 BST
xi.dynamis.mobList[zoneID][21 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   2, nil, nil, nil, nil  } -- 1 PLD, 2 RNG
xi.dynamis.mobList[zoneID][22 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 THF
xi.dynamis.mobList[zoneID][23 ].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM, 1 BLM
xi.dynamis.mobList[zoneID][24 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 THF
xi.dynamis.mobList[zoneID][28 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 THF, 1 BRD
xi.dynamis.mobList[zoneID][29 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 THF, 1 BRD
xi.dynamis.mobList[zoneID][29 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 2 RNG
xi.dynamis.mobList[zoneID][30 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 THF, 1 BRD
xi.dynamis.mobList[zoneID][30 ].mobchildren = { nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WHM
xi.dynamis.mobList[zoneID][32 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  } -- 2 DRK
xi.dynamis.mobList[zoneID][36 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 2 THF, 1 BRD
xi.dynamis.mobList[zoneID][37 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  } -- 2 SAM
xi.dynamis.mobList[zoneID][38 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 BST
xi.dynamis.mobList[zoneID][39 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 2 RNG
xi.dynamis.mobList[zoneID][40 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
xi.dynamis.mobList[zoneID][41 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
xi.dynamis.mobList[zoneID][42 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
xi.dynamis.mobList[zoneID][43 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
xi.dynamis.mobList[zoneID][44 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
xi.dynamis.mobList[zoneID][45 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 2 RNG
xi.dynamis.mobList[zoneID][46 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
xi.dynamis.mobList[zoneID][47 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 BST
xi.dynamis.mobList[zoneID][48 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  } -- 2 SAM
xi.dynamis.mobList[zoneID][49 ].mobchildren = {   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WAR, 1 MNK
xi.dynamis.mobList[zoneID][50 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM
xi.dynamis.mobList[zoneID][51 ].mobchildren = {   2, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR, 1 PLD
xi.dynamis.mobList[zoneID][52 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 2 RNG
xi.dynamis.mobList[zoneID][53 ].mobchildren = {   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WAR, 1 MNK
xi.dynamis.mobList[zoneID][54 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM
xi.dynamis.mobList[zoneID][55 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM
xi.dynamis.mobList[zoneID][56 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 THF
xi.dynamis.mobList[zoneID][57 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM
xi.dynamis.mobList[zoneID][58 ].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 PLD
xi.dynamis.mobList[zoneID][61 ].mobchildren = { nil,   2, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 2 MNK, 1 BRD
xi.dynamis.mobList[zoneID][66 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  } -- 2 DRK
xi.dynamis.mobList[zoneID][67 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  } -- 2 DRG
xi.dynamis.mobList[zoneID][68 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 BST
xi.dynamis.mobList[zoneID][69 ].mobchildren = { nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 RDM
xi.dynamis.mobList[zoneID][70 ].mobchildren = { nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 MNK
xi.dynamis.mobList[zoneID][71 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 BLM
xi.dynamis.mobList[zoneID][73 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  } -- 2 SAM
xi.dynamis.mobList[zoneID][74 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil  } -- 1 SAM, 1 NIN
xi.dynamis.mobList[zoneID][75 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
xi.dynamis.mobList[zoneID][76 ].mobchildren = { nil, nil,   2, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil  } -- 2 WHM, 3 RNG
xi.dynamis.mobList[zoneID][77 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  } -- 2 DRK
xi.dynamis.mobList[zoneID][78 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 BLM
xi.dynamis.mobList[zoneID][79 ].mobchildren = { nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WHM
xi.dynamis.mobList[zoneID][80 ].mobchildren = { nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 RDM
xi.dynamis.mobList[zoneID][81 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 BST
xi.dynamis.mobList[zoneID][82 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } -- 1 BST
xi.dynamis.mobList[zoneID][83 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 BST
xi.dynamis.mobList[zoneID][85 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 BST
xi.dynamis.mobList[zoneID][87 ].mobchildren = { nil, nil, nil,   2,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 BLM, 2 RDM
xi.dynamis.mobList[zoneID][88 ].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 PLD
xi.dynamis.mobList[zoneID][89 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil  } -- 3 RNG
xi.dynamis.mobList[zoneID][90 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  } -- 2 DRK
xi.dynamis.mobList[zoneID][91 ].mobchildren = {   2, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR, 1 RDM
xi.dynamis.mobList[zoneID][92 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil  } -- 2 BRD
xi.dynamis.mobList[zoneID][94 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
xi.dynamis.mobList[zoneID][95 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
xi.dynamis.mobList[zoneID][96 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  } -- 2 DRG
xi.dynamis.mobList[zoneID][97 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 2 RNG
xi.dynamis.mobList[zoneID][98 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  } -- 2 DRG
xi.dynamis.mobList[zoneID][100].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 BRD
xi.dynamis.mobList[zoneID][101].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 BRD
xi.dynamis.mobList[zoneID][102].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  } -- 2 WAR, 2 DRG
xi.dynamis.mobList[zoneID][104].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 PLD
xi.dynamis.mobList[zoneID][105].mobchildren = { nil, nil, nil, nil,   2, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  } -- 2 RDM, 2 DRK
xi.dynamis.mobList[zoneID][106].mobchildren = {   2, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR, 2 PLD
xi.dynamis.mobList[zoneID][107].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
xi.dynamis.mobList[zoneID][108].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  } -- 2 SAM
xi.dynamis.mobList[zoneID][109].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR
xi.dynamis.mobList[zoneID][110].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, } -- 3 SMN
xi.dynamis.mobList[zoneID][111].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil  } -- 3 DRG
xi.dynamis.mobList[zoneID][116].mobchildren = { nil, nil, nil,   2, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil  } -- 2 BLM, 3 DRK
xi.dynamis.mobList[zoneID][117].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil  } -- 3 BST
xi.dynamis.mobList[zoneID][118].mobchildren = { nil, nil, nil, nil,   2, nil, nil, nil, nil,   2, nil,   2, nil, nil, nil  } -- 2 RDM, 2 BRD, 2 SAM
xi.dynamis.mobList[zoneID][119].mobchildren = { nil, nil, nil, nil, nil,   2,   3, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 THF, 3 PLD
xi.dynamis.mobList[zoneID][120].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil  } -- 3 DRG
xi.dynamis.mobList[zoneID][121].mobchildren = {   2, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR, 2 WHM
xi.dynamis.mobList[zoneID][122].mobchildren = { nil,   3,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 MNK, 2 WHM
xi.dynamis.mobList[zoneID][123].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil,   2, } -- 2 BRD, 2 SMN
xi.dynamis.mobList[zoneID][124].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
xi.dynamis.mobList[zoneID][125].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil  } -- 3 DRG
xi.dynamis.mobList[zoneID][126].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   4, nil, nil  } -- 4 NIN
xi.dynamis.mobList[zoneID][127].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil  } -- 3 SAM
xi.dynamis.mobList[zoneID][128].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil  } -- 3 RNG
xi.dynamis.mobList[zoneID][129].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil  } -- 3 BRD
xi.dynamis.mobList[zoneID][130].mobchildren = { nil, nil, nil, nil, nil,   3, nil, nil, nil,   2, nil, nil, nil, nil, nil  } -- 3 THF, 2 BRD
xi.dynamis.mobList[zoneID][131].mobchildren = { nil, nil, nil,   2,   2, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  } -- 2 BLM, 2 RDM, 2 SAM
xi.dynamis.mobList[zoneID][132].mobchildren = { nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 THF
xi.dynamis.mobList[zoneID][133].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil  } -- 3 BST
xi.dynamis.mobList[zoneID][134].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil  } -- 3 DRK
xi.dynamis.mobList[zoneID][135].mobchildren = { nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 PLD
xi.dynamis.mobList[zoneID][136].mobchildren = { nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 RDM
xi.dynamis.mobList[zoneID][137].mobchildren = { nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 WHM
xi.dynamis.mobList[zoneID][138].mobchildren = { nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 MNK
xi.dynamis.mobList[zoneID][139].mobchildren = {   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 WAR
xi.dynamis.mobList[zoneID][140].mobchildren = { nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 BLM
xi.dynamis.mobList[zoneID][141].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 SAM
xi.dynamis.mobList[zoneID][142].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 SAM
xi.dynamis.mobList[zoneID][143].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 MNK
xi.dynamis.mobList[zoneID][144].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 MNK
xi.dynamis.mobList[zoneID][145].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil  } -- 3 DRK
xi.dynamis.mobList[zoneID][146].mobchildren = { nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil  } -- 3 PLD
xi.dynamis.mobList[zoneID][147].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
xi.dynamis.mobList[zoneID][149].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].nmchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

--Specific Statues
xi.dynamis.mobList[zoneID][18 ].nmchildren = { false, 19 }                   -- Squire Square N, Spawns another statue
xi.dynamis.mobList[zoneID][20 ].nmchildren = { false, 21 }                   -- Squire Square E, Spawns another statue
xi.dynamis.mobList[zoneID][99 ].nmchildren = { true,  100, 101 }             -- Courtyard/WD Alley connector +2 stats
xi.dynamis.mobList[zoneID][147].nmchildren = { false, 148 }                  -- West Tent spawns one middle statue
xi.dynamis.mobList[zoneID][149].nmchildren = { false, 150 }                  -- East Tent spawns one middle statue

-- NMs
xi.dynamis.mobList[zoneID][32 ].nmchildren = { true, 151 }                                    -- Eastgate NM Wyrmgnasher Bjakdek (DRG)
xi.dynamis.mobList[zoneID][70 ].nmchildren = { true, 152 }                                    -- Westgate NM Reapertongue Gadguok (SMN)
xi.dynamis.mobList[zoneID][93 ].nmchildren = { true, 153, 94, 95 }                            -- Manor NM Voidstreaker Butchnotch (NIN) as well as N/S manor pop statues
xi.dynamis.mobList[zoneID][109].nmchildren = { true, 154, 155, 110, 111, 112, 113, 114, 115 } -- Megaboss spawns twin BRD NMs Battlechoir Gitchfotch and Soulsender Fugbrag and a bunch of statues

------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].pos = {xpos, ypos, zpos, rot}

xi.dynamis.mobList[zoneID][1  ].pos = {  137.0790, -2.0000,  105.1504, 225   } -- Residential Area
xi.dynamis.mobList[zoneID][2  ].pos = {  116.4000,  0.0000,   91.6443, 225   } -- Lion Square Fount. N
xi.dynamis.mobList[zoneID][3  ].pos = {  123.5808,  0.0000,   84.2734, 225   } -- Lion Square Fount. E
xi.dynamis.mobList[zoneID][4  ].pos = {  112.5138,  0.0000,   87.5595, 225   } -- Lion Square Fount. W
xi.dynamis.mobList[zoneID][5  ].pos = {  119.8963,  0.0000,   80.3786, 225   } -- Lion Square Fount. S
xi.dynamis.mobList[zoneID][6  ].pos = {  100.0876,  1.0000,  103.6861, 32    } -- Lion Tavern
xi.dynamis.mobList[zoneID][7  ].pos = {  104.0628,  1.9165,   72.0631, 226   } -- on stair, SW of Lion Squ
xi.dynamis.mobList[zoneID][8  ].pos = {   98.8329,  4.0000,   68.6029, 255   } -- Helbort's Blades N
xi.dynamis.mobList[zoneID][9  ].pos = {   93.7486,  4.0000,   56.9143, 255   } -- Helbort's Blades S
xi.dynamis.mobList[zoneID][10 ].pos = {  101.2500,  4.0000,   50.0912, 160   } -- Door Across Helbort's Bl
xi.dynamis.mobList[zoneID][11 ].pos = {   94.8431,  4.0000,   38.0928, 1     } -- Rosel's Armour
xi.dynamis.mobList[zoneID][12 ].pos = {  101.4410,  4.0000,   32.0477, 151   } -- Door Across Rosel's Armo
xi.dynamis.mobList[zoneID][13 ].pos = {   97.8056,  4.0000,   45.2697, 194   } -- Alleyway, Btw. Wep+Armor
xi.dynamis.mobList[zoneID][14 ].pos = {  112.9542,  2.0000,   14.0701, 127   } -- Sq.Alley SW2
xi.dynamis.mobList[zoneID][15 ].pos = {  130.5417,  0.0000,   14.2169, 127   } -- Sq.Alley SW
xi.dynamis.mobList[zoneID][16 ].pos = {  143.5072,  0.0000,   27.3608, 94    } -- Sq.Alley S
xi.dynamis.mobList[zoneID][17 ].pos = {  147.7160,  0.0000,   42.0697, 177   } -- Sq.Alley C
xi.dynamis.mobList[zoneID][18 ].pos = {  140.8978,  0.0000,   55.7513, 165   } -- Sq.Alley N
xi.dynamis.mobList[zoneID][19 ].pos = {  142.4358,  0.0000,   69.3664, 70    } -- Sq.Alley Under Staircase
xi.dynamis.mobList[zoneID][20 ].pos = {  144.9005,  0.0000,   59.3423, 161   } -- Sq.Alley Northern Bldg.
xi.dynamis.mobList[zoneID][21 ].pos = {  156.4780, -1.0000,   41.9830, 128   } -- Sq.Alley Eastern Bldg.
xi.dynamis.mobList[zoneID][22 ].pos = {   79.7930,  2.0000,   12.7828, 33    } -- Cavalry Way Stair W
xi.dynamis.mobList[zoneID][23 ].pos = {   86.0373,  2.0000,    6.8098, 224   } -- Cavalry Way Stair C
xi.dynamis.mobList[zoneID][24 ].pos = {   93.6929,  2.0000,   -0.2982, 158   } -- Cavalry Way Stair E
xi.dynamis.mobList[zoneID][25 ].pos = {   76.0000,  2.0000,   -4.0000, 160   } -- Eastgate Outside E
xi.dynamis.mobList[zoneID][26 ].pos = {   68.0000,  2.0000,  -12.0000, 160   } -- Eastgate Outside C
xi.dynamis.mobList[zoneID][27 ].pos = {   60.0000,  2.0000,  -20.0000, 160   } -- Eastgate Outside W
xi.dynamis.mobList[zoneID][28 ].pos = {   92.3483,  2.0000,  -20.5081, 160   } -- Eastgate Arches E
xi.dynamis.mobList[zoneID][29 ].pos = {   83.9514,  2.0000,  -28.2492, 160   } -- Eastgate Arches C
xi.dynamis.mobList[zoneID][30 ].pos = {   76.0243,  2.0000,  -36.1443, 160   } -- Eastgate Arches W
xi.dynamis.mobList[zoneID][31 ].pos = {  100.0918,  1.0000,  -36.0744, 154   } -- Eastgate E
xi.dynamis.mobList[zoneID][32 ].pos = {   97.2104,  1.0000,  -41.3545, 160   } -- Eastgate C
xi.dynamis.mobList[zoneID][33 ].pos = {   92.1923,  1.0000,  -44.0674, 166   } -- Eastgate W
xi.dynamis.mobList[zoneID][34 ].pos = {   85.4025,  1.0000,  -70.3379, 188   } -- Eastgate Far Corner
xi.dynamis.mobList[zoneID][35 ].pos = {   55.7694, -8.6001,  -30.0464, 192   } -- W of Eastgate Entrance
xi.dynamis.mobList[zoneID][36 ].pos = {   67.5852,  2.0000,   -3.5269, 32    } -- W2 Btw. Street Vendors b
xi.dynamis.mobList[zoneID][37 ].pos = {   40.0124,  2.0000,  -29.8986, 232   } -- Near AH: Choco Tunnel E
xi.dynamis.mobList[zoneID][38 ].pos = {   28.0243,  2.0000,  -18.3093, 64    } -- Near AH: E Tent
xi.dynamis.mobList[zoneID][39 ].pos = {   20.0000,  2.0000,    5.0000, 64    } -- Victory Square SE
xi.dynamis.mobList[zoneID][40 ].pos = {   20.0000,  0.0000,   24.0000, 64    } -- Victory Square NE
xi.dynamis.mobList[zoneID][41 ].pos = {    0.0000,  0.5000,   13.0000, 64    } -- Victory Square Main Path
xi.dynamis.mobList[zoneID][42 ].pos = {    5.0000,  0.0000,   22.0000, 64    } -- Victory Square Main Path
xi.dynamis.mobList[zoneID][43 ].pos = {   -5.0000,  0.0000,   22.0000, 64    } -- Victory Square Main Path
xi.dynamis.mobList[zoneID][44 ].pos = {   -0.0834,  2.0000,   -8.9377, 64    } -- Near AH: Between Tents
xi.dynamis.mobList[zoneID][45 ].pos = {  -20.0000,  0.0000,   24.0000, 64    } -- Victory Square NW
xi.dynamis.mobList[zoneID][46 ].pos = {  -20.0000,  2.0000,    5.0000, 64    } -- Victory Square SW
xi.dynamis.mobList[zoneID][47 ].pos = {  -28.0377,  2.0000,  -17.1347, 64    } -- Near AH: W Tent
xi.dynamis.mobList[zoneID][48 ].pos = {  -39.8505,  2.0000,  -29.8840, 150   } -- Near AH: Choco Tunnel W
xi.dynamis.mobList[zoneID][49 ].pos = {  -13.9513,  1.7000,  -29.0579, 192   } -- AH: W
xi.dynamis.mobList[zoneID][50 ].pos = {  -11.0031, -3.0000,  -33.8110, 192   } -- AH: Atop W
xi.dynamis.mobList[zoneID][51 ].pos = {   -0.0485,  1.7000,  -25.1019, 192   } -- AH: C
xi.dynamis.mobList[zoneID][52 ].pos = {   -1.0120, -3.0000,  -35.0168, 192   } -- AH: Atop C
xi.dynamis.mobList[zoneID][53 ].pos = {   14.0580,  1.7000,  -28.4680, 192   } -- AH: E
xi.dynamis.mobList[zoneID][54 ].pos = {   11.0112, -3.0000,  -33.8374, 192   } -- AH: Atop E
xi.dynamis.mobList[zoneID][55 ].pos = {  -12.3592,  2.0000,  -73.7705, 249   } -- Choco Stable W
xi.dynamis.mobList[zoneID][56 ].pos = {   -7.7872,  2.0000,  -80.4531, 240   } -- Choco Stable S
xi.dynamis.mobList[zoneID][57 ].pos = {    5.4815,  2.0000,  -74.6288, 241   } -- Choco Stable E
xi.dynamis.mobList[zoneID][58 ].pos = {    6.3619,  2.2000,  -86.8097, 161   } -- Choco Stable Gate
xi.dynamis.mobList[zoneID][59 ].pos = {   18.1228,  2.2000,  -96.3732, 192   } -- Choco Stable Grass W
xi.dynamis.mobList[zoneID][60 ].pos = {   23.1852,  2.2000,  -96.2487, 192   } -- Choco Stable Grass E
xi.dynamis.mobList[zoneID][61 ].pos = {  -66.9165,  2.0000,   -3.3724, 96    } -- Between Street Vendors b
xi.dynamis.mobList[zoneID][62 ].pos = {  -55.8101, -8.6000,  -30.2507, 192   } -- E of Westgate Entrance
xi.dynamis.mobList[zoneID][63 ].pos = {  -72.0000,  2.0000,  -32.0000, 224   } -- Westgate Outside E
xi.dynamis.mobList[zoneID][64 ].pos = {  -68.0000,  2.0000,  -12.0000, 224   } -- Westgate Outside C
xi.dynamis.mobList[zoneID][65 ].pos = {  -88.0000,  2.0000,  -16.0000, 224   } -- Westgate Outside W
xi.dynamis.mobList[zoneID][66 ].pos = {  -78.5584,  2.0000,  -38.5455, 224   } -- Westgate Arches E
xi.dynamis.mobList[zoneID][67 ].pos = {  -86.5756,  2.0000,  -30.6161, 224   } -- Westgate Arches C
xi.dynamis.mobList[zoneID][68 ].pos = {  -94.4234,  2.0000,  -22.1406, 224   } -- Westgate Arches W
xi.dynamis.mobList[zoneID][69 ].pos = {  -91.8674,  1.0000,  -44.1162, 224   } -- Westgate E
xi.dynamis.mobList[zoneID][70 ].pos = {  -97.3463,  1.0000,  -41.3016, 224   } -- Westgate C
xi.dynamis.mobList[zoneID][71 ].pos = { -100.0368,  1.0000,  -36.6710, 224   } -- Westgate W
xi.dynamis.mobList[zoneID][72 ].pos = { -127.4794,  1.0000,  -29.5681, 5     } -- Westgate Far Corner
xi.dynamis.mobList[zoneID][73 ].pos = {  -92.8513, -2.0000,   22.3543, 32    } -- Stairs to W District E
xi.dynamis.mobList[zoneID][74 ].pos = {  -97.5497, -2.0000,   17.4388, 32    } -- Stairs to W District C
xi.dynamis.mobList[zoneID][75 ].pos = { -103.0301, -2.0000,   12.5769, 32    } -- Stairs to W District W
xi.dynamis.mobList[zoneID][76 ].pos = { -111.2418, -2.0000,   30.9008, 32    } -- Raimbroy's Grocery
xi.dynamis.mobList[zoneID][77 ].pos = { -114.0525, -2.0000,   16.5393, 12    } -- Guarding Entr. to Atop W
xi.dynamis.mobList[zoneID][78 ].pos = { -130.7194, -2.0000,   18.6867, 247   } -- Between Raimbroy's and T
xi.dynamis.mobList[zoneID][79 ].pos = { -141.3845, -2.0000,   18.2596, 0     } -- Taumila's Sundries
xi.dynamis.mobList[zoneID][80 ].pos = { -156.1573, -2.2000,   25.2480, 65    } -- Entrance to Raimbroy's C
xi.dynamis.mobList[zoneID][81 ].pos = { -174.8346, -1.0000,   24.6105, 217   } -- LW Guild E
xi.dynamis.mobList[zoneID][82 ].pos = { -175.0301, -1.5000,   36.6927, 95    } -- Across LW Guild
xi.dynamis.mobList[zoneID][83 ].pos = { -186.9280, -1.0000,   37.5468, 237   } -- LW Guild W
xi.dynamis.mobList[zoneID][84 ].pos = { -172.7534, -8.8000,   15.4853, 190   } -- LW Guild Catwalks S
xi.dynamis.mobList[zoneID][85 ].pos = { -184.4630, -1.0000,   27.4167, 224   } -- LW Guild C
xi.dynamis.mobList[zoneID][86 ].pos = { -196.5302, -8.8000,   39.1053, 251   } -- LW Guild Catwalks N
xi.dynamis.mobList[zoneID][87 ].pos = { -194.0204, -1.5000,   57.7439, 63    } -- Pikeman's Way S
xi.dynamis.mobList[zoneID][88 ].pos = { -193.5726, -2.0000,   68.4073, 63    } -- Pikeman's Way C
xi.dynamis.mobList[zoneID][89 ].pos = { -187.3062, -8.8000,   84.3538, 53    } -- Pikeman's Way Catwalks
xi.dynamis.mobList[zoneID][90 ].pos = { -203.9909, -2.0000,   88.3699, 33    } -- Pikeman's Way N
xi.dynamis.mobList[zoneID][91 ].pos = { -221.7831, -2.0000,   98.2201, 0     } -- Path to Manor
xi.dynamis.mobList[zoneID][92 ].pos = { -240.9783, -4.0000,   98.0767, 0     } -- Stairs to Manor
xi.dynamis.mobList[zoneID][93 ].pos = { -268.0030, -4.0000,   97.9851, 0     } -- Manor
xi.dynamis.mobList[zoneID][94 ].pos = { -257.8550, -3.6000,  117.6251, 51    } -- Manor Pop N
xi.dynamis.mobList[zoneID][95 ].pos = { -257.8173, -3.6000,   82.3046, 207   } -- Manor Pop S
xi.dynamis.mobList[zoneID][96 ].pos = { -166.8674, -2.0000,   54.1991, 142   } -- Courtyard SW
xi.dynamis.mobList[zoneID][97 ].pos = { -159.2271, -2.0000,   67.6593, 113   } -- Courtyard N
xi.dynamis.mobList[zoneID][98 ].pos = { -152.3566, -2.0000,   54.9211, 133   } -- Courtyard SE
xi.dynamis.mobList[zoneID][99 ].pos = { -132.2272, -4.0000,   70.2963, 64    } -- Courtyard to WD Alley Co
xi.dynamis.mobList[zoneID][100].pos = { -132.1907, -4.5000,   74.1945, 64    } -- Back of Watchdog Alley #
xi.dynamis.mobList[zoneID][101].pos = { -132.1623, -5.2500,   77.2359, 64    } -- Back of Watchdog Alley #
xi.dynamis.mobList[zoneID][102].pos = { -139.4806, -6.0000,   90.0122, 3     } -- Watchdog Alley Catwalk E
xi.dynamis.mobList[zoneID][103].pos = { -125.7547, -6.0000,   89.0013, 10    } -- Watchdog Alley NW
xi.dynamis.mobList[zoneID][104].pos = { -137.6403,-10.8000,   65.0534, 32    } -- Courtyard Catwalk
xi.dynamis.mobList[zoneID][105].pos = { -110.3660, -6.0000,   86.0028, 24    } -- Watchdog Alley N
xi.dynamis.mobList[zoneID][106].pos = {  -94.2479, -6.0000,   74.2410, 57    } -- Watchdog Alley C
xi.dynamis.mobList[zoneID][107].pos = {  -89.7747, -4.0000,   49.9768, 81    } -- Watchdog Alley S
xi.dynamis.mobList[zoneID][108].pos = {  -94.6474, -4.0000,   41.1507, 95    } -- Watchdog Alley Stairs
xi.dynamis.mobList[zoneID][109].pos = {    0.0735, -2.0000,   44.0171, 64    } -- W2 Megaboss
xi.dynamis.mobList[zoneID][110].pos = {   -4.0629, -2.0000,   40.9907, 60    } -- W2 Megaboss Pop Near W
xi.dynamis.mobList[zoneID][111].pos = {    4.0815, -2.0000,   41.0436, 68    } -- W2 Megaboss Pop Near E
xi.dynamis.mobList[zoneID][112].pos = {  -24.8356,  0.0000,   36.8744, 44    } -- W2 Megaboss Pop Far W
xi.dynamis.mobList[zoneID][113].pos = {  -17.5909,  0.0000,   37.1444, 53    } -- W2 Megaboss Pop's Pop Fa
xi.dynamis.mobList[zoneID][114].pos = {   23.2271,  0.0000,   35.1004, 77    } -- W2 Megaboss Pop Far E
xi.dynamis.mobList[zoneID][115].pos = {   15.7737,  0.0000,   34.9563, 77    } -- W2 Megaboss Pop's Pop Fa
xi.dynamis.mobList[zoneID][116].pos = {  -36.9843,  0.0000,   30.0222, 23    } -- W3 Victory Square NW
xi.dynamis.mobList[zoneID][117].pos = {  -38.0342,  0.0000,   12.9522, 0     } -- W3 Victory Square SW
xi.dynamis.mobList[zoneID][118].pos = {   36.9442,  0.0000,   30.2140, 96    } -- W3 Victory Square NE
xi.dynamis.mobList[zoneID][119].pos = {   37.9635,  0.0000,   12.9962, 127   } -- W3 Victory Square SE
xi.dynamis.mobList[zoneID][120].pos = {    0.0676, -3.0000,  -29.7543, 191   } -- W3 Atop AH
xi.dynamis.mobList[zoneID][121].pos = { -151.4307, -2.0000,   60.1692, 123   } -- W3 Courtyard E
xi.dynamis.mobList[zoneID][122].pos = { -166.9782, -2.0000,   58.5803, 128   } -- W3 Courtyard W
xi.dynamis.mobList[zoneID][123].pos = { -197.3283, -8.8011,   90.7618, 95    } -- W3 Pikeman's Way Catwalk
xi.dynamis.mobList[zoneID][124].pos = { -198.8831, -1.0000,   41.6770, 237   } -- W3 LW Guild N
xi.dynamis.mobList[zoneID][125].pos = { -167.9602, -1.0000,   12.0282, 201   } -- W3 LW Guild S
xi.dynamis.mobList[zoneID][126].pos = { -103.4151,  2.0000,   -8.4370, 59    } -- W3 Westgate Corner N
xi.dynamis.mobList[zoneID][127].pos = { -125.6019,  1.0000,  -29.4409, 251   } -- W3 Westgate Corner W
xi.dynamis.mobList[zoneID][128].pos = {  -85.4643,  1.0000,  -70.9384, 190   } -- W3 Westgate Corner S
xi.dynamis.mobList[zoneID][129].pos = {  -62.5682,  2.0000,  -48.1542, 122   } -- W3 Westgate Corner E
xi.dynamis.mobList[zoneID][130].pos = {   28.3832,  2.2000,  -89.9126, 134   } -- W3 Chocobo Stables Grass
xi.dynamis.mobList[zoneID][131].pos = {   28.3091,  2.2000,  -94.2068, 142   } -- W3 Chocobo Stables Grass
xi.dynamis.mobList[zoneID][132].pos = {   61.9606,  2.0000,  -47.8880, 253   } -- W3 Eastegate Corner W
xi.dynamis.mobList[zoneID][133].pos = {   85.3854,  1.0000,  -69.5495, 188   } -- W3 Eastegate Corner S
xi.dynamis.mobList[zoneID][134].pos = {  126.1979,  1.0000,  -29.2587, 126   } -- W3 Eastegate Corner E
xi.dynamis.mobList[zoneID][135].pos = {  103.9707,  2.0000,   -6.3490, 64    } -- W3 Eastegate Corner N
xi.dynamis.mobList[zoneID][136].pos = {   75.1727,  2.0000,    4.8686, 32    } -- W3 Beside Street Vendor
xi.dynamis.mobList[zoneID][137].pos = {  101.5461,  4.0000,   25.6043, 91    } -- W3 Cavalry Way 3-way Int
xi.dynamis.mobList[zoneID][138].pos = {  103.6767,  4.0000,   40.9239, 126   } -- W3 Across Rosel's Armour
xi.dynamis.mobList[zoneID][139].pos = {   92.4537,  4.0000,   47.9614, 1     } -- W3 Between Rosel's/Helbo
xi.dynamis.mobList[zoneID][140].pos = {  133.0893,  0.0000,    9.8870, 193   } -- W3 Cavalry Way Ramp Entr
xi.dynamis.mobList[zoneID][141].pos = {  130.6248, -1.2500,  105.9016, 96    } -- W4 Lion Square Stairs W
xi.dynamis.mobList[zoneID][142].pos = {  137.5452, -1.0000,   98.5752, 96    } -- W4 Lion Square Stairs S
xi.dynamis.mobList[zoneID][143].pos = {  108.8902,  0.0000,   85.6102, 96    } -- W4 Lion Square Fountain
xi.dynamis.mobList[zoneID][144].pos = {  116.5853,  0.0000,   74.9059, 96    } -- W4 Lion Square Fountain
xi.dynamis.mobList[zoneID][145].pos = { -210.2554, -2.0000,   95.1729, 130   } -- W2 Pikeman's Way N
xi.dynamis.mobList[zoneID][146].pos = { -202.6147, -2.0000,   85.8321, 157   } -- W2 Pikeman's Way C
xi.dynamis.mobList[zoneID][147].pos = {  -23.9535,  2.0000,  -12.1383, 0     } -- W2 Victory Square Tent W
xi.dynamis.mobList[zoneID][148].pos = {   -5.0312,  2.0000,  -11.8298, 51    } -- W2 Victory Square Pop Bt
xi.dynamis.mobList[zoneID][149].pos = {   23.8516,  2.0000,  -12.4577, 128   } -- W2 Victory Square Tent E
xi.dynamis.mobList[zoneID][150].pos = {    5.0829,  2.0000,  -11.8420, 75    } -- W2 Victory Square Pop Bt

----------------------------------------------------------------------------------------------------
--                                    Setup of Mob Functions                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--             Patrol Paths             --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].patrolPath = {xpos1,ypos1,zpos1, xpos2,ypos2,zpos2,  xpos3,ypos3,zpos3}

xi.dynamis.mobList[zoneID].patrolPaths = {2, 3, 4, 5, 8, 13, 14, 15, 16, 17, 18, 23, 25, 26, 27, 28, 29, 30, 37, 38, 39, 40, 41, 42, 43, 44,
                                         45, 46, 47, 48, 55, 56, 57, 63, 64, 65, 66, 67, 68, 74, 77, 78, 79, 87, 88, 90, 91, 92, 96, 98,
                                         99, 103, 105, 106, 107, 108, 141, 142, 143, 144, 145, 146}
--Wave 1 pathing
xi.dynamis.mobList[zoneID][2  ].patrolPath = { {121, 0, 96  }, {127, 0, 102 }, }
xi.dynamis.mobList[zoneID][3  ].patrolPath = { {128, 0, 89  }, {134, 0, 95  }, }
xi.dynamis.mobList[zoneID][4  ].patrolPath = { {112, 0, 87  }, {106, 0, 82  }, }
xi.dynamis.mobList[zoneID][5  ].patrolPath = { {119, 0, 80  }, {113, 0, 75  }, }
xi.dynamis.mobList[zoneID][8  ].patrolPath = { {98, 4, 68   }, {98, 4, 62   }, }
xi.dynamis.mobList[zoneID][13 ].patrolPath = { {98, 4, 16   }, {98, 4, 56   }, }
xi.dynamis.mobList[zoneID][14 ].patrolPath = { {104, 4, 14  }, {116, 2, 14  }, }
xi.dynamis.mobList[zoneID][15 ].patrolPath = { {118, 2, 14  }, {133, 0, 14  }, }
xi.dynamis.mobList[zoneID][16 ].patrolPath = { {146, 0, 30  }, {135, 0, 18  }, }
xi.dynamis.mobList[zoneID][17 ].patrolPath = { {148, 0, 49  }, {148, 0, 33  }, }
xi.dynamis.mobList[zoneID][18 ].patrolPath = { {130, 0, 68  }, {152, 0, 45  }, }
xi.dynamis.mobList[zoneID][23 ].patrolPath = { {93, 4, 14   }, {81, 2, 2    }, }
xi.dynamis.mobList[zoneID][25 ].patrolPath = { {76, 2, -4   }, {88, 2, -16  }, }
xi.dynamis.mobList[zoneID][26 ].patrolPath = { {68, 2, -12  }, {80, 2, -24  }, }
xi.dynamis.mobList[zoneID][27 ].patrolPath = { {60, 2, -20  }, {72, 2, -32  }, }
xi.dynamis.mobList[zoneID][28 ].patrolPath = { {91, 2, -19  }, {98, 2, -26  }, }
xi.dynamis.mobList[zoneID][29 ].patrolPath = { {89, 2, -33  }, {83, 2, -27  }, }
xi.dynamis.mobList[zoneID][30 ].patrolPath = { {75, 2, -35  }, {81, 2, -41  }, }
xi.dynamis.mobList[zoneID][37 ].patrolPath = { {40, 2, -17  }, {40, 2, -37  }, }
xi.dynamis.mobList[zoneID][38 ].patrolPath = { {34, 2, -18  }, {14, 2, -18  }, }
xi.dynamis.mobList[zoneID][39 ].patrolPath = { {20, 2, 5    }, {20, 2, -13  }, }
xi.dynamis.mobList[zoneID][40 ].patrolPath = { {20, 0, 24   }, {0, 2, 8     }, }
xi.dynamis.mobList[zoneID][41 ].patrolPath = { {0, 0, 26    }, {0, 2, 3     }, }
xi.dynamis.mobList[zoneID][42 ].patrolPath = { {5, 0, 19    }, {5, 2, -9    }, } -- Victory Square Main Path E
xi.dynamis.mobList[zoneID][43 ].patrolPath = { {-5, 0, 19   }, {-5, 2, -9   }, } -- Victory Square Main Path W
xi.dynamis.mobList[zoneID][44 ].patrolPath = { {0, 2, -21   }, {0, 2, -4    }, }
xi.dynamis.mobList[zoneID][45 ].patrolPath = { {-24, 2, 15  }, {-24, 2, 0   }, }
xi.dynamis.mobList[zoneID][46 ].patrolPath = { {-20, 2, 5   }, {-20, 2, -13 }, }
xi.dynamis.mobList[zoneID][47 ].patrolPath = { {-34, 2, -18 }, {-14, 2, -18 }, }
xi.dynamis.mobList[zoneID][48 ].patrolPath = { {-40, 2, -17 }, {-40, 2, -38 }, }
xi.dynamis.mobList[zoneID][55 ].patrolPath = { {2, 2, -74   }, {-12, 2, -74 }, }
xi.dynamis.mobList[zoneID][56 ].patrolPath = { {-8, 2, -80  }, {-23, 2, -80 }, }
xi.dynamis.mobList[zoneID][57 ].patrolPath = { {5, 2, -74   }, {18, 2, -74  }, }
xi.dynamis.mobList[zoneID][63 ].patrolPath = { {-72, 2, -32 }, {-60, 2, -20 }, }
xi.dynamis.mobList[zoneID][64 ].patrolPath = { {-80, 2, -24 }, {-68, 2, -12 }, }
xi.dynamis.mobList[zoneID][65 ].patrolPath = { {-88, 2, -16 }, {-76, 2, -4  }, }
xi.dynamis.mobList[zoneID][66 ].patrolPath = { {-75, 2, -35 }, {-83, 2, -43 }, }
xi.dynamis.mobList[zoneID][67 ].patrolPath = { {-83, 2, -27 }, {-91, 2, -35 }, }
xi.dynamis.mobList[zoneID][68 ].patrolPath = { {-91, 2, -19 }, {-99, 2, -27 }, }
xi.dynamis.mobList[zoneID][74 ].patrolPath = { {-96, -2, 16 }, {-84, 2, 4   }, }
xi.dynamis.mobList[zoneID][77 ].patrolPath = { {-118, -2, 12}, {-99, -2, 27 }, }
xi.dynamis.mobList[zoneID][78 ].patrolPath = { {-118, -2, 18}, {-136, -2, 18}, }
xi.dynamis.mobList[zoneID][79 ].patrolPath = { {-140, -2, 18}, {-163, -1, 18}, }
xi.dynamis.mobList[zoneID][87 ].patrolPath = { {-190, -1, 43}, {-193, -1, 55}, }
xi.dynamis.mobList[zoneID][88 ].patrolPath = { {-194, -2, 61}, {-194, -2, 78}, }
xi.dynamis.mobList[zoneID][90 ].patrolPath = { {-194, -2, 80}, {-212, -2, 98}, }
xi.dynamis.mobList[zoneID][91 ].patrolPath = { {-231, -2, 98}, {-213, -2, 98}, }
xi.dynamis.mobList[zoneID][92 ].patrolPath = { {-240, -4, 98}, {-260, -4, 98}, }
xi.dynamis.mobList[zoneID][96 ].patrolPath = { {-169, -2, 60}, {-156, -2, 60}, }
xi.dynamis.mobList[zoneID][98 ].patrolPath = { {-144, -2, 60}, {-154, -2, 60}, }
xi.dynamis.mobList[zoneID][99 ].patrolPath = { {-132, -4, 72}, {-132, -4, 63}, }
xi.dynamis.mobList[zoneID][103].patrolPath = { {-106, -6, 88}, {-128, -6, 88}, }
xi.dynamis.mobList[zoneID][105].patrolPath = { {-94, -6, 74 }, {-104, -6, 84}, }
xi.dynamis.mobList[zoneID][106].patrolPath = { {-90, -6, 57 }, {-93, -6, 71 }, }
xi.dynamis.mobList[zoneID][107].patrolPath = { {-90, -4, 46 }, {-90, -4, 56 }, }
xi.dynamis.mobList[zoneID][108].patrolPath = { {-101, 2, 34 }, {-91, 4, 44  }, }

--Wave 2 pathing
xi.dynamis.mobList[zoneID][141].patrolPath = { {132, -1, 103}, {128, -1, 107}, }
xi.dynamis.mobList[zoneID][142].patrolPath = { {135, -1, 100}, {139, -1, 96 }, }
xi.dynamis.mobList[zoneID][143].patrolPath = { {110, 0, 80  }, {  104, 0, 87}, }
xi.dynamis.mobList[zoneID][144].patrolPath = { {118, 0, 71  }, {  112, 0, 78}, }
xi.dynamis.mobList[zoneID][145].patrolPath = { {-212, -2, 96}, {-229, -2, 98}, }
xi.dynamis.mobList[zoneID][146].patrolPath = { {-200, -2, 87}, {-193, -2, 69}, }

------------------------------------------
--          Statue Eye Colors           --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eye.BLUE -- Flags for blue eyes. (HP)
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eye.GREEN -- Flags for green eyes. (MP)

xi.dynamis.mobList[zoneID][6  ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][10 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][12 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][14 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][15 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][32 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][34 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][35 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][38 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][44 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][47 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][52 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][59 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][60 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][62 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][70 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][72 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][76 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][78 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][79 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][81 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][83 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][84 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][85 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][86 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][91 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][92 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][97 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][103].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][104].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][107].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][108].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][110].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][111].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][113].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][115].eyes = xi.dynamis.eye.BLUE

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].timeExtension = 15

xi.dynamis.mobList[zoneID].timeExtensionList = {7, 9, 26, 41, 64, 74, 153}
xi.dynamis.mobList[zoneID][7  ].timeExtension = 15 -- Serjeant Tombstone
xi.dynamis.mobList[zoneID][9  ].timeExtension = 15 -- Serjeant Tombstone
xi.dynamis.mobList[zoneID][26 ].timeExtension = 25 -- Serjeant Tombstone
xi.dynamis.mobList[zoneID][41 ].timeExtension = 30 -- Serjeant Tombstone
xi.dynamis.mobList[zoneID][64 ].timeExtension = 25 -- Serjeant Tombstone
xi.dynamis.mobList[zoneID][74 ].timeExtension = 10 -- Warchief Tombstone
xi.dynamis.mobList[zoneID][153].timeExtension = 30 -- Voidstreaker Butchnotch
