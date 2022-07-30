----------------------------------------------------------------------------------------------------
--                                      Dynamis-Xarcabard                                            --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/xar.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/xar.html        --
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
local zoneID = xi.zone.DYNAMIS_XARCABARD
local i = 1
xi = xi or {} -- Ignore me I just set the global.
xi.dynamis = xi.dynamis or {} -- Ignore me I just set the global.
xi.dynamis.mobList = xi.dynamis.mobList or { } -- Ignore me I just set the global.
xi.dynamis.mobList[zoneID] = { } -- Ignore me, I just start the table.
xi.dynamis.mobList[zoneID].nmchildren = { }
xi.dynamis.mobList[zoneID].mobchildren = { }
xi.dynamis.mobList[zoneID].maxWaves = 6 -- Put in number of max waves

while i <= 258 do
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

xi.dynamis.mobList[zoneID][1  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (001-D)
xi.dynamis.mobList[zoneID][2  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (002-D)
xi.dynamis.mobList[zoneID][3  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (003-D)
xi.dynamis.mobList[zoneID][4  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (004-D)
xi.dynamis.mobList[zoneID][5  ].info = {"Statue", "Statue Prototype", nil, nil, nil} -- (005-G) Statue Prototype
xi.dynamis.mobList[zoneID][6  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (006-D)
xi.dynamis.mobList[zoneID][7  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (007-D)
xi.dynamis.mobList[zoneID][8  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (008-D)
xi.dynamis.mobList[zoneID][9  ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (009-D)
xi.dynamis.mobList[zoneID][10 ].info = {"Statue", "Tombstone Prototype", nil, nil, nil} -- (010-O)(30) Tombstone Prototype
xi.dynamis.mobList[zoneID][11 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (011-D)
xi.dynamis.mobList[zoneID][12 ].info = {"Statue", "Effigy Prototype", nil, nil, nil} -- (012-Q) Effigy Prototype
xi.dynamis.mobList[zoneID][13 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (013-D)
xi.dynamis.mobList[zoneID][14 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (014-D)
xi.dynamis.mobList[zoneID][15 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (015-D)
xi.dynamis.mobList[zoneID][16 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (016-D)
xi.dynamis.mobList[zoneID][17 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (017-D)
xi.dynamis.mobList[zoneID][18 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (018-D)
xi.dynamis.mobList[zoneID][19 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (019-D)
xi.dynamis.mobList[zoneID][20 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (020-D)
xi.dynamis.mobList[zoneID][21 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (021-D)
xi.dynamis.mobList[zoneID][22 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (022-D)
xi.dynamis.mobList[zoneID][23 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (023-D)
xi.dynamis.mobList[zoneID][24 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (024-D)
xi.dynamis.mobList[zoneID][25 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (025-D)
xi.dynamis.mobList[zoneID][26 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (026-D)
xi.dynamis.mobList[zoneID][27 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (027-D)
xi.dynamis.mobList[zoneID][28 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (028-D)
xi.dynamis.mobList[zoneID][29 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (029-D)
xi.dynamis.mobList[zoneID][30 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (030-D)
xi.dynamis.mobList[zoneID][31 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (031-D)
xi.dynamis.mobList[zoneID][32 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (032-D)
xi.dynamis.mobList[zoneID][33 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (033-D)
xi.dynamis.mobList[zoneID][34 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (034-D)
xi.dynamis.mobList[zoneID][35 ].info = {"Statue", "Vanguard Eye", nil, nil, "35_killed"} -- (035-D) Vanguard Eye (spawns 36-38)
xi.dynamis.mobList[zoneID][36 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (036-D)
xi.dynamis.mobList[zoneID][37 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (037-D)
xi.dynamis.mobList[zoneID][38 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (038-D)
xi.dynamis.mobList[zoneID][39 ].info = {"Statue", "Vanguard Eye", nil, nil, "39_killed"} -- (039-D) Vanguard Eye (spawns 40-42)
xi.dynamis.mobList[zoneID][40 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (040-D)
xi.dynamis.mobList[zoneID][41 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (041-D)
xi.dynamis.mobList[zoneID][42 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (042-D)
xi.dynamis.mobList[zoneID][43 ].info = {"Statue", "Icon Prototype", nil, nil, nil} -- (043-Y)(30) Icon Prototype
xi.dynamis.mobList[zoneID][44 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (044-D)
xi.dynamis.mobList[zoneID][45 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (045-D)
xi.dynamis.mobList[zoneID][46 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (046-D)
xi.dynamis.mobList[zoneID][47 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (047-D)
xi.dynamis.mobList[zoneID][48 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (048-D)
xi.dynamis.mobList[zoneID][49 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (049-D)
xi.dynamis.mobList[zoneID][50 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (050-D)
xi.dynamis.mobList[zoneID][51 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (051-D)
xi.dynamis.mobList[zoneID][52 ].info = {"Statue", "Icon Prototype", nil, nil, nil} -- (052-Y)(HP) Icon Prototype
xi.dynamis.mobList[zoneID][53 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (053-D)
xi.dynamis.mobList[zoneID][54 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (054-D)
xi.dynamis.mobList[zoneID][55 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (055-D)
xi.dynamis.mobList[zoneID][56 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (056-D)
xi.dynamis.mobList[zoneID][57 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (057-D)
xi.dynamis.mobList[zoneID][58 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (058-D)
xi.dynamis.mobList[zoneID][59 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (059-D)
xi.dynamis.mobList[zoneID][60 ].info = {"Statue", "Tombstone Prototype", nil, nil, nil} -- (060-O)(30) Tombstone Prototype
xi.dynamis.mobList[zoneID][61 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (061-D)
xi.dynamis.mobList[zoneID][62 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (062-D)
xi.dynamis.mobList[zoneID][63 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (063-D)
xi.dynamis.mobList[zoneID][64 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (064-D)
xi.dynamis.mobList[zoneID][65 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (065-D)
xi.dynamis.mobList[zoneID][66 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (066-D)
xi.dynamis.mobList[zoneID][67 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (067-D)
xi.dynamis.mobList[zoneID][68 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (068-D)
xi.dynamis.mobList[zoneID][69 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (069-D)
xi.dynamis.mobList[zoneID][70 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (070-D)
xi.dynamis.mobList[zoneID][71 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (071-D)
xi.dynamis.mobList[zoneID][72 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (072-D)
xi.dynamis.mobList[zoneID][73 ].info = {"Statue", "Icon Prototype", nil, nil, nil} -- (073-Y)(MP) Icon Prototype
xi.dynamis.mobList[zoneID][74 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (074-D)
xi.dynamis.mobList[zoneID][75 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (075-D)
xi.dynamis.mobList[zoneID][76 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (076-D)
xi.dynamis.mobList[zoneID][77 ].info = {"Statue", "Tombstone Prototype", nil, nil, nil} -- (077-O)(MP) Tombstone Prototype
xi.dynamis.mobList[zoneID][78 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (078-D)
xi.dynamis.mobList[zoneID][79 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (079-D)
xi.dynamis.mobList[zoneID][80 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (080-D)
xi.dynamis.mobList[zoneID][81 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (081-D)
xi.dynamis.mobList[zoneID][82 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (082-D)
xi.dynamis.mobList[zoneID][83 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (083-D)
xi.dynamis.mobList[zoneID][84 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (084-D)
xi.dynamis.mobList[zoneID][85 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (085-D)
xi.dynamis.mobList[zoneID][86 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (086-D)
xi.dynamis.mobList[zoneID][87 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (087-D)
xi.dynamis.mobList[zoneID][88 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (088-D)
xi.dynamis.mobList[zoneID][89 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (089-D)
xi.dynamis.mobList[zoneID][90 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (090-D)
xi.dynamis.mobList[zoneID][91 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (091-D)
xi.dynamis.mobList[zoneID][92 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (092-D)
xi.dynamis.mobList[zoneID][93 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (093-D)
xi.dynamis.mobList[zoneID][94 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (094-D)
xi.dynamis.mobList[zoneID][95 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (095-D)
xi.dynamis.mobList[zoneID][96 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (096-D)
xi.dynamis.mobList[zoneID][97 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (097-D)
xi.dynamis.mobList[zoneID][98 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (098-D)
xi.dynamis.mobList[zoneID][99 ].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (099-D)
xi.dynamis.mobList[zoneID][100].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (100-D)
xi.dynamis.mobList[zoneID][101].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (101-D)
xi.dynamis.mobList[zoneID][102].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (102-D)
xi.dynamis.mobList[zoneID][103].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (103-D)
xi.dynamis.mobList[zoneID][104].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (104-D)
xi.dynamis.mobList[zoneID][105].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (105-D)
xi.dynamis.mobList[zoneID][106].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (106-D)
xi.dynamis.mobList[zoneID][107].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (107-D)
xi.dynamis.mobList[zoneID][108].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (108-D)
xi.dynamis.mobList[zoneID][109].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (109-D)
xi.dynamis.mobList[zoneID][110].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (110-D)
xi.dynamis.mobList[zoneID][111].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (111-D)
xi.dynamis.mobList[zoneID][112].info = {"Statue", "Effigy Prototype", nil, nil, nil} -- (112-Q)(HP) Effigy Prototype
xi.dynamis.mobList[zoneID][113].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (113-D)
xi.dynamis.mobList[zoneID][114].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (114-D)
xi.dynamis.mobList[zoneID][115].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (115-D)
xi.dynamis.mobList[zoneID][116].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (116-D)
xi.dynamis.mobList[zoneID][117].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (117-D)
xi.dynamis.mobList[zoneID][118].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (118-D)
xi.dynamis.mobList[zoneID][119].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (119-D)
xi.dynamis.mobList[zoneID][120].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (120-D)
xi.dynamis.mobList[zoneID][121].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (121-D)
xi.dynamis.mobList[zoneID][122].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (122-D)
xi.dynamis.mobList[zoneID][123].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (123-D)
xi.dynamis.mobList[zoneID][124].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (124-D)
xi.dynamis.mobList[zoneID][125].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (125-D)
xi.dynamis.mobList[zoneID][126].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (126-D)
xi.dynamis.mobList[zoneID][127].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (127-D)  Pops Marquis Decarabia BRD
xi.dynamis.mobList[zoneID][128].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (128-D)  Pops Count Zaebos WAR
xi.dynamis.mobList[zoneID][129].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (129-D)  Pops Duke Berith RDM
xi.dynamis.mobList[zoneID][130].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (130-D)  Pops Prince Seere WHM
xi.dynamis.mobList[zoneID][131].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (131-D)  Pops Duke Gomory MNK
xi.dynamis.mobList[zoneID][132].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (132-D)  Pops Marquis Andras BST
xi.dynamis.mobList[zoneID][133].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (133-D)  Pops Marquis Gamygyn NIN
xi.dynamis.mobList[zoneID][134].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (134-D)  Pops Duke Scox DRK
xi.dynamis.mobList[zoneID][135].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (135-D)  Pops Marquis Orias BLM
xi.dynamis.mobList[zoneID][136].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (136-D)  Pops Count Raum THF
xi.dynamis.mobList[zoneID][137].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (137-D)  Pops Marquis Sabnak PLD
xi.dynamis.mobList[zoneID][138].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (138-D)  Pops Marquis Nebiros SMN
xi.dynamis.mobList[zoneID][139].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (139-D)  Pops King Zagan DRG
xi.dynamis.mobList[zoneID][140].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (140-D)  Pops Count Vine SAM
xi.dynamis.mobList[zoneID][141].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (141-D)  Pops Marquis Cimeries RNG
xi.dynamis.mobList[zoneID][142].info = {"Statue", "Effigy Prototype", nil, nil, nil} -- (142-Q)(HP)     Effigy Prototype
xi.dynamis.mobList[zoneID][143].info = {"Statue", "Statue Prototype", nil, nil, nil} -- (143-G)(30)     Statue Prototype
xi.dynamis.mobList[zoneID][144].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (144-D)
xi.dynamis.mobList[zoneID][145].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (145-D)
xi.dynamis.mobList[zoneID][146].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (146-D)
xi.dynamis.mobList[zoneID][147].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (147-D)
xi.dynamis.mobList[zoneID][148].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (148-D)
xi.dynamis.mobList[zoneID][149].info = {"Statue", "Vanguard Eye", nil, nil, nil} -- (149-D)
xi.dynamis.mobList[zoneID][150].info = {"Statue", "Statue Prototype", nil, nil, nil} -- (150-G)(30)     Statue Prototype
xi.dynamis.mobList[zoneID][151].info = {"NM", "Animated Hammer",    nil, nil, "hammer_killed"} -- ( 151 ) Animated Hammer
xi.dynamis.mobList[zoneID][152].info = {"NM", "Animated Dagger",    nil, nil, "dagger_killed"} -- ( 152 ) Animated Dagger
xi.dynamis.mobList[zoneID][153].info = {"NM", "Animated Shield",   nil, nil, "shield_killed"} -- ( 153 ) Animated Shield
xi.dynamis.mobList[zoneID][154].info = {"NM", "Animated Claymore", nil, nil, "claymore_killed"} -- ( 154 ) Animated Claymore
xi.dynamis.mobList[zoneID][155].info = {"NM", "Animated Gun",       nil, nil, "gun_killed"} -- ( 155 ) Animated Gun
xi.dynamis.mobList[zoneID][156].info = {"NM", "Animated Longbow",   nil, nil, "longbow_killed"} -- ( 156 ) Animated Longbow
xi.dynamis.mobList[zoneID][157].info = {"NM", "Animated Tachi",     nil, nil, "tachi_killed"} -- ( 157 ) Animated Tachi
xi.dynamis.mobList[zoneID][158].info = {"NM", "Animated Tabar",     nil, nil, "tabar_killed"} -- ( 158 ) Animated Tabar
xi.dynamis.mobList[zoneID][159].info = {"NM", "Animated Staff",     nil, nil, "staff_killed"} -- ( 159 ) Animated Staff
xi.dynamis.mobList[zoneID][160].info = {"NM", "Animated Spear",     nil, nil, "spear_killed"} -- ( 160 ) Animated Spear
xi.dynamis.mobList[zoneID][161].info = {"NM", "Animated Kunai",     nil, nil, "kunai_killed"} -- ( 161 ) Animated Kunai
xi.dynamis.mobList[zoneID][162].info = {"NM", "Animated Knuckles",  nil, nil, "knuckles_killed"} -- ( 162 ) Animated Knuckles
xi.dynamis.mobList[zoneID][163].info = {"NM", "Animated Great Axe", nil, nil, "gaxe_killed"} -- ( 163 ) Animated Great Axe
xi.dynamis.mobList[zoneID][164].info = {"NM", "Animated Horn",      nil, nil, "horn_killed"} -- ( 164 ) Animated Horn
xi.dynamis.mobList[zoneID][165].info = {"NM", "Animated Longsword", nil, nil, "longsword_killed"} -- ( 165 ) Animated Longsword
xi.dynamis.mobList[zoneID][166].info = {"NM", "Animated Scythe",    nil, nil, "scythe_killed"} -- ( 166 ) Animated Scythe
xi.dynamis.mobList[zoneID][167].info = {"Other", "Vanguard Dragon", nil, nil, nil} -- ( 167 ) Vanguard Dragon
xi.dynamis.mobList[zoneID][168].info = {"Other", "Vanguard Dragon", nil, nil, nil} -- ( 168 ) Vanguard Dragon
xi.dynamis.mobList[zoneID][169].info = {"Other", "Vanguard Dragon", nil, nil, nil} -- ( 169 ) Vanguard Dragon
xi.dynamis.mobList[zoneID][170].info = {"Other", "Vanguard Dragon", nil, nil, nil} -- ( 170 ) Vanguard Dragon
xi.dynamis.mobList[zoneID][171].info = {"Other", "Vanguard Dragon", nil, nil, nil} -- ( 171 ) Vanguard Dragon
xi.dynamis.mobList[zoneID][172].info = {"Other", "Vanguard Dragon", nil, nil, nil} -- ( 172 ) Vanguard Dragon
xi.dynamis.mobList[zoneID][173].info = {"Other", "Vanguard Dragon", nil, nil, nil} -- ( 173 ) Vanguard Dragon
xi.dynamis.mobList[zoneID][174].info = {"Other", "Vanguard Dragon", nil, nil, nil} -- ( 174 ) Vanguard Dragon
xi.dynamis.mobList[zoneID][175].info = {"Other", "Vanguard Dragon", nil, nil, nil} -- ( 175 ) Vanguard Dragon
xi.dynamis.mobList[zoneID][176].info = {"Other", "Vanguard Dragon", nil, nil, nil} -- ( 176 ) Vanguard Dragon
xi.dynamis.mobList[zoneID][177].info = {"NM", "Yang",                nil, nil, "yang_killed"} -- ( 177 ) Shadow Dragon NM (Yang)
xi.dynamis.mobList[zoneID][178].info = {"NM", "Ying",                nil, nil, "ying_killed"} -- ( 178 ) Shadow Dragon NM (Ying)
xi.dynamis.mobList[zoneID][179].info = {"NM", "Dynamis Lord",        nil, nil, nil} -- ( 179 ) Dynamis Lord

-- Animated Hammer
xi.dynamis.mobList[zoneID][180].info = {"NM", "Satellite Hammer", nil, nil, nil} -- Satellite Hammer
xi.dynamis.mobList[zoneID][181].info = {"NM", "Satellite Hammer", nil, nil, nil} -- Satellite Hammer
xi.dynamis.mobList[zoneID][182].info = {"NM", "Satellite Hammer", nil, nil, nil} -- Satellite Hammer
xi.dynamis.mobList[zoneID][183].info = {"NM", "Satellite Hammer", nil, nil, nil} -- Satellite Hammer
-- Animated Dagger
xi.dynamis.mobList[zoneID][184].info = {"NM", "Satellite Dagger", nil, nil, nil} -- Satellite Dagger
xi.dynamis.mobList[zoneID][185].info = {"NM", "Satellite Dagger", nil, nil, nil} -- Satellite Dagger
xi.dynamis.mobList[zoneID][186].info = {"NM", "Satellite Dagger", nil, nil, nil} -- Satellite Dagger
xi.dynamis.mobList[zoneID][187].info = {"NM", "Satellite Dagger", nil, nil, nil} -- Satellite Dagger
-- Animated Shield
xi.dynamis.mobList[zoneID][188].info = {"NM", "Satellite Shield", nil, nil, nil} -- Satellite Shield
xi.dynamis.mobList[zoneID][189].info = {"NM", "Satellite Shield", nil, nil, nil} -- Satellite Shield
xi.dynamis.mobList[zoneID][190].info = {"NM", "Satellite Shield", nil, nil, nil} -- Satellite Shield
xi.dynamis.mobList[zoneID][191].info = {"NM", "Satellite Shield", nil, nil, nil} -- Satellite Shield
-- Animated Claymore
xi.dynamis.mobList[zoneID][192].info = {"NM", "Satellite Claymore", nil, nil, nil} -- Satellite Claymore
xi.dynamis.mobList[zoneID][193].info = {"NM", "Satellite Claymore", nil, nil, nil} -- Satellite Claymore
xi.dynamis.mobList[zoneID][194].info = {"NM", "Satellite Claymore", nil, nil, nil} -- Satellite Claymore
xi.dynamis.mobList[zoneID][195].info = {"NM", "Satellite Claymore", nil, nil, nil} -- Satellite Claymore
-- Animated Gun
xi.dynamis.mobList[zoneID][196].info = {"NM", "Satellite Gun", nil, nil, nil} -- Satellite Gun
xi.dynamis.mobList[zoneID][197].info = {"NM", "Satellite Gun", nil, nil, nil} -- Satellite Gun
xi.dynamis.mobList[zoneID][198].info = {"NM", "Satellite Gun", nil, nil, nil} -- Satellite Gun
xi.dynamis.mobList[zoneID][199].info = {"NM", "Satellite Gun", nil, nil, nil} -- Satellite Gun
-- Animated Longbow
xi.dynamis.mobList[zoneID][200].info = {"NM", "Satellite Longbow", nil, nil, nil} -- Satellite Longbow
xi.dynamis.mobList[zoneID][201].info = {"NM", "Satellite Longbow", nil, nil, nil} -- Satellite Longbow
xi.dynamis.mobList[zoneID][202].info = {"NM", "Satellite Longbow", nil, nil, nil} -- Satellite Longbow
xi.dynamis.mobList[zoneID][203].info = {"NM", "Satellite Longbow", nil, nil, nil} -- Satellite Longbow
-- Animated Tachi
xi.dynamis.mobList[zoneID][204].info = {"NM", "Satellite Tachi", nil, nil, nil} -- Satellite Tachi
xi.dynamis.mobList[zoneID][205].info = {"NM", "Satellite Tachi", nil, nil, nil} -- Satellite Tachi
xi.dynamis.mobList[zoneID][206].info = {"NM", "Satellite Tachi", nil, nil, nil} -- Satellite Tachi
xi.dynamis.mobList[zoneID][207].info = {"NM", "Satellite Tachi", nil, nil, nil} -- Satellite Tachi
-- Animated Tabar
xi.dynamis.mobList[zoneID][208].info = {"NM", "Satellite Tabar", nil, nil, nil} -- Satellite Tabar
xi.dynamis.mobList[zoneID][209].info = {"NM", "Satellite Tabar", nil, nil, nil} -- Satellite Tabar
xi.dynamis.mobList[zoneID][210].info = {"NM", "Satellite Tabar", nil, nil, nil} -- Satellite Tabar
xi.dynamis.mobList[zoneID][211].info = {"NM", "Satellite Tabar", nil, nil, nil} -- Satellite Tabar
-- Animated Staff
xi.dynamis.mobList[zoneID][212].info = {"NM", "Satellite Staff", nil, nil, nil} -- Satellite Staff
xi.dynamis.mobList[zoneID][213].info = {"NM", "Satellite Staff", nil, nil, nil} -- Satellite Staff
xi.dynamis.mobList[zoneID][214].info = {"NM", "Satellite Staff", nil, nil, nil} -- Satellite Staff
xi.dynamis.mobList[zoneID][215].info = {"NM", "Satellite Staff", nil, nil, nil} -- Satellite Staff
-- Animated Spear
xi.dynamis.mobList[zoneID][216].info = {"NM", "Satellite Spear", nil, nil, nil} -- Satellite Spear
xi.dynamis.mobList[zoneID][217].info = {"NM", "Satellite Spear", nil, nil, nil} -- Satellite Spear
xi.dynamis.mobList[zoneID][218].info = {"NM", "Satellite Spear", nil, nil, nil} -- Satellite Spear
xi.dynamis.mobList[zoneID][219].info = {"NM", "Satellite Spear", nil, nil, nil} -- Satellite Spear
-- Animated Kunai
xi.dynamis.mobList[zoneID][220].info = {"NM", "Satellite Kunai", nil, nil, nil} -- Satellite Kunai
xi.dynamis.mobList[zoneID][221].info = {"NM", "Satellite Kunai", nil, nil, nil} -- Satellite Kunai
xi.dynamis.mobList[zoneID][222].info = {"NM", "Satellite Kunai", nil, nil, nil} -- Satellite Kunai
xi.dynamis.mobList[zoneID][223].info = {"NM", "Satellite Kunai", nil, nil, nil} -- Satellite Kunai
-- Animated Knuckles
xi.dynamis.mobList[zoneID][224].info = {"NM", "Satellite Knuckles", nil, nil, nil} -- Satellite Knuckles
xi.dynamis.mobList[zoneID][225].info = {"NM", "Satellite Knuckles", nil, nil, nil} -- Satellite Knuckles
xi.dynamis.mobList[zoneID][226].info = {"NM", "Satellite Knuckles", nil, nil, nil} -- Satellite Knuckles
xi.dynamis.mobList[zoneID][227].info = {"NM", "Satellite Knuckles", nil, nil, nil} -- Satellite Knuckles
-- Animated Great Axe
xi.dynamis.mobList[zoneID][228].info = {"NM", "Satellite Great Axe", nil, nil, nil} -- Satellite Great Axe
xi.dynamis.mobList[zoneID][229].info = {"NM", "Satellite Great Axe", nil, nil, nil} -- Satellite Great Axe
xi.dynamis.mobList[zoneID][230].info = {"NM", "Satellite Great Axe", nil, nil, nil} -- Satellite Great Axe
xi.dynamis.mobList[zoneID][231].info = {"NM", "Satellite Great Axe", nil, nil, nil} -- Satellite Great Axe
-- Animated Horn
xi.dynamis.mobList[zoneID][232].info = {"NM", "Satellite Horn", nil, nil, nil} -- Satellite Horn
xi.dynamis.mobList[zoneID][233].info = {"NM", "Satellite Horn", nil, nil, nil} -- Satellite Horn
xi.dynamis.mobList[zoneID][234].info = {"NM", "Satellite Horn", nil, nil, nil} -- Satellite Horn
xi.dynamis.mobList[zoneID][235].info = {"NM", "Satellite Horn", nil, nil, nil} -- Satellite Horn
-- Animated Longsword
xi.dynamis.mobList[zoneID][236].info = {"NM", "Satellite Longsword", nil, nil, nil} -- Satellite Longsword
xi.dynamis.mobList[zoneID][237].info = {"NM", "Satellite Longsword", nil, nil, nil} -- Satellite Longsword
xi.dynamis.mobList[zoneID][238].info = {"NM", "Satellite Longsword", nil, nil, nil} -- Satellite Longsword
xi.dynamis.mobList[zoneID][239].info = {"NM", "Satellite Longsword", nil, nil, nil} -- Satellite Longsword
-- Animated Scythe
xi.dynamis.mobList[zoneID][240].info = {"NM", "Satellite Scythe", nil, nil, nil} -- Satellite Scythe
xi.dynamis.mobList[zoneID][241].info = {"NM", "Satellite Scythe", nil, nil, nil} -- Satellite Scythe
xi.dynamis.mobList[zoneID][242].info = {"NM", "Satellite Scythe", nil, nil, nil} -- Satellite Scythe
xi.dynamis.mobList[zoneID][243].info = {"NM", "Satellite Scythe", nil, nil, nil} -- Satellite Scythe
-- Demon NMs
xi.dynamis.mobList[zoneID][244].info = {"NM", "Marquis Decarabia",   "Kindred", "BRD", "Decarabia_killed"  } -- Marquis Decarabia
xi.dynamis.mobList[zoneID][245].info = {"NM", "Count Zaebos",        "Kindred", "WAR", "Zaebos_killed"     } -- Count Zaebos
xi.dynamis.mobList[zoneID][246].info = {"NM", "Duke Berith",         "Kindred", "RDM", "Berith_killed"     } -- Duke Berith
xi.dynamis.mobList[zoneID][247].info = {"NM", "Prince Seere",        "Kindred", "WHM", "Seere_killed"      } -- Prince Seere
xi.dynamis.mobList[zoneID][248].info = {"NM", "Duke Gomory",         "Kindred", "MNK", "Gomory_killed"     } -- Duke Gomory
xi.dynamis.mobList[zoneID][249].info = {"NM", "Marquis Andras",      "Kindred", "BST", "Andras_killed"     } -- Marquis Andras
xi.dynamis.mobList[zoneID][250].info = {"NM", "Marquis Gamygyn",     "Kindred", "NIN", "Gamygyn_killed"    } -- Marquis Gamygyn
xi.dynamis.mobList[zoneID][251].info = {"NM", "Duke Scox",           "Kindred", "DRK", "Scox_killed"       } -- Duke Scox
xi.dynamis.mobList[zoneID][252].info = {"NM", "Marquis Orias",       "Kindred", "BLM", "Orias_killed"      } -- Marquis Orias
xi.dynamis.mobList[zoneID][253].info = {"NM", "Count Raum",          "Kindred", "THF", "Raum_killed"       } -- Count Raum
xi.dynamis.mobList[zoneID][254].info = {"NM", "Marquis Sabnak",      "Kindred", "PLD", "Sabnak_killed"     } -- Marquis Sabnak
xi.dynamis.mobList[zoneID][255].info = {"NM", "Marquis Nebiros",     "Kindred", "SMN", "Nebiros_killed"    } -- Marquis Nebiros
xi.dynamis.mobList[zoneID][256].info = {"NM", "King Zagan",          "Kindred", "DRG", "Zagan_killed"      } -- King Zagan
xi.dynamis.mobList[zoneID][257].info = {"NM", "Count Vine",          "Kindred", "SAM", "Vine_killed"       } -- Count Vine
xi.dynamis.mobList[zoneID][258].info = {"NM", "Marquis Cimeries",    "Kindred", "RNG", "Cimeries_killed"   } -- Marquis Cimeries

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
    {"35_killed","39_killed"}, -- Spawns 43
    {"58_killed"}, -- Spawns 60
    {"142_killed", "143_killed", "144_killed", "145_killed", "146_killed", "147_killed", "148_killed", "149_killed"},    -- Spawns 150
    {"Decarabia_killed", "Zaebos_killed", "Berith_killed", "Seere_killed", "Gomory_killed", "Andras_killed", "Gamygyn_killed", "Scox_killed", "Orias_killed", "Raum_killed", "Sabnak_killed", "Nebiros_killed", "Zagan_killed", "Vine_killed", "Cimeries_killed"},  -- Demon NMs spawn Animated Weapons, Vanguard Dragons, Ying, Yang
    {"ying_killed", "yang_killed"} -- Spawns Dynalord
}

------------------------------------------
--            Wave Spawning             --
-- Note: Wave 1 spawns at start.        --
------------------------------------------
--xi.dynamis.mobList[zoneID].wave# = { MobIndex#1, MobIndex#2, MobIndex#3 }

xi.dynamis.mobList[zoneID][1].wave =
{
    1  , -- (001-D)  Avatar Icon
    2  , -- (002-D)  Avatar Icon
    3  , -- (003-D)  Avatar Icon
    4  , -- (004-D)  Avatar Icon
    5  , -- (005-G)  Avatar Icon
    6  , -- (006-D)  Manifest Icon
    7  , -- (007-D)  Avatar Icon
    8  , -- (008-D)  Manifest Icon
    9  , -- (009-D)  Avatar Icon
    10 , -- (010-O)  Avatar Icon
    11 , -- (011-D)  Avatar Icon
    12 , -- (012-Q)  Manifest Icon
    13 , -- (013-D)  Avatar Icon
    14 , -- (014-D)  Avatar Icon
    15 , -- (015-D)  Avatar Icon
    16 , -- (016-D)  Avatar Icon
    17 , -- (017-D)  Manifest Icon
    18 , -- (018-D)  Avatar Icon
    19 , -- (019-D)  Manifest Icon
    20 , -- (020-D)  Avatar Icon
    21 , -- (021-D)  Avatar Icon
    22 , -- (022-D)  Avatar Icon
    23 , -- (023-D)  Avatar Icon
    24 , -- (024-D)  Manifest Icon
    25 , -- (025-D)  Manifest Icon
    26 , -- (026-D)  Avatar Icon
    27 , -- (027-D)  Avatar Icon
    28 , -- (028-D)  Avatar Icon
    29 , -- (029-D)  Manifest Icon
    30 , -- (030-D)  Manifest Icon
    31 , -- (031-D)  Avatar Icon
    32 , -- (032-D)  Avatar Icon
    33 , -- (033-D)  Manifest Icon
    34 , -- (034-D)  Avatar Icon
    38 , -- (038-D)  Avatar Icon
    42 , -- (042-D)  Manifest Icon
    44 , -- (044-D)  Avatar Icon
    45 , -- (045-D)  Manifest Icon
    46 , -- (046-D)  Avatar Idol
    47 , -- (047-D)  Avatar Icon
    48 , -- (048-D)  Avatar Icon
    49 , -- (049-D)  Avatar Icon
    50 , -- (050-D)  Avatar Icon
    51 , -- (051-D)  Manifest Icon
    52 , -- (052-Y)  Avatar Icon
    53 , -- (053-D)  Avatar Icon
    54 , -- (054-D)  Avatar Icon
    55 , -- (055-D)  Avatar Icon
    56 , -- (056-D)  Manifest Icon
    57 , -- (057-D)  Manifest Icon
    58 , -- (058-D)  Avatar Icon
    59 , -- (059-D)  Avatar Icon
    61 , -- (061-D)  Avatar Icon
    62 , -- (062-D)  Avatar Icon
    63 , -- (063-D)  Avatar Icon
    64 , -- (064-D)  Avatar Icon
    65 , -- (065-D)  Avatar Icon
    66 , -- (066-D)  Avatar Icon
    67 , -- (067-D)  Avatar Icon
    68 , -- (068-D)  Avatar Icon
    69 , -- (069-D)  Avatar Icon
    70 , -- (070-D)  Avatar Icon
    71 , -- (071-D)  Avatar Icon
    72 , -- (072-D)  Manifest Icon
    73 , -- (073-Y)  Avatar Icon
    74 , -- (074-D)  Manifest Icon
    75 , -- (075-D)  Avatar Icon
    76 , -- (076-D)  Avatar Icon
    77 , -- (077-O)  Manifest Icon
    78 , -- (078-D)  Avatar Icon
    79 , -- (079-D)  Avatar Icon
    80 , -- (080-D)  Manifest Icon
    81 , -- (081-D)  Avatar Icon
    82 , -- (082-D)  Avatar Icon
    83 , -- (083-D)  Manifest Icon
    84 , -- (084-D)  Avatar Idol
    85 , -- (085-D)  Avatar Icon
    86 , -- (086-D)  Manifest Icon
    87 , -- (087-D)  Avatar Icon
    88 , -- (088-D)  Manifest Icon
    89 , -- (089-D)  Avatar Icon
    90 , -- (090-D)  Avatar Icon
    91 , -- (091-D)  Avatar Icon
    92 , -- (092-D)  Avatar Icon
    93 , -- (093-D)  Avatar Idol
    94 , -- (094-D)  Manifest Icon
    95 , -- (095-D)  Manifest Icon
    96 , -- (096-D)  Manifest Icon
    97 , -- (097-D)  Avatar Icon
    98 , -- (098-D)  Avatar Icon
    99 , -- (099-D)  Avatar Icon
    100, -- (100-D)  Manifest Icon
    101, -- (101-D)  Avatar Icon
    102, -- (102-D)  Avatar Icon
    103, -- (103-D)  Avatar Icon
    104, -- (104-D)  Avatar Icon
    105, -- (105-D)  Avatar Icon
    106, -- (106-D)  Avatar Icon
    107, -- (107-D)  Avatar Icon
    108, -- (108-D)  Avatar Icon
    109, -- (109-D)  Avatar Icon
    110, -- (110-D)  Manifest Icon
    111, -- (111-D)  Manifest Icon
    112, -- (112-Q)  Avatar Icon
    113, -- (113-D)  Avatar Icon
    114, -- (114-D)  Avatar Icon
    115, -- (115-D)  Avatar Icon
    116, -- (116-D)  Manifest Idol
    117, -- (117-D)  Manifest Icon
    118, -- (118-D)  Manifest Icon
    119, -- (119-D)  Avatar Icon
    120, -- (120-D)  Avatar Icon
    121, -- (121-D)  #N/A
    122, -- (122-D)  Avatar Icon
    123, -- (123-D)  Avatar Icon
    124, -- (124-D)  Avatar Icon
    125, -- (125-D)  Avatar Icon
    126, -- (126-D)  Manifest Icon
    127, -- (127-D)  Manifest Icon
    128, -- (128-D)  Avatar Icon
    129, -- (129-D)  Avatar Icon
    130, -- (130-D)  Avatar Icon
    131, -- (131-D)  Manifest Icon
    132, -- (132-D)  Avatar Icon
    133, -- (133-D)  Manifest Icon
    134, -- (134-D)  Avatar Icon
    135, -- (135-D)  Avatar Icon
    136, -- (136-D)  Manifest Icon
    137, -- (137-D)  Manifest Icon
    138, -- (138-D)  Manifest Icon
    139, -- (139-D)  Manifest Icon
    140, -- (140-D)  Avatar Icon
    141, -- (141-D)  Avatar Icon
    142, -- (142-Q)  Avatar Icon
    143, -- (143-G)  Avatar Icon
    144, -- (144-D)  Avatar Icon
    145, -- (145-D)  Avatar Icon
    146, -- (146-D)  Avatar Icon
    147, -- (147-D)  Avatar Icon
    148, -- (148-D)  Avatar Icon
    149  -- (149-D)  Avatar Icon
}

xi.dynamis.mobList[zoneID][2].wave =
{
    43   -- Icon Prototype
}

xi.dynamis.mobList[zoneID][3].wave =
{
    60   -- Tombstone Prototype
}

xi.dynamis.mobList[zoneID][4].wave =
{
    150  -- Statue Prototype
}

xi.dynamis.mobList[zoneID][5].wave =
{
    151, -- Animated Hammer
    152, -- Animated Dagger
    153, -- Animated Shield
    154, -- Animated Claymore
    155, -- Animated Gun
    156, -- Animated Longbow
    157, -- Animated Tachi
    158, -- Animated Tabar
    159, -- Animated Staff
    160, -- Animated Spear
    161, -- Animated Kunai
    162, -- Animated Knuckles
    163, -- Animated Great Axe
    164, -- Animated Horn
    165, -- Animated Longsword
    166, -- Animated Scythe
    167, -- Vanguard Dragon
    168, -- Vanguard Dragon
    169, -- Vanguard Dragon
    170, -- Vanguard Dragon
    171, -- Vanguard Dragon
    172, -- Vanguard Dragon
    173, -- Vanguard Dragon
    174, -- Vanguard Dragon
    175, -- Vanguard Dragon
    176, -- Vanguard Dragon
    177, -- Shadow Dragon NM (Yang)
    178  -- Shadow Dragon NM (Ying)
}

xi.dynamis.mobList[zoneID][6].wave =
{
    179  -- Dynamis Lord
}
----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

xi.dynamis.mobList[zoneID][1  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  }  --   2 SAM
xi.dynamis.mobList[zoneID][2  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2  }  --   2 SMN
xi.dynamis.mobList[zoneID][3  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  }  --   2 DRG
xi.dynamis.mobList[zoneID][4  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  }  --   2 NIN
xi.dynamis.mobList[zoneID][6  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil  }  --   3 BST
xi.dynamis.mobList[zoneID][7  ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   2, nil  }  --   1 PLD  2 DRG
xi.dynamis.mobList[zoneID][8  ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   2, nil, nil, nil, nil, nil, nil, nil  }  --   1 PLD  2 DRK
xi.dynamis.mobList[zoneID][9  ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   2, nil, nil, nil, nil, nil, nil, nil  }  --   1 PLD  2 DRK
xi.dynamis.mobList[zoneID][11 ].mobchildren = {   1,   1,   1,   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WAR  1 MNK  1 WHM  1 BLM  1 RDM  1 THF
xi.dynamis.mobList[zoneID][13 ].mobchildren = {   1,   1,   1,   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WAR  1 MNK  1 WHM  1 BLM  1 RDM  1 THF
xi.dynamis.mobList[zoneID][14 ].mobchildren = { nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 RDM  1 PLD
xi.dynamis.mobList[zoneID][15 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 MNK  1 WHM
xi.dynamis.mobList[zoneID][16 ].mobchildren = { nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 RDM  1 PLD
xi.dynamis.mobList[zoneID][17 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   3, nil, nil  }  --   1 BRD  3 NIN
xi.dynamis.mobList[zoneID][18 ].mobchildren = {   3, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   3 WAR  1 BRD
xi.dynamis.mobList[zoneID][19 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   3, nil, nil, nil  }  --   1 BRD  3 SAM
xi.dynamis.mobList[zoneID][20 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   2, nil, nil, nil  }  --   1 RNG  2 SAM
xi.dynamis.mobList[zoneID][21 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  --   1 THF  1 NIN
xi.dynamis.mobList[zoneID][22 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   2, nil, nil, nil  }  --   1 RNG  2 SAM
xi.dynamis.mobList[zoneID][23 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  --   2 THF  1 NIN
xi.dynamis.mobList[zoneID][24 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  --   1 THF  1 NIN
xi.dynamis.mobList[zoneID][25 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  --   2 THF  1 NIN
xi.dynamis.mobList[zoneID][26 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  }  --   2 DRG
xi.dynamis.mobList[zoneID][27 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  --   2 BST
xi.dynamis.mobList[zoneID][28 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2  }  --   2 SMN
xi.dynamis.mobList[zoneID][29 ].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 WAR
xi.dynamis.mobList[zoneID][30 ].mobchildren = { nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 MNK
xi.dynamis.mobList[zoneID][31 ].mobchildren = { nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 WHM
xi.dynamis.mobList[zoneID][32 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 BLM
xi.dynamis.mobList[zoneID][33 ].mobchildren = { nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 RDM
xi.dynamis.mobList[zoneID][34 ].mobchildren = { nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 THF
xi.dynamis.mobList[zoneID][44 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }  --   1 BLM  1 RNG
xi.dynamis.mobList[zoneID][45 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }  --   1 BLM  1 RNG
xi.dynamis.mobList[zoneID][46 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }  --   1 BLM  1 RNG
xi.dynamis.mobList[zoneID][47 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }  --   1 BLM  1 RNG
xi.dynamis.mobList[zoneID][48 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil,   2,   1, nil, nil, nil, nil, nil  }  --   1 WHM  2 BST  1 BRD
xi.dynamis.mobList[zoneID][49 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1  }  --   1 MNK  1 NIN  1 SMN
xi.dynamis.mobList[zoneID][50 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil,   2,   1, nil, nil, nil, nil, nil  }  --   1 WHM  2 BST  1 BRD
xi.dynamis.mobList[zoneID][51 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1  }  --   1 MNK  1 NIN  1 SMN
xi.dynamis.mobList[zoneID][53 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1,   1,   1  }  --   1 SAM  1 NIN  1 DRG  1 SMN
xi.dynamis.mobList[zoneID][54 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1,   1,   1,   1, nil, nil, nil, nil  }  --   1 PLD  1 DRK  1 BST  1 BRD  1 RNG
xi.dynamis.mobList[zoneID][55 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1,   1,   1  }  --   1 SAM  1 NIN  1 DRG  1 SMN
xi.dynamis.mobList[zoneID][56 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1,   1,   1,   1, nil, nil, nil, nil  }  --   1 PLD  1 DRK  1 BST  1 BRD  1 RNG
xi.dynamis.mobList[zoneID][57 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil,   1, nil  }  --   1 RNG  1 SAM  1 DRG
xi.dynamis.mobList[zoneID][58 ].mobchildren = { nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil,   1  }  --   1 THF  1 PLD  1 SMN
xi.dynamis.mobList[zoneID][59 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil  }  --   1 BLM  1 DRK  1 NIN
xi.dynamis.mobList[zoneID][61 ].mobchildren = {   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WAR  1 MNK  1 WHM
xi.dynamis.mobList[zoneID][62 ].mobchildren = { nil, nil, nil,   1, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 BLM  2 THF
xi.dynamis.mobList[zoneID][63 ].mobchildren = { nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   3 RDM
xi.dynamis.mobList[zoneID][64 ].mobchildren = { nil, nil, nil,   1, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 BLM  2 THF
xi.dynamis.mobList[zoneID][65 ].mobchildren = {   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WAR  1 MNK  1 WHM
xi.dynamis.mobList[zoneID][66 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil  }  --   1 BLM  3 DRK
xi.dynamis.mobList[zoneID][67 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil  }  --   1 BLM  3 SAM
xi.dynamis.mobList[zoneID][68 ].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WHM  1 BLM
xi.dynamis.mobList[zoneID][69 ].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 PLD
xi.dynamis.mobList[zoneID][70 ].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 PLD
xi.dynamis.mobList[zoneID][71 ].mobchildren = { nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   3 MNK
xi.dynamis.mobList[zoneID][72 ].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WHM  1 BLM
xi.dynamis.mobList[zoneID][74 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  }  --   2 DRG
xi.dynamis.mobList[zoneID][75 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  --   2 BST
xi.dynamis.mobList[zoneID][76 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3  }  --   3 SMN
xi.dynamis.mobList[zoneID][78 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  --   2 BST
xi.dynamis.mobList[zoneID][79 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  }  --   2 DRK
xi.dynamis.mobList[zoneID][80 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  }  --   2 RNG
xi.dynamis.mobList[zoneID][81 ].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 PLD
xi.dynamis.mobList[zoneID][82 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil  }  --   2 BRD
xi.dynamis.mobList[zoneID][83 ].mobchildren = {   2, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 WAR  1 RDM
xi.dynamis.mobList[zoneID][84 ].mobchildren = { nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 BLM
xi.dynamis.mobList[zoneID][85 ].mobchildren = {   2, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 WAR  1 RDM
xi.dynamis.mobList[zoneID][86 ].mobchildren = { nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 MNK  1 THF
xi.dynamis.mobList[zoneID][87 ].mobchildren = { nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 MNK  1 THF
xi.dynamis.mobList[zoneID][88 ].mobchildren = { nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 WHM
xi.dynamis.mobList[zoneID][89 ].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   2 WAR  1 BRD
xi.dynamis.mobList[zoneID][90 ].mobchildren = { nil,   2, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   2 MNK  1 BRD
xi.dynamis.mobList[zoneID][91 ].mobchildren = {   2, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   2 WAR  1 BRD
xi.dynamis.mobList[zoneID][92 ].mobchildren = { nil,   2, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   2 MNK  1 BRD
xi.dynamis.mobList[zoneID][93 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  }  --   2 RNG
xi.dynamis.mobList[zoneID][94 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil  }  --   3 SAM
xi.dynamis.mobList[zoneID][95 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  }  --   2 RNG
xi.dynamis.mobList[zoneID][96 ].mobchildren = { nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   3 THF
xi.dynamis.mobList[zoneID][97 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   1 WAR  1 RDM  1 BRD
xi.dynamis.mobList[zoneID][98 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil  }  --   1 MNK  1 WHM  1 BST
xi.dynamis.mobList[zoneID][99 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   1 MNK  1 BRD
xi.dynamis.mobList[zoneID][100].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   1 WAR  1 BRD
xi.dynamis.mobList[zoneID][101].mobchildren = {   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WAR  1 WHM
xi.dynamis.mobList[zoneID][102].mobchildren = { nil, nil,   1, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   1 WHM  1 RDM  1 BRD
xi.dynamis.mobList[zoneID][103].mobchildren = { nil, nil,   1, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  --   1 WHM  1 RDM  1 BRD
xi.dynamis.mobList[zoneID][104].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil,   1, nil, nil, nil, nil, nil  }  --   2 DRK  1 BRD
xi.dynamis.mobList[zoneID][105].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil,   1, nil, nil, nil, nil, nil  }  --   2 DRK  1 BRD
xi.dynamis.mobList[zoneID][106].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 PLD
xi.dynamis.mobList[zoneID][107].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  }  --   1 RDM  2 NIN
xi.dynamis.mobList[zoneID][108].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  }  --   1 RDM  2 NIN
xi.dynamis.mobList[zoneID][109].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil  }  --   3 DRG
xi.dynamis.mobList[zoneID][110].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2  }  --   2 SMN
xi.dynamis.mobList[zoneID][111].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  --   2 BST
xi.dynamis.mobList[zoneID][113].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  --   2 BST
xi.dynamis.mobList[zoneID][114].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3  }  --   3 SMN
xi.dynamis.mobList[zoneID][115].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil  }  --   1 RNG  1 DRG
xi.dynamis.mobList[zoneID][116].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil  }  --   1 RNG  1 DRG
xi.dynamis.mobList[zoneID][117].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1  }  --   1 PLD  1 SMN
xi.dynamis.mobList[zoneID][118].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1  }  --   1 PLD  1 SMN
xi.dynamis.mobList[zoneID][119].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil  }  --   3 RNG
xi.dynamis.mobList[zoneID][120].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1  }  --   1 PLD  1 SMN
xi.dynamis.mobList[zoneID][121].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 RDM
xi.dynamis.mobList[zoneID][122].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil  }  --   2 NIN
xi.dynamis.mobList[zoneID][123].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 RDM
xi.dynamis.mobList[zoneID][124].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  }  --   1 RDM  2 DRG
xi.dynamis.mobList[zoneID][125].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil  }  --   1 RDM  2 SAM
xi.dynamis.mobList[zoneID][126].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  }  --   2 DRK
xi.dynamis.mobList[zoneID][144].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WHM  1 BLM
xi.dynamis.mobList[zoneID][145].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WHM  1 BLM
xi.dynamis.mobList[zoneID][146].mobchildren = { nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  --   1 WHM  1 BLM
xi.dynamis.mobList[zoneID][147].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil  }  --   2 DRG
xi.dynamis.mobList[zoneID][148].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil  }  --   2 DRK
xi.dynamis.mobList[zoneID][149].mobchildren = { nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil, nil, nil  }  --   2 PLD

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].nmchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

xi.dynamis.mobList[zoneID][35 ].nmchildren = { true, 36, 37, 38 }
xi.dynamis.mobList[zoneID][39 ].nmchildren = { true, 40, 41, 42 }
xi.dynamis.mobList[zoneID][127].nmchildren = { true, 244 } -- Marquis Decarabia
xi.dynamis.mobList[zoneID][128].nmchildren = { true, 245 } -- Count Zaebos
xi.dynamis.mobList[zoneID][129].nmchildren = { true, 246 } -- Duke Berith
xi.dynamis.mobList[zoneID][130].nmchildren = { true, 247 } -- Prince Seere
xi.dynamis.mobList[zoneID][131].nmchildren = { true, 248 } -- Duke Gomory
xi.dynamis.mobList[zoneID][132].nmchildren = { true, 249 } -- Marquis Andras
xi.dynamis.mobList[zoneID][133].nmchildren = { true, 250 } -- Marquis Gamygyn
xi.dynamis.mobList[zoneID][134].nmchildren = { true, 251 } -- Duke Scox
xi.dynamis.mobList[zoneID][135].nmchildren = { true, 252 } -- Marquis Orias
xi.dynamis.mobList[zoneID][136].nmchildren = { true, 253 } -- Count Raum
xi.dynamis.mobList[zoneID][137].nmchildren = { true, 254 } -- Marquis Sabnak
xi.dynamis.mobList[zoneID][138].nmchildren = { true, 255 } -- Marquis Nebiros
xi.dynamis.mobList[zoneID][139].nmchildren = { true, 256 } -- King Zagan
xi.dynamis.mobList[zoneID][140].nmchildren = { true, 257 } -- Count Vine
xi.dynamis.mobList[zoneID][141].nmchildren = { true, 258 } -- Marquis Cimerie
xi.dynamis.mobList[zoneID][151].nmchildren = { true, 180, 181, 182, 183 } -- Satellite Hammer
xi.dynamis.mobList[zoneID][152].nmchildren = { true, 184, 185, 186, 187 } -- Satellite Dagger
xi.dynamis.mobList[zoneID][153].nmchildren = { true, 188, 189,	190, 191 } -- Satellite Shield
xi.dynamis.mobList[zoneID][154].nmchildren = { true, 192, 193,	194, 195 } -- Satellite Claymore
xi.dynamis.mobList[zoneID][155].nmchildren = { true, 196, 197,	198, 199 } -- Satellite Gun
xi.dynamis.mobList[zoneID][156].nmchildren = { true, 200, 201,	202, 203 } -- Satellite Longbow
xi.dynamis.mobList[zoneID][157].nmchildren = { true, 204, 205,	206, 207 } -- Satellite Tachi
xi.dynamis.mobList[zoneID][158].nmchildren = { true, 208, 209,	210, 211 } -- Satellite Tabar
xi.dynamis.mobList[zoneID][159].nmchildren = { true, 212, 213,	214, 215 } -- Satellite Staff
xi.dynamis.mobList[zoneID][160].nmchildren = { true, 216, 217,	218, 219 } -- Satellite Spear
xi.dynamis.mobList[zoneID][161].nmchildren = { true, 220, 221,	222, 223 } -- Satellite Kunai
xi.dynamis.mobList[zoneID][162].nmchildren = { true, 224, 225,	226, 227 } -- Satellite Knuckles
xi.dynamis.mobList[zoneID][163].nmchildren = { true, 228, 229,	230, 231 } -- Satellite Great Axe
xi.dynamis.mobList[zoneID][164].nmchildren = { true, 232, 233,	234, 235 } -- Satellite Horn
xi.dynamis.mobList[zoneID][165].nmchildren = { true, 236, 237,	238, 239 } -- Satellite Longsword
xi.dynamis.mobList[zoneID][166].nmchildren = { true, 240, 241,	242, 243 } -- Satellite Scythe

------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].pos = {xpos, ypos, zpos, rot}

xi.dynamis.mobList[zoneID][1  ].pos = {  424.1293, 0.4751,   -178.5404, 118 } -- (001-D)  Avatar Icon
xi.dynamis.mobList[zoneID][2  ].pos = {  411.1541,-0.2269,   -172.5790, 47  } -- (002-D)  Avatar Icon
xi.dynamis.mobList[zoneID][3  ].pos = {  406.5320, 0.2936,   -187.7396, 232 } -- (003-D)  Avatar Icon
xi.dynamis.mobList[zoneID][4  ].pos = {  419.7373, 0.5091,   -190.8261, 163 } -- (004-D)  Avatar Icon
xi.dynamis.mobList[zoneID][5  ].pos = {  414.4022,-0.3546,   -182.0117, 0   } -- (005-G)  Avatar Icon
xi.dynamis.mobList[zoneID][6  ].pos = {  349.2125, 8.2605,   -192.8115, 160 } -- (006-D)  Manifest Icon
xi.dynamis.mobList[zoneID][7  ].pos = {  346.6184, 8.4416,   -200.3669, 116 } -- (007-D)  Avatar Icon
xi.dynamis.mobList[zoneID][8  ].pos = {  360.3178, 7.9544,   -204.3077, 33  } -- (008-D)  Manifest Icon
xi.dynamis.mobList[zoneID][9  ].pos = {  361.7702, 8.0233,   -195.5119, 247 } -- (009-D)  Avatar Icon
xi.dynamis.mobList[zoneID][10 ].pos = {  354.4850, 8.0746,   -198.8310, 201 } -- (010-O)  Avatar Icon
xi.dynamis.mobList[zoneID][11 ].pos = {  366.3824, 0.5812,   -253.2608, 222 } -- (011-D)  Avatar Icon
xi.dynamis.mobList[zoneID][12 ].pos = {  360.5640, 0.2452,   -248.9267, 219 } -- (012-Q)  Manifest Icon
xi.dynamis.mobList[zoneID][13 ].pos = {  352.6051, 0.0714,   -245.5541, 211 } -- (013-D)  Avatar Icon
xi.dynamis.mobList[zoneID][14 ].pos = {  343.9028, 0.2481,   -289.3212, 210 } -- (014-D)  Avatar Icon
xi.dynamis.mobList[zoneID][15 ].pos = {  338.4755, 0.4983,   -288.4618, 195 } -- (015-D)  Avatar Icon
xi.dynamis.mobList[zoneID][16 ].pos = {  331.9529, 0.2026,   -287.8621, 187 } -- (016-D)  Avatar Icon
xi.dynamis.mobList[zoneID][17 ].pos = {  304.9144, 6.1379,   -249.2820, 58  } -- (017-D)  Manifest Icon
xi.dynamis.mobList[zoneID][18 ].pos = {  311.8788, 7.5565,   -237.4718, 251 } -- (018-D)  Avatar Icon
xi.dynamis.mobList[zoneID][19 ].pos = {  310.6456, 6.1862,   -218.2143, 228 } -- (019-D)  Manifest Icon
xi.dynamis.mobList[zoneID][20 ].pos = {  242.8440, -8.3035,  -236.5309, 19  } -- (020-D)  Avatar Icon
xi.dynamis.mobList[zoneID][21 ].pos = {  247.3115, -10.3789, -225.4024, 10  } -- (021-D)  Avatar Icon
xi.dynamis.mobList[zoneID][22 ].pos = {  251.7796, -11.8153, -214.2299, 15  } -- (022-D)  Avatar Icon
xi.dynamis.mobList[zoneID][23 ].pos = {  264.3314, -6.3296,  -198.5750, 31  } -- (023-D)  Avatar Icon
xi.dynamis.mobList[zoneID][24 ].pos = {  270.2761, -5.7290,  -187.2165, 31  } -- (024-D)  Manifest Icon
xi.dynamis.mobList[zoneID][25 ].pos = {  276.8286, -5.6503,  -177.1220, 21  } -- (025-D)  Manifest Icon
xi.dynamis.mobList[zoneID][26 ].pos = {  381.9445, -4.0833,  -95.9521, 32   } -- (026-D)  Avatar Icon
xi.dynamis.mobList[zoneID][27 ].pos = {  378.4275, -5.7032,  -92.4321, 32   } -- (027-D)  Avatar Icon
xi.dynamis.mobList[zoneID][28 ].pos = {  374.8895, -6.5000,  -88.8913, 32   } -- (028-D)  Avatar Icon
xi.dynamis.mobList[zoneID][29 ].pos = {  297.7394, -5.2740,  -102.6164, 62  } -- (029-D)  Manifest Icon
xi.dynamis.mobList[zoneID][30 ].pos = {  298.0390, -7.7612,  -97.1668, 191  } -- (030-D)  Manifest Icon
xi.dynamis.mobList[zoneID][31 ].pos = {  291.0302, -7.3199,  -97.3795, 62   } -- (031-D)  Avatar Icon
xi.dynamis.mobList[zoneID][32 ].pos = {  290.7523, -8.2855,  -92.5171, 189  } -- (032-D)  Avatar Icon
xi.dynamis.mobList[zoneID][33 ].pos = {  283.7681, -7.4053,  -92.8302, 64   } -- (033-D)  Manifest Icon
xi.dynamis.mobList[zoneID][34 ].pos = {  283.6383, -7.8111,  -87.8017, 190  } -- (034-D)  Avatar Icon
xi.dynamis.mobList[zoneID][35 ].pos = {  232.0036, -19.0781, -165.1964, 150 } -- (035-D)  Manifest Icon
xi.dynamis.mobList[zoneID][36 ].pos = {  229.4250, -20.7388, -168.6801, 149 } -- (036-D)  Avatar Icon
xi.dynamis.mobList[zoneID][37 ].pos = {  232.7480, -20.7388, -170.5852, 159 } -- (037-D)  Avatar Icon
xi.dynamis.mobList[zoneID][38 ].pos = {  234.2837, -20.6722, -166.8051, 155 } -- (038-D)  Avatar Icon
xi.dynamis.mobList[zoneID][39 ].pos = {  234.5874, -19.1802, -161.8466, 147 } -- (039-D)  Avatar Icon
xi.dynamis.mobList[zoneID][40 ].pos = {  235.5074, -20.7388, -157.9036, 150 } -- (040-D)  Manifest Icon
xi.dynamis.mobList[zoneID][41 ].pos = {  238.2971, -20.7388, -159.5938, 141 } -- (041-D)  Avatar Icon
xi.dynamis.mobList[zoneID][42 ].pos = {  236.8613, -20.7052, -162.9283, 155 } -- (042-D)  Manifest Icon
xi.dynamis.mobList[zoneID][43 ].pos = {  235.3885, -20.6618, -164.8875, 149 } -- (043-Y)  Avatar Icon
xi.dynamis.mobList[zoneID][44 ].pos = {  212.2299, -17.2562, -225.9583, 253 } -- (044-D)  Avatar Icon
xi.dynamis.mobList[zoneID][45 ].pos = {  208.1801, -16.7650, -228.9911, 62  } -- (045-D)  Manifest Icon
xi.dynamis.mobList[zoneID][46 ].pos = {  204.6303, -18.8527, -225.5164, 135 } -- (046-D)  Avatar Idol
xi.dynamis.mobList[zoneID][47 ].pos = {  208.4378, -18.8582, -222.6815, 194 } -- (047-D)  Avatar Icon
xi.dynamis.mobList[zoneID][48 ].pos = {  174.3926, -18.8233, -139.4571, 29  } -- (048-D)  Avatar Icon
xi.dynamis.mobList[zoneID][49 ].pos = {  163.9518, -20.3809, -139.4437, 94  } -- (049-D)  Avatar Icon
xi.dynamis.mobList[zoneID][50 ].pos = {  164.5739, -16.9460, -129.4864, 160 } -- (050-D)  Avatar Icon
xi.dynamis.mobList[zoneID][51 ].pos = {  173.8166, -17.7018, -129.4484, 223 } -- (051-D)  Manifest Icon
xi.dynamis.mobList[zoneID][52 ].pos = {  169.2042, -18.2180, -134.7736, 0   } -- (052-Y)  Avatar Icon
xi.dynamis.mobList[zoneID][53 ].pos = {  149.4144, -18.4039, -99.3362, 22   } -- (053-D)  Avatar Icon
xi.dynamis.mobList[zoneID][54 ].pos = {  240.6901, -15.3077, -138.7996, 1   } -- (054-D)  Avatar Icon
xi.dynamis.mobList[zoneID][55 ].pos = {  237.2858, -8.0000, -82.7372, 18    } -- (055-D)  Avatar Icon
xi.dynamis.mobList[zoneID][56 ].pos = {  160.4315, -16.0000, -79.9672, 30   } -- (056-D)  Manifest Icon
xi.dynamis.mobList[zoneID][57 ].pos = {  197.4896, -7.4749, 26.6946, 59     } -- (057-D)  Manifest Icon
xi.dynamis.mobList[zoneID][58 ].pos = {  202.4719, -7.4778, 26.7363, 75     } -- (058-D)  Avatar Icon
xi.dynamis.mobList[zoneID][59 ].pos = {  207.2917, -7.8752, 25.2688, 83     } -- (059-D)  Avatar Icon
xi.dynamis.mobList[zoneID][60 ].pos = {  204.1456, -7.9310, 34.5961, 75     } -- (060-O)  Manifest Icon
xi.dynamis.mobList[zoneID][61 ].pos = {  278.9015, -7.7302, 49.4191, 83     } -- (061-D)  Avatar Icon
xi.dynamis.mobList[zoneID][62 ].pos = {  275.8966, -7.2308, 55.7405, 126    } -- (062-D)  Avatar Icon
xi.dynamis.mobList[zoneID][63 ].pos = {  280.3802, -7.0575, 61.1266, 195    } -- (063-D)  Avatar Icon
xi.dynamis.mobList[zoneID][64 ].pos = {  286.5690, -7.3786, 57.6816, 236    } -- (064-D)  Avatar Icon
xi.dynamis.mobList[zoneID][65 ].pos = {  286.6652, -7.7961, 50.4755, 18     } -- (065-D)  Avatar Icon
xi.dynamis.mobList[zoneID][66 ].pos = {  367.8774, -7.8073, 120.7682, 5     } -- (066-D)  Avatar Icon
xi.dynamis.mobList[zoneID][67 ].pos = {  367.1385, -8.1712, 112.7752, 8     } -- (067-D)  Avatar Icon
xi.dynamis.mobList[zoneID][68 ].pos = {  355.6019, -7.2450, -58.0073, 61    } -- (068-D)  Avatar Icon
xi.dynamis.mobList[zoneID][69 ].pos = {  368.1302, -8.8291, -58.4434, 62    } -- (069-D)  Avatar Icon
xi.dynamis.mobList[zoneID][70 ].pos = {  380.6304, -3.1784, -58.9766, 64    } -- (070-D)  Avatar Icon
xi.dynamis.mobList[zoneID][71 ].pos = {  392.9741, -0.7745, -61.0018, 64    } -- (071-D)  Avatar Icon
xi.dynamis.mobList[zoneID][72 ].pos = {  405.4319, 0.4546, -62.2839, 68     } -- (072-D)  Manifest Icon
xi.dynamis.mobList[zoneID][73 ].pos = {  384.3539, -3.1706, -44.0433, 77    } -- (073-Y)  Avatar Icon
xi.dynamis.mobList[zoneID][74 ].pos = {  398.0475, -5.6198, -15.0955, 63    } -- (074-D)  Manifest Icon
xi.dynamis.mobList[zoneID][75 ].pos = {  390.0092, -7.7016, 0.9627, 157     } -- (075-D)  Avatar Icon
xi.dynamis.mobList[zoneID][76 ].pos = {  404.8032, -7.8646, 1.9129, 223     } -- (076-D)  Avatar Icon
xi.dynamis.mobList[zoneID][77 ].pos = {  397.8393, -7.8562, -5.2043, 63     } -- (077-O)  Manifest Icon
xi.dynamis.mobList[zoneID][78 ].pos = {  433.9671, -1.6716, 52.7199, 95     } -- (078-D)  Avatar Icon
xi.dynamis.mobList[zoneID][79 ].pos = {  433.7292, -5.0768, 62.3223, 156    } -- (079-D)  Avatar Icon
xi.dynamis.mobList[zoneID][80 ].pos = {  443.8177, -5.6656, 62.6060, 222    } -- (080-D)  Manifest Icon
xi.dynamis.mobList[zoneID][81 ].pos = {  444.6903, -2.6507, 53.6754, 30     } -- (081-D)  Avatar Icon
xi.dynamis.mobList[zoneID][82 ].pos = {  438.9351, -3.8096, 57.6335, 61     } -- (082-D)  Avatar Icon
xi.dynamis.mobList[zoneID][83 ].pos = {  488.6499, -0.3915, 37.6619, 175    } -- (083-D)  Manifest Icon
xi.dynamis.mobList[zoneID][84 ].pos = {  482.3507, -0.1661, 32.7014, 162    } -- (084-D)  Avatar Idol
xi.dynamis.mobList[zoneID][85 ].pos = {  489.0281, -0.2256, 29.6058, 156    } -- (085-D)  Avatar Icon
xi.dynamis.mobList[zoneID][86 ].pos = {  501.9442, -7.8484, 198.5639, 68    } -- (086-D)  Manifest Icon
xi.dynamis.mobList[zoneID][87 ].pos = {  504.2140, -8.1312, 207.0567, 70    } -- (087-D)  Avatar Icon
xi.dynamis.mobList[zoneID][88 ].pos = {  534.2434, -7.8169, 221.5235, 119   } -- (088-D)  Manifest Icon
xi.dynamis.mobList[zoneID][89 ].pos = {  60.5113, -24.0736, -267.0519, 182  } -- (089-D)  Avatar Icon
xi.dynamis.mobList[zoneID][90 ].pos = {  60.1930, -23.8032, -274.8913, 71   } -- (090-D)  Avatar Icon
xi.dynamis.mobList[zoneID][91 ].pos = {  91.3642, -24.0450, -251.7222, 158  } -- (091-D)  Avatar Icon
xi.dynamis.mobList[zoneID][92 ].pos = {  97.5249, -23.9710, -264.3413, 48   } -- (092-D)  Avatar Icon
xi.dynamis.mobList[zoneID][93 ].pos = {  6.8732, -23.8575, -362.9837, 195   } -- (093-D)  Avatar Idol
xi.dynamis.mobList[zoneID][94 ].pos = {  16.8527, -23.1585, -363.1671, 196  } -- (094-D)  Manifest Icon
xi.dynamis.mobList[zoneID][95 ].pos = {  26.8581, -23.4904, -362.9120, 191  } -- (095-D)  Manifest Icon
xi.dynamis.mobList[zoneID][96 ].pos = {  36.8740, -24.0000, -362.7977, 191  } -- (096-D)  Manifest Icon
xi.dynamis.mobList[zoneID][97 ].pos = { -28.5253, -15.6275, 42.0637, 0      } -- (097-D)  Avatar Icon
xi.dynamis.mobList[zoneID][98 ].pos = { -27.8314, -15.8221, 33.8259, 0      } -- (098-D)  Avatar Icon
xi.dynamis.mobList[zoneID][99 ].pos = { 49.7393, -15.7784, 15.4163, 36      } -- (099-D)  Avatar Icon
xi.dynamis.mobList[zoneID][100].pos = { 43.6486, -15.6278, 11.4668, 48      } -- (100-D)  Manifest Icon
xi.dynamis.mobList[zoneID][101].pos = { 36.3999, -15.7803, 8.4163, 43       } -- (101-D)  Avatar Icon
xi.dynamis.mobList[zoneID][102].pos = { 65.5793, -17.6682, -47.7914, 14     } -- (102-D)  Avatar Icon
xi.dynamis.mobList[zoneID][103].pos = { 67.9447, -18.0770, -40.1728, 255    } -- (103-D)  Avatar Icon
xi.dynamis.mobList[zoneID][104].pos = { 64.0896, -24.0238, -74.4542, 58     } -- (104-D)  Avatar Icon
xi.dynamis.mobList[zoneID][105].pos = { 80.9163, -23.7844, -74.2179, 65     } -- (105-D)  Avatar Icon
xi.dynamis.mobList[zoneID][106].pos = {  23.2533, -33.0965, 139.2529, 67    } -- (106-D)  Avatar Icon
xi.dynamis.mobList[zoneID][107].pos = {  23.0874, -34.1983, 144.2162, 0     } -- (107-D)  Avatar Icon
xi.dynamis.mobList[zoneID][108].pos = {  23.0806, -34.8438, 149.1463, 125   } -- (108-D)  Avatar Icon
xi.dynamis.mobList[zoneID][109].pos = {  22.5083, -35.0776, 154.2627, 181   } -- (109-D)  Avatar Icon
xi.dynamis.mobList[zoneID][110].pos = {-117.4516, -36.0000, 80.3362, 73     } -- (110-D)  Manifest Icon
xi.dynamis.mobList[zoneID][111].pos = {-111.8803, -36.2595, 80.4930, 63     } -- (111-D)  Manifest Icon
xi.dynamis.mobList[zoneID][112].pos = {-107.7923, -39.8030, 35.8958, 159    } -- (112-Q)  Avatar Icon
xi.dynamis.mobList[zoneID][113].pos = {-136.6303, -28.1860, 85.6807, 61     } -- (113-D)  Avatar Icon
xi.dynamis.mobList[zoneID][114].pos = {-138.6653, -20.2562, 115.8844, 54    } -- (114-D)  Avatar Icon
xi.dynamis.mobList[zoneID][115].pos = { 44.6229, -35.7960, 110.5585, 191    } -- (115-D)  Avatar Icon
xi.dynamis.mobList[zoneID][116].pos = { 38.1159, -35.7175, 110.3267, 199    } -- (116-D)  Manifest Idol
xi.dynamis.mobList[zoneID][117].pos = { 219.4501, -23.0169, 133.2112, 63    } -- (117-D)  Manifest Icon
xi.dynamis.mobList[zoneID][118].pos = { 215.0627, -24.7103, 137.4886, 65    } -- (118-D)  Manifest Icon
xi.dynamis.mobList[zoneID][119].pos = { 219.4539, -25.7846, 142.8087, 62    } -- (119-D)  Avatar Icon
xi.dynamis.mobList[zoneID][120].pos = { 223.0426, -24.8310, 137.9934, 63    } -- (120-D)  Avatar Icon
xi.dynamis.mobList[zoneID][121].pos = { 173.1911, -33.3553, 68.7402, 131    } -- (121-D)  BOSS
xi.dynamis.mobList[zoneID][122].pos = { 190.3257, -28.9476, 88.3894, 187    } -- (122-D)  Avatar Icon
xi.dynamis.mobList[zoneID][123].pos = { 240.7466, -27.3345, 94.7047, 190    } -- (123-D)  Avatar Icon
xi.dynamis.mobList[zoneID][124].pos = { 246.9428, -27.4052, 95.9730, 190    } -- (124-D)  Avatar Icon
xi.dynamis.mobList[zoneID][125].pos = { 300.8132, -27.8000, 220.3610, 63    } -- (125-D)  Avatar Icon
xi.dynamis.mobList[zoneID][126].pos = { 298.7344, -28.0975, 229.8743, 63    } -- (126-D)  Manifest Icon
xi.dynamis.mobList[zoneID][127].pos = { 150.5660, -21.0480, -36.7252, 94    } -- (127-D)  Manifest Icon
xi.dynamis.mobList[zoneID][128].pos = { 155.2857, -21.0238, -40.4494, 92    } -- (128-D)  Avatar Icon
xi.dynamis.mobList[zoneID][129].pos = { 159.5335, -21.0480, -44.6545, 94    } -- (129-D)  Avatar Icon
xi.dynamis.mobList[zoneID][130].pos = { 119.6976, -28.7700, -112.1791, 127  } -- (130-D)  Avatar Icon
xi.dynamis.mobList[zoneID][131].pos = { 119.6369, -28.7261, -118.1067, 129  } -- (131-D)  Manifest Icon
xi.dynamis.mobList[zoneID][132].pos = { 119.5703, -28.7700, -124.0673, 128  } -- (132-D)  Avatar Icon
xi.dynamis.mobList[zoneID][133].pos = {  66.0471, -28.5111, -200.4550, 97   } -- (133-D)  Manifest Icon
xi.dynamis.mobList[zoneID][134].pos = {  61.7481, -28.4765, -196.2649, 95   } -- (134-D)  Avatar Icon
xi.dynamis.mobList[zoneID][135].pos = {  57.0693, -28.5111, -192.5350, 95   } -- (135-D)  Avatar Icon
xi.dynamis.mobList[zoneID][136].pos = {  39.2806, -28.7143, -139.9675, 125  } -- (136-D)  Manifest Icon
xi.dynamis.mobList[zoneID][137].pos = {  39.5865, -28.6676, -134.0237, 127  } -- (137-D)  Manifest Icon
xi.dynamis.mobList[zoneID][138].pos = {  39.5281, -28.7143, -128.0194, 126  } -- (138-D)  Manifest Icon
xi.dynamis.mobList[zoneID][139].pos = {  -7.1555, -28.5546, -106.6829, 144  } -- (139-D)  Manifest Icon
xi.dynamis.mobList[zoneID][140].pos = {  -4.9817, -28.4989, -101.1111, 139  } -- (140-D)  Avatar Icon
xi.dynamis.mobList[zoneID][141].pos = {  -2.8697, -28.5546, -95.5164, 146   } -- (141-D)  Avatar Icon
xi.dynamis.mobList[zoneID][142].pos = { -45.5989, -24.2095, -125.2383, 230  } -- (142-Q)  Avatar Icon
xi.dynamis.mobList[zoneID][143].pos = { -86.0996, -24.2289, -85.1929, 232   } -- (143-G)  Avatar Icon
xi.dynamis.mobList[zoneID][144].pos = {-129.0694, -23.7477, -43.8721, 6     } -- (144-D)  Avatar Icon
xi.dynamis.mobList[zoneID][145].pos = {-128.6296, -23.2130, -33.8281, 9     } -- (145-D)  Avatar Icon
xi.dynamis.mobList[zoneID][146].pos = {-127.8140, -22.4947, -23.8494, 6     } -- (146-D)  Avatar Icon
xi.dynamis.mobList[zoneID][147].pos = {-127.0488, -18.8946, -13.8742, 6     } -- (147-D)  Avatar Icon
xi.dynamis.mobList[zoneID][148].pos = {-125.7572, -15.9298, -4.0155, 9      } -- (148-D)  Avatar Icon
xi.dynamis.mobList[zoneID][149].pos = {-124.7990, -16.0928, 5.8331, 27      } -- (149-D)  Avatar Icon
xi.dynamis.mobList[zoneID][150].pos = {-150.0562, -16.1019, -6.8322, 23     } -- (150-G)  Avatar Icon
-- Animated Weapons, Dragons
xi.dynamis.mobList[zoneID][178].pos = { -365.6851, -36.0043, 15.7061, 253   } -- ying
xi.dynamis.mobList[zoneID][177].pos = { -366.2450, -36.3298, 24.8477, 255   } -- yang
xi.dynamis.mobList[zoneID][151].pos = { 338.2422, 0.0671, -377.4373, 192    } -- Animated hammer
xi.dynamis.mobList[zoneID][152].pos = { 146.8420, -25.2636, -226.5739, 3    } -- Animated dagger
xi.dynamis.mobList[zoneID][153].pos = { 90.9604, -24.0000, -375.0468, 218   } -- Animated shield
xi.dynamis.mobList[zoneID][154].pos = { -22.1978, -24.5956, -493.4288, 199  } -- Animated claymore
xi.dynamis.mobList[zoneID][155].pos = {-255.5342, -17.6566, -161.5427, 192  } -- Animated gun
xi.dynamis.mobList[zoneID][156].pos = {-296.0583, -25.8233, 161.7301, 68    } -- Animated longbow
xi.dynamis.mobList[zoneID][157].pos = { -100.4566, -15.8000, 138.8280, 128  } -- Animated tachi
xi.dynamis.mobList[zoneID][158].pos = { -122.0494, -36.0412, 124.8039, 58   } -- Animated tabar
xi.dynamis.mobList[zoneID][159].pos = { 49.1101, -36.2815, 61.7415, 183     } -- Animated staff
xi.dynamis.mobList[zoneID][160].pos = { 152.0960, -35.9728, 19.3087, 224    } -- Animated spear
xi.dynamis.mobList[zoneID][161].pos = { 241.9540, -28.4264, 63.3540, 199    } -- Animated kunai
xi.dynamis.mobList[zoneID][162].pos = { 342.1594, -27.8198, 378.1761, 68    } -- Animated knuckles
xi.dynamis.mobList[zoneID][163].pos = { 320.5472, -8.3209, 168.3653, 72     } -- Animated great axe
xi.dynamis.mobList[zoneID][164].pos = { 386.6498, -9.5122, 25.9243, 21      } -- Animated horn
xi.dynamis.mobList[zoneID][165].pos = { 582.5316, -8.0575, 296.7370, 73     } -- Animated longsword
xi.dynamis.mobList[zoneID][166].pos = { 577.9836, 0.1949, -18.2714, 195     } -- Animated scythe
xi.dynamis.mobList[zoneID][167].pos = {-213.8854, -6.7935, 42.7936, 1       } -- Vanguard Dragon
xi.dynamis.mobList[zoneID][168].pos = {-237.1062, -11.4733, 66.6790, 228    } -- Vanguard Dragon
xi.dynamis.mobList[zoneID][169].pos = {-247.0509, -11.9911, -11.5988, 253   } -- Vanguard Dragon
xi.dynamis.mobList[zoneID][170].pos = {-235.2860, -11.7157, -87.2030, 0     } -- Vanguard Dragon
xi.dynamis.mobList[zoneID][171].pos = {-276.5036, -20.0000, -81.0512, 255   } -- Vanguard Dragon
xi.dynamis.mobList[zoneID][172].pos = {-268.2993, -18.4545, 33.5037, 45     } -- Vanguard Dragon
xi.dynamis.mobList[zoneID][173].pos = {-284.7049, -20.2053, 121.2283, 59    } -- Vanguard Dragon
xi.dynamis.mobList[zoneID][174].pos = {-317.0527, -27.8170, 72.3022, 21     } -- Vanguard Dragon
xi.dynamis.mobList[zoneID][175].pos = {-297.9739, -23.4600, -2.6931, 226    } -- Vanguard Dragon
xi.dynamis.mobList[zoneID][176].pos = {-308.7357, -26.5187, -37.8035, 226   } -- Vanguard Dragon
xi.dynamis.mobList[zoneID][179].pos = {-414.2820, -44.0000, 20.4270, 0      } -- Dynamis Lord

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

xi.dynamis.mobList[zoneID][52 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][73 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][77 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][112].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][142].eyes = xi.dynamis.eye.BLUE

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].timeExtension = 15

xi.dynamis.mobList[zoneID].timeExtensionList = {10, 43, 60, 143, 150}
xi.dynamis.mobList[zoneID][10 ].timeExtension = 30 -- Tombstone Prototype
xi.dynamis.mobList[zoneID][43 ].timeExtension = 30 -- Icon Prototype
xi.dynamis.mobList[zoneID][60 ].timeExtension = 30 -- Tombstone Prototype
xi.dynamis.mobList[zoneID][143].timeExtension = 30 -- Statue Prototype
xi.dynamis.mobList[zoneID][150].timeExtension = 30 -- Statue Prototype
