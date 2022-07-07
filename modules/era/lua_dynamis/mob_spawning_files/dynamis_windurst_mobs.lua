----------------------------------------------------------------------------------------------------
--                                      Dynamis-Windurst                                          --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/win.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/win.html        --
--                       NOTE: Please refer to instructions for setup.                            --
-- Video References:                                                                              --
-- https://www.youtube.com/user/FFXIshibaa/search                                                 --
-- https://www.youtube.com/user/fatalbiohazard/search                                             --
-- https://www.youtube.com/watch?v=Tdv6TJOhOTc&ab_channel=DavidWindsands                          --
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
local zoneID = xi.zone.DYNAMIS_WINDURST
local i = 1
xi = xi or {} -- Ignore me I just set the global.
xi.dynamis = xi.dynamis or {} -- Ignore me I just set the global.
xi.dynamis.mobList = xi.dynamis.mobList or { } -- Ignore me I just set the global.
xi.dynamis.mobList[zoneID] = { } -- Ignore me, I just start the table.
xi.dynamis.mobList[zoneID].nmchildren = { }
xi.dynamis.mobList[zoneID].mobchildren = { }
xi.dynamis.mobList[zoneID].maxWaves = 10 -- Put in number of max waves

while i <= 156 do
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

xi.dynamis.mobList[zoneID][1  ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (001-Y/A)
xi.dynamis.mobList[zoneID][2  ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (002-Y/A)
xi.dynamis.mobList[zoneID][3  ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (003-Y/A)
xi.dynamis.mobList[zoneID][4  ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (004-Y/A)
xi.dynamis.mobList[zoneID][5  ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (005-Y/A)
xi.dynamis.mobList[zoneID][6  ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (006-Y/M)(HP)
xi.dynamis.mobList[zoneID][7  ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (007-Y/A)
xi.dynamis.mobList[zoneID][8  ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (008-Y/M)(MP)(20)
xi.dynamis.mobList[zoneID][9  ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (009-Y/A)
xi.dynamis.mobList[zoneID][10 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (010-Y/A)
xi.dynamis.mobList[zoneID][11 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (011-Y/A)
xi.dynamis.mobList[zoneID][12 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (012-Y/M)(HP)
xi.dynamis.mobList[zoneID][13 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (013-Y/A)
xi.dynamis.mobList[zoneID][14 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (014-Y/A)
xi.dynamis.mobList[zoneID][15 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (015-Y/A)
xi.dynamis.mobList[zoneID][16 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (016-Y/A)
xi.dynamis.mobList[zoneID][17 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (017-Y/M)(MP)
xi.dynamis.mobList[zoneID][18 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (018-Y/A)(20)
xi.dynamis.mobList[zoneID][19 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (019-Y/M)(HP)
xi.dynamis.mobList[zoneID][20 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (020-Y/A)
xi.dynamis.mobList[zoneID][21 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (021-Y/A)
xi.dynamis.mobList[zoneID][22 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (022-Y/A)
xi.dynamis.mobList[zoneID][23 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (023-Y/A)
xi.dynamis.mobList[zoneID][24 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (024-Y/M)(HP)
xi.dynamis.mobList[zoneID][25 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (025-Y/M)(MP)
xi.dynamis.mobList[zoneID][26 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (026-Y/A)
xi.dynamis.mobList[zoneID][27 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (027-Y/A)
xi.dynamis.mobList[zoneID][28 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (028-Y/A)
xi.dynamis.mobList[zoneID][29 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (029-Y/M)(HP)
xi.dynamis.mobList[zoneID][30 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (030-Y/M)(MP)
xi.dynamis.mobList[zoneID][31 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (031-Y/A)(10)
xi.dynamis.mobList[zoneID][32 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (032-Y/A)
xi.dynamis.mobList[zoneID][33 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (033-Y/M)(MP)
xi.dynamis.mobList[zoneID][34 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (034-Y/A)
xi.dynamis.mobList[zoneID][35 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (035-Y/M)(HP)
xi.dynamis.mobList[zoneID][36 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (036-Y/A)
xi.dynamis.mobList[zoneID][37 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (037-Y/A)
xi.dynamis.mobList[zoneID][38 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (038-Y/A)
xi.dynamis.mobList[zoneID][39 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (039-Y/A)
xi.dynamis.mobList[zoneID][40 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (040-Y/M)(MP)
xi.dynamis.mobList[zoneID][41 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (041-Y/A)(20)
xi.dynamis.mobList[zoneID][42 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (042-Y/M)(HP)
xi.dynamis.mobList[zoneID][43 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (043-Y/A)
xi.dynamis.mobList[zoneID][44 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (044-Y/A)
xi.dynamis.mobList[zoneID][45 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (045-Y/M)(MP)
xi.dynamis.mobList[zoneID][46 ].info = { "Statue", "Avatar Idol",    nil, nil, nil }  -- (046-Y/A).Idol
xi.dynamis.mobList[zoneID][47 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (047-Y/M)
xi.dynamis.mobList[zoneID][48 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (048-Y/M)
xi.dynamis.mobList[zoneID][49 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (049-Y/A)
xi.dynamis.mobList[zoneID][50 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (050-Y/A)
xi.dynamis.mobList[zoneID][51 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (051-Y/M)(HP)
xi.dynamis.mobList[zoneID][52 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (052-Y/A)
xi.dynamis.mobList[zoneID][53 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (053-Y/A)
xi.dynamis.mobList[zoneID][54 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (054-Y/A)
xi.dynamis.mobList[zoneID][55 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (055-Y/A)
xi.dynamis.mobList[zoneID][56 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (056-Y/M)(HP)
xi.dynamis.mobList[zoneID][57 ].info = { "Statue", "Manifest Icon",  nil, nil, "57_killed" }  -- (057-Y/M)(MP)
xi.dynamis.mobList[zoneID][58 ].info = { "Statue", "Avatar Icon",    nil, nil, "58_killed" }  -- (058-Y/A)(10)
xi.dynamis.mobList[zoneID][59 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (059-Y/A)
xi.dynamis.mobList[zoneID][60 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (060-Y/M)(MP)
xi.dynamis.mobList[zoneID][61 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (061-Y/A)
xi.dynamis.mobList[zoneID][62 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (062-Y/A)
xi.dynamis.mobList[zoneID][63 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (063-Y/A)
xi.dynamis.mobList[zoneID][64 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (064-Y/A)
xi.dynamis.mobList[zoneID][65 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (065-Y/A)
xi.dynamis.mobList[zoneID][66 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (066-Y/M)(20)
xi.dynamis.mobList[zoneID][67 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (067-Y/A)
xi.dynamis.mobList[zoneID][68 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (068-Y/A)
xi.dynamis.mobList[zoneID][69 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (069-Y/A)
xi.dynamis.mobList[zoneID][70 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (070-Y/A)
xi.dynamis.mobList[zoneID][71 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (071-Y/A)
xi.dynamis.mobList[zoneID][72 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (072-Y/M)(MP)
xi.dynamis.mobList[zoneID][73 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (073-Y/A)
xi.dynamis.mobList[zoneID][74 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (074-Y/M)(HP)
xi.dynamis.mobList[zoneID][75 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (075-Y/A)
xi.dynamis.mobList[zoneID][76 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (076-Y/A)
xi.dynamis.mobList[zoneID][77 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (077-Y/M)(MP)
xi.dynamis.mobList[zoneID][78 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (078-Y/A)
xi.dynamis.mobList[zoneID][79 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (079-Y/A)
xi.dynamis.mobList[zoneID][80 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (080-Y/M)(MP)
xi.dynamis.mobList[zoneID][81 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (081-Y/A)
xi.dynamis.mobList[zoneID][82 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (082-Y/A)
xi.dynamis.mobList[zoneID][83 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (083-Y/M)(HP)
xi.dynamis.mobList[zoneID][84 ].info = { "Statue", "Avatar Idol",    nil, nil, nil }  -- (084-Y/A).Idol
xi.dynamis.mobList[zoneID][85 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (085-Y/A)
xi.dynamis.mobList[zoneID][86 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (086-Y/M)(MP)
xi.dynamis.mobList[zoneID][87 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (087-Y/A)
xi.dynamis.mobList[zoneID][88 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (088-Y/M)(HP)
xi.dynamis.mobList[zoneID][89 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (089-Y/A)
xi.dynamis.mobList[zoneID][90 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (090-Y/A)
xi.dynamis.mobList[zoneID][91 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (091-Y/A)
xi.dynamis.mobList[zoneID][92 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (092-Y/A)
xi.dynamis.mobList[zoneID][93 ].info = { "Statue", "Avatar Idol",    nil, nil, nil }  -- (093-Y/A).Idol
xi.dynamis.mobList[zoneID][94 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (094-Y/M)(HP)
xi.dynamis.mobList[zoneID][95 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (095-Y/M)(HP)
xi.dynamis.mobList[zoneID][96 ].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (096-Y/M)(MP)
xi.dynamis.mobList[zoneID][97 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (097-Y/A)
xi.dynamis.mobList[zoneID][98 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (098-Y/A)
xi.dynamis.mobList[zoneID][99 ].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (099-Y/A)
xi.dynamis.mobList[zoneID][100].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (100-Y/M)(HP)
xi.dynamis.mobList[zoneID][101].info = { "Statue", "Avatar Icon",    nil, nil, "101_killed" }  -- (101-Y/M)(20)
xi.dynamis.mobList[zoneID][102].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (102-Y/A)
xi.dynamis.mobList[zoneID][103].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (103-Y/A)
xi.dynamis.mobList[zoneID][104].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (104-Y/A)
xi.dynamis.mobList[zoneID][105].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (105-Y/A)
xi.dynamis.mobList[zoneID][106].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (106-Y/A)
xi.dynamis.mobList[zoneID][107].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (107-Y/A)
xi.dynamis.mobList[zoneID][108].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (108-Y/A)
xi.dynamis.mobList[zoneID][109].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (109-Y/A)
xi.dynamis.mobList[zoneID][110].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (110-Y/M)(HP)
xi.dynamis.mobList[zoneID][111].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (111-Y/M)(MP)
xi.dynamis.mobList[zoneID][112].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (112-Y/A)
xi.dynamis.mobList[zoneID][113].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (113-Y/A)
xi.dynamis.mobList[zoneID][114].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (114-Y/M)
xi.dynamis.mobList[zoneID][115].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (115-Y/M)
xi.dynamis.mobList[zoneID][116].info = { "Statue", "Manifest Idol",  nil, nil, nil }  -- (116-Y/A).Idol
xi.dynamis.mobList[zoneID][117].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (117-Y/M)(HP)
xi.dynamis.mobList[zoneID][118].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (118-Y/M)(MP)
xi.dynamis.mobList[zoneID][119].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (119-Y/M)
xi.dynamis.mobList[zoneID][120].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (120-Y/M)
xi.dynamis.mobList[zoneID][122].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (122-Y/M)
xi.dynamis.mobList[zoneID][123].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (123-Y/M)
xi.dynamis.mobList[zoneID][124].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (124-Y/M)
xi.dynamis.mobList[zoneID][125].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (125-Y/M)
xi.dynamis.mobList[zoneID][126].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (126-Y/M)(HP)
xi.dynamis.mobList[zoneID][127].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (127-Y/M)(MP)
xi.dynamis.mobList[zoneID][128].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (128-Y/A)
xi.dynamis.mobList[zoneID][129].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (129-Y/A)
xi.dynamis.mobList[zoneID][130].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (130-Y/A)
xi.dynamis.mobList[zoneID][131].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (131-Y/M)(MP)
xi.dynamis.mobList[zoneID][132].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (132-Y/A)
xi.dynamis.mobList[zoneID][133].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (133-Y/M)(HP)
xi.dynamis.mobList[zoneID][134].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (134-Y/A)
xi.dynamis.mobList[zoneID][135].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (135-Y/A)
xi.dynamis.mobList[zoneID][136].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (136-Y/M)(HP)
xi.dynamis.mobList[zoneID][137].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (137-Y/M)(MP)
xi.dynamis.mobList[zoneID][138].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (138-Y/M)(HP)
xi.dynamis.mobList[zoneID][139].info = { "Statue", "Manifest Icon",  nil, nil, nil }  -- (139-Y/M)(MP)
xi.dynamis.mobList[zoneID][140].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (140-Y/M)
xi.dynamis.mobList[zoneID][141].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (141-Y/M)
xi.dynamis.mobList[zoneID][142].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (142-Y/M)
xi.dynamis.mobList[zoneID][143].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (143-Y/M)
xi.dynamis.mobList[zoneID][144].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (144-Y/M)
xi.dynamis.mobList[zoneID][145].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (145-Y/M)
xi.dynamis.mobList[zoneID][146].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (146-Y/A)
xi.dynamis.mobList[zoneID][147].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (147-Y/M)
xi.dynamis.mobList[zoneID][148].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (148-Y/A)
xi.dynamis.mobList[zoneID][149].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (149-Y/M)
xi.dynamis.mobList[zoneID][150].info = { "Statue", "Avatar Icon",    nil, nil, nil }  -- (150-Y/M)

-- NM's and Megaboss
xi.dynamis.mobList[zoneID][121].info = { "NM", "Tzee Xicu Idol",               nil,   nil, "MegaBoss_Killed" }   -- 121-Replica NM (Tzee Xicu Idol)
xi.dynamis.mobList[zoneID][151].info = { "NM", "Maa Febi the Steadfast",  "Yagudo", "PLD", nil }                 -- Maa Febi the Steadfast
xi.dynamis.mobList[zoneID][152].info = { "NM", "Muu Febi the Steadfast",  "Yagudo", "PLD", nil }                 -- Muu Febi the Steadfast
xi.dynamis.mobList[zoneID][153].info = { "NM", "Haa Pevi the Stentorian", "Yagudo", "SMN", "Haa_killed" }        -- Haa Pevi the Stentorian
xi.dynamis.mobList[zoneID][154].info = { "NM", "Loo Hepe the Eyepiercer", "Yagudo", "RDM", "Loo_killed" }        -- Loo Hepe the Eyepiercer
xi.dynamis.mobList[zoneID][155].info = { "NM", "Wuu Qoho the Razorclaw",  "Yagudo", "MNK", "Wuu_killed" }        -- Wuu Qoho the Razorclaw
xi.dynamis.mobList[zoneID][156].info = { "NM", "Xoo Kaza the Solemn",     "Yagudo", "BLM", "Xoo_killed" }        -- Xoo Kaza the Solemn

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
    {"MegaBoss_Killed"}, -- Spawns statues when boss dies
    {"Wuu_killed"}, -- Wuu Qoho the Razorclaw spawns 2 Statues at Heavens Tower
    {"Xoo_killed"}, -- Xoo Kaza the Solemn NM spawns 2 Statues at Heavens Tower
    {"Haa_killed"}, -- Haa Pevi the Stentorian NM spawns 2 Statues at Heavens Tower
    {"Wuu_killed", "Xoo_killed", "Haa_killed"}, -- Spawn main Heavens Tower statues + the RDM NM on 3 NM deaths
    {"58_killed"}, -- pops 59-61 on bridge when defeated
    {"101_killed"}, -- pops 102/103 under bridge when defeated
    {"57_killed" }, -- pops 54/55 under bridge when defeated
    {"Loo_killed"} -- Pops zone boss
}

------------------------------------------
--            Wave Spawning             --
-- Note: Wave 1 spawns at start.        --
------------------------------------------
--xi.dynamis.mobList[zoneID][MobIndex].waves = { 1,nil,nil }

-- Spawns on zone entry
xi.dynamis.mobList[zoneID][1].wave =
{
    1  ,    -- (001-Y/A)  Avatar Icon
    2  ,    -- (002-Y/A)  Avatar Icon
    3  ,    -- (003-Y/A)  Avatar Icon
    4  ,    -- (004-Y/A)  Avatar Icon
    5  ,    -- (005-Y/A)  Avatar Icon
    6  ,    -- (006-Y/M)  Manifest Icon
    7  ,    -- (007-Y/A)  Avatar Icon
    8  ,    -- (008-Y/M)  Manifest Icon
    9  ,    -- (009-Y/A)  Avatar Icon
    10 ,    -- (010-Y/A)  Avatar Icon
    11 ,    -- (011-Y/A)  Avatar Icon
    12 ,    -- (012-Y/M)  Manifest Icon
    13 ,    -- (013-Y/A)  Avatar Icon
    14 ,    -- (014-Y/A)  Avatar Icon
    15 ,    -- (015-Y/A)  Avatar Icon
    16 ,    -- (016-Y/A)  Avatar Icon
    17 ,    -- (017-Y/M)  Manifest Icon
    18 ,    -- (018-Y/A)  Avatar Icon
    19 ,    -- (019-Y/M)  Manifest Icon
    20 ,    -- (020-Y/A)  Avatar Icon
    21 ,    -- (021-Y/A)  Avatar Icon
    24 ,    -- (024-Y/M)  Manifest Icon
    26 ,    -- (026-Y/A)  Avatar Icon
    27 ,    -- (027-Y/A)  Avatar Icon
    28 ,    -- (028-Y/A)  Avatar Icon
    29 ,    -- (029-Y/M)  Manifest Icon
    30 ,    -- (030-Y/M)  Manifest Icon
    31 ,    -- (031-Y/A)  Avatar Icon
    32 ,    -- (032-Y/A)  Avatar Icon
    34 ,    -- (034-Y/A)  Avatar Icon
    35 ,    -- (035-Y/M)  Manifest Icon
    38 ,    -- (038-Y/A)  Avatar Icon
    39 ,    -- (039-Y/A)  Avatar Icon
    40 ,    -- (040-Y/M)  Manifest Icon
    41 ,    -- (041-Y/A)  Avatar Icon
    43 ,    -- (043-Y/A)  Avatar Icon
    44 ,    -- (044-Y/A)  Avatar Icon
    45 ,    -- (045-Y/M)  Manifest Icon
    46 ,    -- (046-Y/A)  Avatar Idol
    51 ,    -- (051-Y/M)  Manifest Icon
    52 ,    -- (052-Y/A)  Avatar Icon
    53 ,    -- (053-Y/A)  Avatar Icon
    56 ,    -- (056-Y/M)  Manifest Icon
    57 ,    -- (057-Y/M)  Manifest Icon
    58 ,    -- (058-Y/A)  Avatar Icon
    65 ,    -- (065-Y/A)  Avatar Icon
    66 ,    -- (066-Y/M)  Avatar Icon
    69 ,    -- (069-Y/A)  Avatar Icon
    72 ,    -- (072-Y/M)  Manifest Icon
    73 ,    -- (073-Y/A)  Avatar Icon
    74 ,    -- (074-Y/M)  Manifest Icon
    77 ,    -- (077-Y/M)  Manifest Icon
    80 ,    -- (080-Y/M)  Manifest Icon
    84 ,    -- (084-Y/A)  Avatar Idol
    88 ,    -- (088-Y/M)  Manifest Icon
    89 ,    -- (089-Y/A)  Avatar Icon
    91 ,    -- (091-Y/A)  Avatar Icon
    93 ,    -- (093-Y/A)  Avatar Idol
    94 ,    -- (094-Y/M)  Manifest Icon
    95 ,    -- (095-Y/M)  Manifest Icon
    96 ,    -- (096-Y/M)  Manifest Icon
    97 ,    -- (097-Y/A)  Avatar Icon
    101,    -- (101-Y/M)  Avatar Icon
    104,    -- (104-Y/A)  Avatar Icon
    105,    -- (105-Y/A)  Avatar Icon
    106,    -- (106-Y/A)  Avatar Icon
    107,    -- (107-Y/A)  Avatar Icon
    108,    -- (108-Y/A)  Avatar Icon
    109,    -- (109-Y/A)  Avatar Icon
}

-- Spawns statues when boss dies
xi.dynamis.mobList[zoneID][2].wave =
{
    126,    -- (126-Y/M)  Manifest Icon
    127,    -- (127-Y/M)  Manifest Icon
    128,    -- (128-Y/A)  Avatar Icon
    129,    -- (129-Y/A)  Avatar Icon
    130,    -- (130-Y/A)  Avatar Icon
    131,    -- (131-Y/M)  Manifest Icon
    132,    -- (132-Y/A)  Avatar Icon
    133,    -- (133-Y/M)  Manifest Icon
    134,    -- (134-Y/A)  Avatar Icon
    135,    -- (135-Y/A)  Avatar Icon
    136,    -- (136-Y/M)  Manifest Icon
    137,    -- (137-Y/M)  Manifest Icon
    138,    -- (138-Y/M)  Manifest Icon
    139,    -- (139-Y/M)  Manifest Icon
    140,    -- (140-Y/M)  Avatar Icon
    141,    -- (141-Y/M)  Avatar Icon
    142,    -- (142-Y/M)  Avatar Icon
    143,    -- (143-Y/M)  Avatar Icon
    144,    -- (144-Y/M)  Avatar Icon
    145,    -- (145-Y/M)  Avatar Icon
    146,    -- (146-Y/A)  Avatar Icon
    147,    -- (147-Y/M)  Avatar Icon
    148,    -- (148-Y/A)  Avatar Icon
    149,    -- (149-Y/M)  Avatar Icon
    150     -- (150-Y/M)  Avatar Icon
}

-- Wuu Qoho the Razorclaw spawns 2 Statues at Heavens Tower
xi.dynamis.mobList[zoneID][3].wave =
{
    108,    -- (108-Y/A)  Avatar Icon
    109     -- (109-Y/A)  Avatar Icon
}

-- Xoo Kaza the Solemn NM spawns 2 Statues at Heavens Tower
xi.dynamis.mobList[zoneID][4].wave =
{
    110,    -- (110-Y/M)  Manifest Icon
    111	    -- (111-Y/M)  Manifest Icon
}

-- Haa Pevi the Stentorian NM spawns 2 Statues at Heavens Tower
xi.dynamis.mobList[zoneID][5].wave =
{
    113,    -- (113-Y/A) Avatar Icon
    112	    -- (112-Y/A) Avatar Icon
}

-- Spawn main Heavens Tower statues + the RDM NM on 3 NM deaths
xi.dynamis.mobList[zoneID][6].wave =
{
    114,    -- (114-Y/M)  Avatar Icon
    115,    -- (115-Y/M)  Avatar Icon
    116     -- (116-Y/A)  Manifest Idol
}

xi.dynamis.mobList[zoneID][7].wave =
{
    59,     -- (059-Y/A)  Avatar Icon
    60,     -- (060-Y/M)  Manifest Icon
    61      -- (061-Y/A)  Avatar Icon
}

xi.dynamis.mobList[zoneID][8].wave =
{
    103,    -- (103-Y/A)  Avatar Icon
    102	    -- (102-Y/A)  Avatar Icon
}

xi.dynamis.mobList[zoneID][9].wave =
{
    55,     -- (055-Y/A)  Avatar Icon
    54	    -- (054-Y/A)  Avatar Icon
}

xi.dynamis.mobList[zoneID][10].wave =
{
    121     -- ( 121 ) Tzee Xicu Idol
}

----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

xi.dynamis.mobList[zoneID][1  ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil  } -- 1 PLD 1 DRK
xi.dynamis.mobList[zoneID][2  ].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM 1 BLM
xi.dynamis.mobList[zoneID][3  ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 RDM 1 BRD
xi.dynamis.mobList[zoneID][4  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 RNG
xi.dynamis.mobList[zoneID][6  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil  } -- 1 SAM 1 NIN
xi.dynamis.mobList[zoneID][7  ].mobchildren = { nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 MNK
xi.dynamis.mobList[zoneID][8  ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  } -- 1 WAR 2 DRG
xi.dynamis.mobList[zoneID][9  ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 THF 2 NIN
xi.dynamis.mobList[zoneID][11 ].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 WAR 2 BST
xi.dynamis.mobList[zoneID][12 ].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 PLD
xi.dynamis.mobList[zoneID][13 ].mobchildren = { nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WHM
xi.dynamis.mobList[zoneID][14 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil  } -- 1 DRK 1 SAM
xi.dynamis.mobList[zoneID][15 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil  } -- 1 DRK 1 SAM
xi.dynamis.mobList[zoneID][16 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 1 BLM 2 SMN
xi.dynamis.mobList[zoneID][17 ].mobchildren = { nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 RDM 1 THF
xi.dynamis.mobList[zoneID][18 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 WAR 1 SAM
xi.dynamis.mobList[zoneID][19 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
xi.dynamis.mobList[zoneID][20 ].mobchildren = { nil,   1, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 MNK 1 THF 1 BRD
xi.dynamis.mobList[zoneID][21 ].mobchildren = { nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM 1 PLD
xi.dynamis.mobList[zoneID][22 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  } -- 1 DRK
xi.dynamis.mobList[zoneID][23 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM
xi.dynamis.mobList[zoneID][24 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 2 THF 1 BRD
xi.dynamis.mobList[zoneID][25 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   2, nil  } -- 1 BST 2 DRG
xi.dynamis.mobList[zoneID][26 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 BLM
xi.dynamis.mobList[zoneID][27 ].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 2 WAR 2 RNG
xi.dynamis.mobList[zoneID][28 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil,   1,   1, nil, nil, nil, nil  } -- 1 DRK 1 BRD 1 RNG
xi.dynamis.mobList[zoneID][29 ].mobchildren = {   1,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 WAR 1 MNK 1 THF 1 SAM
xi.dynamis.mobList[zoneID][30 ].mobchildren = { nil, nil, nil, nil,   1, nil,   1,   1, nil, nil, nil, nil,   1, nil, nil  } -- 1 RDM 1 PLD 1 DRK 1 NIN
xi.dynamis.mobList[zoneID][31 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil,   1, } -- 2 THF 1 SMN
xi.dynamis.mobList[zoneID][32 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil  } -- 3 DRG
xi.dynamis.mobList[zoneID][33 ].mobchildren = { nil, nil, nil, nil,   2, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } -- 2 RDM 1 BST
xi.dynamis.mobList[zoneID][34 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  } -- 2 BST
xi.dynamis.mobList[zoneID][36 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM
xi.dynamis.mobList[zoneID][37 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM
xi.dynamis.mobList[zoneID][38 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 BRD
xi.dynamis.mobList[zoneID][39 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 THF
xi.dynamis.mobList[zoneID][41 ].mobchildren = {   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 WAR 1 WHM 1 SAM
xi.dynamis.mobList[zoneID][42 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
xi.dynamis.mobList[zoneID][43 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, } -- 1 WHM 1 SMN
xi.dynamis.mobList[zoneID][44 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM
xi.dynamis.mobList[zoneID][45 ].mobchildren = { nil,   2, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 MNK 2 PLD
xi.dynamis.mobList[zoneID][47 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  } -- 1 WAR 1 DRG
xi.dynamis.mobList[zoneID][48 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 WAR 1 SAM
xi.dynamis.mobList[zoneID][53 ].mobchildren = { nil, nil, nil, nil,   2,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 RDM 1 THF
xi.dynamis.mobList[zoneID][54 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 WHM 1 BRD
xi.dynamis.mobList[zoneID][55 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  } -- 2 DRK
xi.dynamis.mobList[zoneID][56 ].mobchildren = { nil, nil, nil,   2, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil  } -- 2 BLM 1 PLD 1 NIN
xi.dynamis.mobList[zoneID][57 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, } -- 1 SMN
xi.dynamis.mobList[zoneID][60 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } -- 1 BST
xi.dynamis.mobList[zoneID][63 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  } -- 1 DRG
xi.dynamis.mobList[zoneID][65 ].mobchildren = {   1,   1,   1,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WAR 1 MNK 1 WHM 1 BLM 1 THF
xi.dynamis.mobList[zoneID][66 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil,   1, } -- 1 DRK 1 BRD 1 SMN
xi.dynamis.mobList[zoneID][67 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM
xi.dynamis.mobList[zoneID][68 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM
xi.dynamis.mobList[zoneID][69 ].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 WAR
xi.dynamis.mobList[zoneID][72 ].mobchildren = {   1,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } -- 1 WAR 1 MNK 1 BST
xi.dynamis.mobList[zoneID][73 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 NIN
xi.dynamis.mobList[zoneID][74 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil,   1, nil  } -- 1 THF 1 SAM 1 DRG
xi.dynamis.mobList[zoneID][75 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 RNG
xi.dynamis.mobList[zoneID][77 ].mobchildren = { nil, nil, nil, nil,   2, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  } -- 2 RDM 1 BRD
xi.dynamis.mobList[zoneID][78 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM 1 PLD
xi.dynamis.mobList[zoneID][79 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM 1 DRK
xi.dynamis.mobList[zoneID][80 ].mobchildren = { nil, nil, nil, nil, nil,   1,   1, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 THF 1 PLD 1 BRD
xi.dynamis.mobList[zoneID][81 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 RDM
xi.dynamis.mobList[zoneID][82 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM
xi.dynamis.mobList[zoneID][83 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, } -- 1 SMN
xi.dynamis.mobList[zoneID][84 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 BLM
xi.dynamis.mobList[zoneID][85 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  } -- 2 DRK
xi.dynamis.mobList[zoneID][86 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 PLD
xi.dynamis.mobList[zoneID][87 ].mobchildren = { nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM 1 RDM
xi.dynamis.mobList[zoneID][90 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 RDM
xi.dynamis.mobList[zoneID][92 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 RDM
xi.dynamis.mobList[zoneID][93 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
xi.dynamis.mobList[zoneID][94 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 1 WHM 2 SMN
xi.dynamis.mobList[zoneID][95 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, } -- 2 SMN
xi.dynamis.mobList[zoneID][97 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 RDM
xi.dynamis.mobList[zoneID][98 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  } -- 1 DRK
xi.dynamis.mobList[zoneID][99 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  } -- 1 BST
xi.dynamis.mobList[zoneID][100].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil  } -- 1 PLD 1 BRD
xi.dynamis.mobList[zoneID][101].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 1 MNK 2 RNG
xi.dynamis.mobList[zoneID][102].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 WAR 1 NIN
xi.dynamis.mobList[zoneID][103].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil  } -- 1 NIN 1 DRG
xi.dynamis.mobList[zoneID][104].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM
xi.dynamis.mobList[zoneID][105].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 RNG
xi.dynamis.mobList[zoneID][106].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 RNG
xi.dynamis.mobList[zoneID][107].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM
xi.dynamis.mobList[zoneID][108].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WAR
xi.dynamis.mobList[zoneID][111].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WAR
xi.dynamis.mobList[zoneID][112].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WAR
xi.dynamis.mobList[zoneID][114].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 2 THF
xi.dynamis.mobList[zoneID][115].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  } -- 2 NIN
xi.dynamis.mobList[zoneID][116].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil  } -- 1 DRK 1 BRD
xi.dynamis.mobList[zoneID][117].mobchildren = { nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM 1 RDM
xi.dynamis.mobList[zoneID][118].mobchildren = { nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 BLM 1 RDM
xi.dynamis.mobList[zoneID][119].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1,   1, nil, nil, nil  } -- 1 BST 1 RNG 1 SAM
xi.dynamis.mobList[zoneID][120].mobchildren = { nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 MNK 1 BLM 1 NIN
xi.dynamis.mobList[zoneID][121].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  } -- 2 RNG
xi.dynamis.mobList[zoneID][122].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil  } -- 1 BLM 1 BST 1 SAM
xi.dynamis.mobList[zoneID][123].mobchildren = {   1,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WAR 1 MNK 1 BLM
xi.dynamis.mobList[zoneID][126].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil,   1, nil, nil  } -- 1 PLD 1 DRK 1 NIN
xi.dynamis.mobList[zoneID][127].mobchildren = { nil, nil, nil, nil,   1,   1, nil, nil,   1, nil,   1, nil, nil, nil, nil  } -- 1 RDM 1 THF 1 BST 1 RNG
xi.dynamis.mobList[zoneID][128].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, } -- 1 MNK 1 SMN
xi.dynamis.mobList[zoneID][129].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 MNK 1 NIN
xi.dynamis.mobList[zoneID][130].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil  } -- 1 MNK 1 BST 1 SAM
xi.dynamis.mobList[zoneID][131].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil  } -- 1 WHM 1 BRD 1 RNG
xi.dynamis.mobList[zoneID][132].mobchildren = { nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, } -- 1 BLM 1 RDM 1 SMN
xi.dynamis.mobList[zoneID][133].mobchildren = { nil, nil, nil,   1,   1, nil, nil,   1, nil, nil,   1, nil, nil,   1, nil  } -- 1 BLM 1 RDM 1 DRK 1 RNG 1 DRG
xi.dynamis.mobList[zoneID][134].mobchildren = { nil,   1, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil  } -- 1 MNK 1 DRK 1 BRD
xi.dynamis.mobList[zoneID][135].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil  } -- 1 PLD 1 DRG
xi.dynamis.mobList[zoneID][136].mobchildren = { nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  } -- 1 WHM 1 THF
xi.dynamis.mobList[zoneID][137].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil  } -- 1 WAR 1 THF 1 NIN
xi.dynamis.mobList[zoneID][138].mobchildren = {   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  } -- 1 WAR 1 BLM 1 SAM
xi.dynamis.mobList[zoneID][139].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil,   1, nil  } -- 1 THF 1 RNG 1 DRG
xi.dynamis.mobList[zoneID][140].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil,   1 ,nil, nil,   1, nil, nil  } -- 1 WAR 1 THF 1 BRD 1 NIN
xi.dynamis.mobList[zoneID][141].mobchildren = { nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil,   1,   1, nil, nil  } -- 1 WHM 1 PLD 1 SAM 1 NIN
xi.dynamis.mobList[zoneID][142].mobchildren = { nil, nil, nil, nil,   1, nil, nil,   1,   1, nil, nil, nil, nil,   1, nil  } -- 1 RDM 1 DRK 1 BST 1 DRG
xi.dynamis.mobList[zoneID][143].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil,   1,   1, nil, nil,   1, nil, nil  } -- 1 WHM 1 BST 1 BRD 1 NIN
xi.dynamis.mobList[zoneID][144].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1,   1, nil, nil,   1, } -- 1 WAR 1 THF 1 RNG 1 SAM 1 SMN
xi.dynamis.mobList[zoneID][145].mobchildren = { nil,   1, nil, nil, nil, nil,   1,   1, nil,   1, nil, nil, nil, nil, nil  } -- 1 MNK 1 PLD 1 DRK 1 BRD
xi.dynamis.mobList[zoneID][146].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, } -- 1 WHM 1 BST 1 SMN
xi.dynamis.mobList[zoneID][147].mobchildren = {   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil  } -- 1 WAR 1 BLM 1 SAM 1 DRG
xi.dynamis.mobList[zoneID][148].mobchildren = { nil, nil, nil, nil,   1, nil,   1,   1, nil,   1, nil, nil,   1, nil, nil  } -- 1 RDM 1 PLD 1 DRK 1 BRD 1 NIN
xi.dynamis.mobList[zoneID][149].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil,  1, nil,    1,   1, } -- 1 THF 1 BST 1 SAM 1 DRG 1 SMN
xi.dynamis.mobList[zoneID][150].mobchildren = {   1,   1, nil,   1, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil  } -- 1 WAR 1 MNK 1 BLM 1 PLD 1 RNG

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].nmchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

xi.dynamis.mobList[zoneID][21 ].nmchildren = { true, 22, 23 }
xi.dynamis.mobList[zoneID][24 ].nmchildren = { false, 25 }
xi.dynamis.mobList[zoneID][32 ].nmchildren = { true, 33 }
xi.dynamis.mobList[zoneID][35 ].nmchildren = { true, 36, 37 }
xi.dynamis.mobList[zoneID][41 ].nmchildren = { false, 42 }
xi.dynamis.mobList[zoneID][46 ].nmchildren = { true, 47, 48, 49, 50, 155 }
xi.dynamis.mobList[zoneID][97 ].nmchildren = { false, 98 }
xi.dynamis.mobList[zoneID][98 ].nmchildren = { false, 99 }
xi.dynamis.mobList[zoneID][99 ].nmchildren = { false, 100 }
xi.dynamis.mobList[zoneID][93 ].nmchildren = { true, 153 }
xi.dynamis.mobList[zoneID][89 ].nmchildren = { false, 90 }
xi.dynamis.mobList[zoneID][91 ].nmchildren = { false, 92 }
xi.dynamis.mobList[zoneID][66 ].nmchildren = { true, 67, 68 }
xi.dynamis.mobList[zoneID][84 ].nmchildren = { true, 85, 86, 87, 156 }
xi.dynamis.mobList[zoneID][80 ].nmchildren = { false, 81, 82, 83 }
xi.dynamis.mobList[zoneID][69 ].nmchildren = { true, 70, 71 }
xi.dynamis.mobList[zoneID][72 ].nmchildren = { false, 73 }
xi.dynamis.mobList[zoneID][74 ].nmchildren = { false, 75, 76 }
xi.dynamis.mobList[zoneID][77 ].nmchildren = { false, 78, 79 }
xi.dynamis.mobList[zoneID][116].nmchildren = { true, 117, 118, false, 119, 120}
xi.dynamis.mobList[zoneID][121].nmchildren = { true, 122, 123, 124, 125, 151, 152 }

------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].pos = {xpos, ypos, zpos, rot}

xi.dynamis.mobList[zoneID][1  ].pos = { -191.3586,  -0.8007, -119.4225, 131 }
xi.dynamis.mobList[zoneID][2  ].pos = { -157.1326,  -1.0388, -132.5858, 162 }
xi.dynamis.mobList[zoneID][3  ].pos = { -153.2661,  -1.3726, -126.0487, 169 }
xi.dynamis.mobList[zoneID][4  ].pos = { -133.2595,  -2.8095, -141.1245, 129 }
xi.dynamis.mobList[zoneID][5  ].pos = { -127.3385,  -2.5025, -141.3002, 129 }
xi.dynamis.mobList[zoneID][6  ].pos = { -122.0694,  -2.5000, -141.4553, 129 }
xi.dynamis.mobList[zoneID][7  ].pos = { -108.9324,  -2.7290, -131.4035, 78  }
xi.dynamis.mobList[zoneID][8  ].pos = {  -78.4401,  -2.5000, -118.3830, 115 }
xi.dynamis.mobList[zoneID][9  ].pos = {  -52.5199,  -2.5000, -111.0963, 115 }
xi.dynamis.mobList[zoneID][10 ].pos = {  -37.1980,  -2.5000,  -84.0250, 86  }
xi.dynamis.mobList[zoneID][11 ].pos = {  -23.3699,  -2.5000,  -59.9240, 87  }
xi.dynamis.mobList[zoneID][12 ].pos = {    0.4056,  -3.9816,  -64.6868, 181 }
xi.dynamis.mobList[zoneID][13 ].pos = {   -0.5679,  -4.6828,  -40.2208, 57  }
xi.dynamis.mobList[zoneID][14 ].pos = {   -4.0851,  -6.9034,  -34.4860, 55  }
xi.dynamis.mobList[zoneID][15 ].pos = {    3.0496,  -6.8929,  -33.3899, 66  }
xi.dynamis.mobList[zoneID][16 ].pos = {   23.3167,  -2.5356,  -54.0313, 128 } -- AH W
xi.dynamis.mobList[zoneID][17 ].pos = {   35.8530,  -1.7400,  -67.6000, 192 } -- AH Front #2
xi.dynamis.mobList[zoneID][18 ].pos = {   44.0394,  -2.5000,  -59.0231, 56  } -- AH Front #3
xi.dynamis.mobList[zoneID][19 ].pos = {   52.0825,  -2.5000,  -67.6000, 57  } -- AH Front #4
xi.dynamis.mobList[zoneID][20 ].pos = {   35.9294,  -1.5051,  -73.7492, 192 } -- AH Front #1
xi.dynamis.mobList[zoneID][21 ].pos = {   83.9324,  -2.5000,  -96.0296, 159 }
xi.dynamis.mobList[zoneID][22 ].pos = {   73.4111,  -2.5000,  -82.0445, 156 }
xi.dynamis.mobList[zoneID][23 ].pos = {   70.7359,  -2.5000,  -84.8624, 157 }
xi.dynamis.mobList[zoneID][24 ].pos = {   96.5838,  -2.9733, -150.9429, 161 }
xi.dynamis.mobList[zoneID][25 ].pos = {   65.3009,  -2.5000,  -63.9545, 62  }
xi.dynamis.mobList[zoneID][26 ].pos = {   65.1695,  -7.5000,  -58.1862, 188 }
xi.dynamis.mobList[zoneID][27 ].pos = {   49.7591,  -7.2500,  -50.2882, 125 }
xi.dynamis.mobList[zoneID][28 ].pos = {   32.7444,  -6.5569,  -39.2404, 91  }
xi.dynamis.mobList[zoneID][29 ].pos = {   -8.9197,  -9.1494,  -17.4656, 193 }
xi.dynamis.mobList[zoneID][30 ].pos = {   10.2201,  -9.3104,  -12.8596, 188 }
xi.dynamis.mobList[zoneID][31 ].pos = {   29.4569, -10.0000,    9.8415, 115 }
xi.dynamis.mobList[zoneID][32 ].pos = {   47.1577,  -9.7839,   26.4536, 203 }
xi.dynamis.mobList[zoneID][33 ].pos = {   36.4718, -10.0000,   14.1809, 107 }
xi.dynamis.mobList[zoneID][34 ].pos = {   48.9704,  -9.9449,   41.3764, 90  }
xi.dynamis.mobList[zoneID][35 ].pos = {   63.9901,  -9.8617,   26.3874, 112 }
xi.dynamis.mobList[zoneID][36 ].pos = {   56.4283,  -9.9857,   22.8728, 116 }
xi.dynamis.mobList[zoneID][37 ].pos = {   51.1535,  -9.7235,   26.0237, 96  }
xi.dynamis.mobList[zoneID][38 ].pos = {   71.1621,  -8.2875,   41.9001, 96  }
xi.dynamis.mobList[zoneID][39 ].pos = {   63.9502,  -9.3320,   44.8385, 85  }
xi.dynamis.mobList[zoneID][40 ].pos = {   84.2937,  -5.1750,   52.7730, 139 }
xi.dynamis.mobList[zoneID][41 ].pos = {   90.3063,  -4.3568,   89.1465, 120 }
xi.dynamis.mobList[zoneID][42 ].pos = {   79.5591,  -2.5393,  101.2697, 11  }
xi.dynamis.mobList[zoneID][43 ].pos = {   99.7152,  -2.5000,  112.4246, 134 }
xi.dynamis.mobList[zoneID][44 ].pos = {  100.5174,  -2.5203,  118.6604, 128 }
xi.dynamis.mobList[zoneID][45 ].pos = {  109.7585,  -8.0000,  114.0638, 133 }
xi.dynamis.mobList[zoneID][46 ].pos = {  118.6259, -11.5000,  152.0082, 128 }
xi.dynamis.mobList[zoneID][47 ].pos = {  119.1999, -11.5000,  147.4525, 136 }
xi.dynamis.mobList[zoneID][48 ].pos = {  118.8364, -11.5000,  157.4733, 119 }
xi.dynamis.mobList[zoneID][49 ].pos = {  111.9339, -11.0061,  151.8975, 130 }
xi.dynamis.mobList[zoneID][50 ].pos = {   96.7755,  -7.8592,  151.8655, 124 }
xi.dynamis.mobList[zoneID][51 ].pos = {  101.5380, -10.2956,  137.2695, 228 }
xi.dynamis.mobList[zoneID][52 ].pos = {  104.0310,  -9.4472,  175.3735, 156 }
xi.dynamis.mobList[zoneID][53 ].pos = {   92.5824,  -7.5977,  188.4694, 97  }
xi.dynamis.mobList[zoneID][54 ].pos = {  105.8542,  -8.0000,  189.9759, 101 }
xi.dynamis.mobList[zoneID][55 ].pos = {   94.0309,  -8.0000,  201.6249, 84  }
xi.dynamis.mobList[zoneID][56 ].pos = {   99.9479, -13.0000,  195.7264, 97  }
xi.dynamis.mobList[zoneID][57 ].pos = {  118.8019, -12.5000,  202.3472, 103 }
xi.dynamis.mobList[zoneID][58 ].pos = {  -89.5390,  -2.5000,   39.1034, 223 }
xi.dynamis.mobList[zoneID][59 ].pos = {  -75.2515,  -2.5000,   27.8064, 32  }
xi.dynamis.mobList[zoneID][60 ].pos = {  -65.9548,  -2.5000,   19.0511, 29  }
xi.dynamis.mobList[zoneID][61 ].pos = {  -58.6351,  -2.5000,   11.6573, 30  }
xi.dynamis.mobList[zoneID][62 ].pos = {  -87.9502,  -4.7914,   63.2007, 69  }
xi.dynamis.mobList[zoneID][63 ].pos = {  -88.0065,  -5.0000,   68.2049, 67  }
xi.dynamis.mobList[zoneID][64 ].pos = {  -88.0727,  -5.0000,   71.9304, 61  }
xi.dynamis.mobList[zoneID][65 ].pos = {  -89.5757,  -9.4564,  104.8087, 254 } -- Island leading to HT
xi.dynamis.mobList[zoneID][66 ].pos = {  -68.2300,  -5.0599,  123.0997, 132 }
xi.dynamis.mobList[zoneID][67 ].pos = {  -72.9114,  -5.0000,  128.4209, 152 }
xi.dynamis.mobList[zoneID][68 ].pos = {  -75.5207,  -5.6239,  122.5561, 140 }
xi.dynamis.mobList[zoneID][69 ].pos = {  -97.8836,  -5.4114,  131.3158, 240 }
xi.dynamis.mobList[zoneID][70 ].pos = {  -96.6092,  -5.0255,  126.1928, 245 }
xi.dynamis.mobList[zoneID][71 ].pos = { -101.2070,  -5.2500,  136.3775, 251 }
xi.dynamis.mobList[zoneID][72 ].pos = {  -98.6045,  -5.0716,  121.7827, 252 }
xi.dynamis.mobList[zoneID][73 ].pos = {  -85.3194,  -7.2805,  116.8355, 191 }
xi.dynamis.mobList[zoneID][74 ].pos = { -106.9414,  -5.2500,  138.3956, 247 }
xi.dynamis.mobList[zoneID][75 ].pos = {  -99.4352,  -5.3920,  150.1503, 211 }
xi.dynamis.mobList[zoneID][76 ].pos = {  -94.2243,  -5.6397,  148.8194, 203 }
xi.dynamis.mobList[zoneID][77 ].pos = { -110.5085, -10.0000,  127.4100, 242 }
xi.dynamis.mobList[zoneID][78 ].pos = { -116.7779, -10.0000,  131.8773, 239 }
xi.dynamis.mobList[zoneID][79 ].pos = { -113.9647, -10.0000,  116.8070, 239 }
xi.dynamis.mobList[zoneID][80 ].pos = { -182.8609,  -2.3945,  147.8914, 1   }
xi.dynamis.mobList[zoneID][81 ].pos = { -166.9078,  -2.5000,  147.9220, 250 }
xi.dynamis.mobList[zoneID][82 ].pos = { -155.1755,  -2.5000,  147.9511, 1   }
xi.dynamis.mobList[zoneID][83 ].pos = { -147.0541,  -2.5000,  147.9715, 255 }
xi.dynamis.mobList[zoneID][84 ].pos = {  -97.4772, -18.0000,  194.7494, 38  }
xi.dynamis.mobList[zoneID][85 ].pos = {  -93.9415, -13.0165,  190.3358, 35  }
xi.dynamis.mobList[zoneID][86 ].pos = {  -90.3463, -12.5000,  205.7868, 39  }
xi.dynamis.mobList[zoneID][87 ].pos = { -102.3704, -17.5000,  199.8088, 34  }
xi.dynamis.mobList[zoneID][88 ].pos = { -116.9012, -17.5000,  202.7513, 26  }
xi.dynamis.mobList[zoneID][89 ].pos = {  -57.1476, -12.5000,  226.7977, 198 }
xi.dynamis.mobList[zoneID][90 ].pos = {  -38.1715, -12.5000,  243.5549, 231 }
xi.dynamis.mobList[zoneID][91 ].pos = {  -51.9927, -12.5000,  234.5901, 232 }
xi.dynamis.mobList[zoneID][92 ].pos = {  -61.2544, -12.5000,  209.1542, 202 }
xi.dynamis.mobList[zoneID][93 ].pos = {  -25.9441, -13.0000,  259.9019, 63  }
xi.dynamis.mobList[zoneID][94 ].pos = {  -29.3468, -18.0000,  264.7773, 92  } -- HotH Roof #1
xi.dynamis.mobList[zoneID][95 ].pos = {  -20.0292, -17.5000,  271.5286, 63  }
xi.dynamis.mobList[zoneID][96 ].pos = {  -18.2790, -15.8131,  283.6844, 64  }
xi.dynamis.mobList[zoneID][97 ].pos = {   14.9524,  -7.6141,  258.5253, 73  }
xi.dynamis.mobList[zoneID][98 ].pos = {    6.4487,  -7.3724,  265.7156, 2   }
xi.dynamis.mobList[zoneID][99 ].pos = {   -3.5774,  -9.8122,  272.4613, 22  }
xi.dynamis.mobList[zoneID][100].pos = {   -3.8707, -10.0098,  281.4271, 66  }
xi.dynamis.mobList[zoneID][101].pos = {    5.8521,  -2.5000,  277.6603, 225 }
xi.dynamis.mobList[zoneID][102].pos = {   22.6764,   0.2154,  242.4806, 230 }
xi.dynamis.mobList[zoneID][103].pos = {   28.1538,   0.8503,  237.1400, 237 }
xi.dynamis.mobList[zoneID][104].pos = {   48.0043,  -7.5000,  226.0027, 64  } -- Bridge to HotH #3
xi.dynamis.mobList[zoneID][105].pos = {   42.0040,  -7.5000,  219.0071, 255 } -- Bridge to HotH #2
xi.dynamis.mobList[zoneID][106].pos = {   54.0082,  -7.5000,  220.0016, 128 } -- Bridge to HotH #1
xi.dynamis.mobList[zoneID][107].pos = {   48.0042,  -7.5000,  213.0020, 192 } -- Bridge to HotH #4
xi.dynamis.mobList[zoneID][108].pos = {  -55.4420, -13.2692,  125.4680, 42  } -- Bridge to HT #2
xi.dynamis.mobList[zoneID][109].pos = {  -53.2480, -13.2613,  121.7133, 170 } -- Bridge to HT #1
xi.dynamis.mobList[zoneID][110].pos = {  -51.1625, -13.5000,  128.1870, 42  } -- Bridge to HT #3
xi.dynamis.mobList[zoneID][111].pos = {  -48.9547, -13.5000,  124.2935, 170 } -- Bridge to HT #4
xi.dynamis.mobList[zoneID][112].pos = {  -45.7040, -13.5000,  131.2713, 42  } -- Bridge to HT #6
xi.dynamis.mobList[zoneID][113].pos = {  -43.1181, -13.5000,  127.9526, 170 } -- Bridge to HT #5
xi.dynamis.mobList[zoneID][114].pos = {  -29.6329, -16.0000,  180.4627, 67  }
xi.dynamis.mobList[zoneID][115].pos = {   30.1441, -16.0000,  180.0908, 66  }
xi.dynamis.mobList[zoneID][116].pos = {   -0.1259, -16.7500,  135.3097, 63  }
xi.dynamis.mobList[zoneID][117].pos = {   -1.9202, -16.7500,  132.4733, 63  }
xi.dynamis.mobList[zoneID][118].pos = {    1.5785, -16.7500,  130.8298, 68  }
xi.dynamis.mobList[zoneID][119].pos = {  -79.2530,  -9.6845,  112.8428, 104 }
xi.dynamis.mobList[zoneID][120].pos = {  -76.7854,  -9.8010,  107.8378, 108 }
xi.dynamis.mobList[zoneID][121].pos = {   43.6181,  -2.2996,  -65.4926, 64  }
xi.dynamis.mobList[zoneID][122].pos = {   40.3916,  -2.5000,  -59.3094, 67  }
xi.dynamis.mobList[zoneID][123].pos = {   48.2035,  -2.5000,  -59.4354, 65  }
xi.dynamis.mobList[zoneID][124].pos = {   35.9184,  -2.3574,  -65.5872, 62  }
xi.dynamis.mobList[zoneID][125].pos = {   52.4692,  -2.5000,  -66.7366, 80  }
xi.dynamis.mobList[zoneID][126].pos = {    2.0926,  -9.6610,    4.3648, 52  }
xi.dynamis.mobList[zoneID][127].pos = {   -8.2887,  -8.1750,    0.9049, 61  }
xi.dynamis.mobList[zoneID][128].pos = {   15.3171,  -9.7436,  -20.1585, 199 }
xi.dynamis.mobList[zoneID][129].pos = {  -15.3458,  -9.4624,  -20.5847, 200 }
xi.dynamis.mobList[zoneID][130].pos = {  -24.7360,  -2.5000,  -62.6215, 84  }
xi.dynamis.mobList[zoneID][131].pos = {  -42.5879,  -2.5000,  -93.5101, 82  }
xi.dynamis.mobList[zoneID][132].pos = {  -52.6701,  -2.5000, -110.9600, 114 }
xi.dynamis.mobList[zoneID][133].pos = {  -97.5736,  -2.5000, -123.1625, 116 }
xi.dynamis.mobList[zoneID][134].pos = { -203.1892,   0.0000, -102.3044, 139 }
xi.dynamis.mobList[zoneID][135].pos = { -203.7979,  -0.2568, -139.7601, 127 }
xi.dynamis.mobList[zoneID][136].pos = { -224.4653,  -0.2500,  -98.4432, 3   }
xi.dynamis.mobList[zoneID][137].pos = { -224.6530,  -0.2500, -142.7501, 2   }
xi.dynamis.mobList[zoneID][138].pos = {   83.4762,  -2.5000,   78.5478, 81  }
xi.dynamis.mobList[zoneID][139].pos = {   79.1087,  -2.5000,   79.9801, 78  }
xi.dynamis.mobList[zoneID][140].pos = {   88.7325,  -5.2644,  147.4140, 141 }
xi.dynamis.mobList[zoneID][141].pos = {   88.6722,  -5.4650,  153.6191, 129 }
xi.dynamis.mobList[zoneID][142].pos = {   88.1672,  -7.5000,  200.0317, 68  }
xi.dynamis.mobList[zoneID][143].pos = {  -18.3020, -12.4241,  242.4440, 165 }
xi.dynamis.mobList[zoneID][144].pos = {  -88.6582, -12.4611,  204.1679, 34  }
xi.dynamis.mobList[zoneID][145].pos = {  -67.7383, -11.6475,  182.5894, 198 }
xi.dynamis.mobList[zoneID][146].pos = {  -73.0340,  -8.9370,  170.9037, 218 }
xi.dynamis.mobList[zoneID][147].pos = {  -88.9700,  -6.1359,  162.0545, 244 }
xi.dynamis.mobList[zoneID][148].pos = { -151.7798,  -2.5000,  148.1190, 1   }
xi.dynamis.mobList[zoneID][149].pos = {   -0.2031, -16.0000,  195.0251, 63  }
xi.dynamis.mobList[zoneID][150].pos = {   35.0899, -16.0000,  160.1173, 65  }

----------------------------------------------------------------------------------------------------
--                                    Setup of Mob Functions                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--             Patrol Paths             --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].patrolPath = {xpos1,ypos1,zpos1, xpos2,ypos2,zpos2,  xpos3,ypos3,zpos3}

xi.dynamis.mobList[zoneID].patrolPaths = { 8, 10, 13, 17, 18, 19, 52, 73, 62, 63, 64, 89, 91, 107, 106, 104, 105 }
xi.dynamis.mobList[zoneID][8  ].patrolPath = { {-96,  -2, -123}, {-60,  -2, -113},                   }    -- Entrance Bridge W
xi.dynamis.mobList[zoneID][10 ].patrolPath = { {-48,  -2, -104}, {-29,  -2,  -70},                   }    -- Entrance Bridge E
xi.dynamis.mobList[zoneID][13 ].patrolPath = { { 0,  -9,  -20 }, {-0,  -4,  -51 },                   }    -- AH W Ramp
xi.dynamis.mobList[zoneID][17 ].patrolPath = { {38,  -2,  -60 }, {38,  -2,  -67 },                   }     -- AH #1
xi.dynamis.mobList[zoneID][18 ].patrolPath = { {46,  -1,  -70 }, {46,  -2,  -59 },                   }     -- AH #2
xi.dynamis.mobList[zoneID][19 ].patrolPath = { {54,  -2,  -60 }, {54,  -2,  -67 },                   }     -- AH #3
xi.dynamis.mobList[zoneID][52 ].patrolPath = { {99,  -8,  179 }, {102, -8, 176  }, {108, -11,  171}, } -- E House Ramp
xi.dynamis.mobList[zoneID][73 ].patrolPath = { {-84,  -9,  111}, {-85,  -6,  121},                   } -- Island to HT
xi.dynamis.mobList[zoneID][62 ].patrolPath = { {-88,  -2,   48}, {-88,  -5,   82},                   } -- SW Bridge #1
xi.dynamis.mobList[zoneID][63 ].patrolPath = { {-88,  -2,   48}, {-88,  -5,   82},                   } -- SW Bridge #2
xi.dynamis.mobList[zoneID][64 ].patrolPath = { {-88,  -2,   48}, {-88,  -5,   82},                   } -- SW Bridge #3
xi.dynamis.mobList[zoneID][89 ].patrolPath = { {-57, -13,  226}, {-61, -13,  209},                   } -- NW Bridge S
xi.dynamis.mobList[zoneID][91 ].patrolPath = { {-52, -13,  234}, {-36, -13,  244},                   } -- NW Bridge N
xi.dynamis.mobList[zoneID][107].patrolPath = { {48,  -8,  213 }, {48,  -8,  216 },                   } -- Bridge to HotH #4
xi.dynamis.mobList[zoneID][106].patrolPath = { {54,  -8,  220 }, {51,  -8,  220 },                   } -- Bridge to HotH #1
xi.dynamis.mobList[zoneID][104].patrolPath = { {48,  -8,  226 }, {48,  -8,  223 },                   } -- Bridge to HotH #3
xi.dynamis.mobList[zoneID][105].patrolPath = { {42,  -8,  219 }, {45,  -8,  219 },                   } -- Bridge to HotH #2

------------------------------------------
--          Statue Eye Colors           --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eye.BLUE -- Flags for blue eyes. (HP)
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eye.GREEN -- Flags for green eyes. (MP)

xi.dynamis.mobList[zoneID][6  ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][8  ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][12 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][17 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][19 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][24 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][25 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][29 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][30 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][32 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][35 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][40 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][42 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][45 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][51 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][56 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][57 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][60 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][72 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][74 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][77 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][80 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][83 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][88 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][94 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][95 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][100].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][110].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][111].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][117].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][118].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][126].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][127].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][131].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][133].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][136].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][137].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][138].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][139].eyes = xi.dynamis.eye.GREEN

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].timeExtension = 15

xi.dynamis.mobList[zoneID].timeExtensionList = {8, 18, 31, 41, 58, 66, 101, 121}
xi.dynamis.mobList[zoneID][8  ].timeExtension = 20 --Avatar Icon
xi.dynamis.mobList[zoneID][18 ].timeExtension = 20 --Avatar Icon
xi.dynamis.mobList[zoneID][31 ].timeExtension = 10 --Avatar Icon
xi.dynamis.mobList[zoneID][41 ].timeExtension = 20 --Avatar Icon
xi.dynamis.mobList[zoneID][58 ].timeExtension = 20 --Avatar Icon
xi.dynamis.mobList[zoneID][66 ].timeExtension = 20 --Avatar Icon
xi.dynamis.mobList[zoneID][101].timeExtension = 10 --Avatar Icon
xi.dynamis.mobList[zoneID][121].timeExtension = 30 --Tzee_Xicu_Idol
