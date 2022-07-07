----------------------------------------------------------------------------------------------------
--                                      Dynamis-Bastok                                            --
--              Primary Source of Information: https://enedin.be/dyna/html/zone/bas.htm           --
--           Secondary Source of Information: http://www.dynamisbums.com/strategy/bas.html        --
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
--    The wave spawning requirements are handled through localvar set on the one based on the onMobDeath() function of the NM/statue.
--    xi.dynamis.mobList[zoneID].waveDefeatRequirements =
--    {
--        {}, -- Do not touch this is WAVE 1
--        {"X_killed", "Y_killed", "Z_killed"}, -- THIS IS WAVE 2
--        {"MegaBoss_Killed"} -- THIS IS WAVE 3
--    }
--
-- 4. Setup mob positions for spawns. This is only required for statues and mobs that do not spawn
--    from a statue, NM, or nightmare mob. In some cases specific mobs from statue can be placed with a position for specific spawn spots.
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
local zoneID = xi.zone.DYNAMIS_BASTOK
local i = 1
xi = xi or {} -- Ignore me I just set the global.
xi.dynamis = xi.dynamis or {} -- Ignore me I just set the global.
xi.dynamis.mobList = xi.dynamis.mobList or { } -- Ignore me I just set the global.
xi.dynamis.mobList[zoneID] = { } -- Ignore me, I just start the table.
xi.dynamis.mobList[zoneID].nmchildren = { }
xi.dynamis.mobList[zoneID].mobchildren = { }
xi.dynamis.mobList[zoneID].maxWaves = 3 -- Put in number of max waves

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

xi.dynamis.mobList[zoneID][1  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (001-Q)
xi.dynamis.mobList[zoneID][2  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (002-Q)
xi.dynamis.mobList[zoneID][3  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (003-Q)
xi.dynamis.mobList[zoneID][4  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (004-Q)
xi.dynamis.mobList[zoneID][5  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (005-Q)
xi.dynamis.mobList[zoneID][6  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (006-Q)
xi.dynamis.mobList[zoneID][7  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (007-Q)
xi.dynamis.mobList[zoneID][8  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (008-Q)
xi.dynamis.mobList[zoneID][9  ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (009-Q)
xi.dynamis.mobList[zoneID][10 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (010-Q)
xi.dynamis.mobList[zoneID][11 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (011-Q)
xi.dynamis.mobList[zoneID][12 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (012-Q)
xi.dynamis.mobList[zoneID][13 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (013-Q)
xi.dynamis.mobList[zoneID][14 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (014-Q)
xi.dynamis.mobList[zoneID][15 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (015-Q)
xi.dynamis.mobList[zoneID][16 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (016-Q)
xi.dynamis.mobList[zoneID][17 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (017-Q)
xi.dynamis.mobList[zoneID][18 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (018-Q)
xi.dynamis.mobList[zoneID][19 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (019-Q)
xi.dynamis.mobList[zoneID][20 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (020-Q)
xi.dynamis.mobList[zoneID][21 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (021-Q)
xi.dynamis.mobList[zoneID][22 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (022-Q)
xi.dynamis.mobList[zoneID][23 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (023-Q)
xi.dynamis.mobList[zoneID][24 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (024-Q)
xi.dynamis.mobList[zoneID][25 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (025-Q)
xi.dynamis.mobList[zoneID][26 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (026-Q)
xi.dynamis.mobList[zoneID][27 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (027-Q)
xi.dynamis.mobList[zoneID][28 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (028-Q)
xi.dynamis.mobList[zoneID][29 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (029-Q)
xi.dynamis.mobList[zoneID][30 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (030-Q)
xi.dynamis.mobList[zoneID][31 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (031-Q)
xi.dynamis.mobList[zoneID][32 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (032-Q)
xi.dynamis.mobList[zoneID][33 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (033-Q)
xi.dynamis.mobList[zoneID][34 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (034-Q)
xi.dynamis.mobList[zoneID][35 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (035-Q)
xi.dynamis.mobList[zoneID][36 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (036-Q)
xi.dynamis.mobList[zoneID][37 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (037-Q)
xi.dynamis.mobList[zoneID][38 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (038-Q)
xi.dynamis.mobList[zoneID][39 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (039-Q)
xi.dynamis.mobList[zoneID][40 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (040-Q)
xi.dynamis.mobList[zoneID][41 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (041-Q)
xi.dynamis.mobList[zoneID][42 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (042-Q)
xi.dynamis.mobList[zoneID][43 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (043-Q)
xi.dynamis.mobList[zoneID][44 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (044-Q)
xi.dynamis.mobList[zoneID][45 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (045-Q)
xi.dynamis.mobList[zoneID][46 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (046-Q)
xi.dynamis.mobList[zoneID][47 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (047-Q)
xi.dynamis.mobList[zoneID][48 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (048-Q)
xi.dynamis.mobList[zoneID][49 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (049-Q)
xi.dynamis.mobList[zoneID][50 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (050-Q)
xi.dynamis.mobList[zoneID][51 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (051-Q)
xi.dynamis.mobList[zoneID][52 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (052-Q)
xi.dynamis.mobList[zoneID][53 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (053-Q)
xi.dynamis.mobList[zoneID][54 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (054-Q)
xi.dynamis.mobList[zoneID][55 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (055-Q)
xi.dynamis.mobList[zoneID][56 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (056-Q)
xi.dynamis.mobList[zoneID][57 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (057-Q)
xi.dynamis.mobList[zoneID][58 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (058-Q)
xi.dynamis.mobList[zoneID][59 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (059-Q)
xi.dynamis.mobList[zoneID][60 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (060-Q)
xi.dynamis.mobList[zoneID][61 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (061-Q)
xi.dynamis.mobList[zoneID][62 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (062-Q)
xi.dynamis.mobList[zoneID][63 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (063-Q)
xi.dynamis.mobList[zoneID][64 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (064-Q)
xi.dynamis.mobList[zoneID][65 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (065-Q)
xi.dynamis.mobList[zoneID][66 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (066-Q)
xi.dynamis.mobList[zoneID][67 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (067-Q)
xi.dynamis.mobList[zoneID][68 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (068-Q)
xi.dynamis.mobList[zoneID][69 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (069-Q)
xi.dynamis.mobList[zoneID][70 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (070-Q)
xi.dynamis.mobList[zoneID][71 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (071-Q)
xi.dynamis.mobList[zoneID][72 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (072-Q)
xi.dynamis.mobList[zoneID][73 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (073-Q)
xi.dynamis.mobList[zoneID][74 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (074-Q)
xi.dynamis.mobList[zoneID][75 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (075-Q)
xi.dynamis.mobList[zoneID][76 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (076-Q)
xi.dynamis.mobList[zoneID][77 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (077-Q)
xi.dynamis.mobList[zoneID][78 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (078-Q)
xi.dynamis.mobList[zoneID][79 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (079-Q)
xi.dynamis.mobList[zoneID][80 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (080-Q)(MP)
xi.dynamis.mobList[zoneID][81 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (081-Q)
xi.dynamis.mobList[zoneID][82 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (082-Q)(HP)
xi.dynamis.mobList[zoneID][83 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (083-Q)
xi.dynamis.mobList[zoneID][84 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (084-Q)
xi.dynamis.mobList[zoneID][85 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (085-Q)(HP)
xi.dynamis.mobList[zoneID][86 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (086-Q)
xi.dynamis.mobList[zoneID][87 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (087-Q)
xi.dynamis.mobList[zoneID][88 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (088-Q)
xi.dynamis.mobList[zoneID][89 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (089-Q)
xi.dynamis.mobList[zoneID][90 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (090-Q)
xi.dynamis.mobList[zoneID][91 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (091-Q)
xi.dynamis.mobList[zoneID][92 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (092-Q)(HP)
xi.dynamis.mobList[zoneID][93 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (093-Q)
xi.dynamis.mobList[zoneID][94 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (094-Q)(HP)
xi.dynamis.mobList[zoneID][95 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (095-Q)
xi.dynamis.mobList[zoneID][96 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (096-Q)
xi.dynamis.mobList[zoneID][97 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (097-Q)
xi.dynamis.mobList[zoneID][98 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (098-Q)
xi.dynamis.mobList[zoneID][99 ].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (099-Q)
xi.dynamis.mobList[zoneID][100].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (100-Q)
xi.dynamis.mobList[zoneID][101].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (101-Q)
xi.dynamis.mobList[zoneID][102].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (102-Q)
xi.dynamis.mobList[zoneID][103].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (103-Q)
xi.dynamis.mobList[zoneID][104].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (104-Q)
xi.dynamis.mobList[zoneID][105].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (105-Q)
xi.dynamis.mobList[zoneID][106].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (106-Q)
xi.dynamis.mobList[zoneID][107].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (107-Q)
xi.dynamis.mobList[zoneID][108].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (108-Q)
xi.dynamis.mobList[zoneID][109].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (109-Q)
xi.dynamis.mobList[zoneID][111].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (111-Q)
xi.dynamis.mobList[zoneID][112].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (112-Q)(HP)
xi.dynamis.mobList[zoneID][113].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (113-Q)
xi.dynamis.mobList[zoneID][114].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (114-Q)(MP)
xi.dynamis.mobList[zoneID][115].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (115-Q)
xi.dynamis.mobList[zoneID][116].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (116-Q)(HP)
xi.dynamis.mobList[zoneID][117].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (117-Q)
xi.dynamis.mobList[zoneID][118].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (118-Q)
xi.dynamis.mobList[zoneID][119].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (119-Q)(HP)
xi.dynamis.mobList[zoneID][120].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (120-Q)(HP)
xi.dynamis.mobList[zoneID][121].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (121-Q)(MP)
xi.dynamis.mobList[zoneID][122].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (122-Q)(HP)
xi.dynamis.mobList[zoneID][123].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (123-Q)
xi.dynamis.mobList[zoneID][124].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (124-Q)(HP)
xi.dynamis.mobList[zoneID][125].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (125-Q)(MP)
xi.dynamis.mobList[zoneID][126].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (126-Q)
xi.dynamis.mobList[zoneID][127].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (127-Q)(MP)
xi.dynamis.mobList[zoneID][128].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (128-Q)
xi.dynamis.mobList[zoneID][129].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (129-Q)(MP)
xi.dynamis.mobList[zoneID][130].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (130-Q)
xi.dynamis.mobList[zoneID][131].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (131-Q)
xi.dynamis.mobList[zoneID][132].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (132-Q)(HP)
xi.dynamis.mobList[zoneID][133].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (133-Q)(HP)
xi.dynamis.mobList[zoneID][134].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (134-Q)
xi.dynamis.mobList[zoneID][135].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (135-Q)
xi.dynamis.mobList[zoneID][136].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (136-Q)(MP)
xi.dynamis.mobList[zoneID][137].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (137-Q)(MP)
xi.dynamis.mobList[zoneID][138].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (138-Q)(HP)
xi.dynamis.mobList[zoneID][139].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (139-Q)(HP)
xi.dynamis.mobList[zoneID][140].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (140-Q)
xi.dynamis.mobList[zoneID][141].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (141-Q)
xi.dynamis.mobList[zoneID][142].info = {"Statue", "Adamantking Effigy", nil, nil, nil} -- (142-Q)

-- NM's and Megaboss Quadav
xi.dynamis.mobList[zoneID][110].info = {"NM", "Gu'Dha Effigy", nil, nil, "MegaBoss_Killed"} -- ( 110 ) Replica NM (Gu'Dha Effigy)(30)

xi.dynamis.mobList[zoneID][143].info = {"NM", "Aa'Nyu Dismantler",     "Quadav", "DRK", nil} -- Aa'Nyu Dismantler
xi.dynamis.mobList[zoneID][144].info = {"NM", "Be'Ebo Tortoisedriver", "Quadav", "BST", nil} -- Be'Ebo Tortoisedriver
xi.dynamis.mobList[zoneID][145].info = {"NM", "Gi'Pha Manameister",    "Quadav", "BLM", "GiPha_killed"} -- Gi'Pha Manameister
xi.dynamis.mobList[zoneID][146].info = {"NM", "Gu'Nhi Noondozer",      "Quadav", "SMN", nil} -- Gu'Nhi Noondozer
xi.dynamis.mobList[zoneID][147].info = {"NM", "Ze'Vho Fallsplitter",   "Quadav", "DRK", "ZeVho_killed"} -- Ze'Vho Fallsplitter
xi.dynamis.mobList[zoneID][148].info = {"NM", "Ko'Dho Cannonball",     "Quadav", "MNK", "KoDho_killed"} -- Ko'Dho Cannonball

xi.dynamis.mobList[zoneID][149].info = {"NM", "Effigy Shield", "Quadav", "PLD", nil } -- Effigy Shield
xi.dynamis.mobList[zoneID][150].info = {"NM", "Effigy Shield", "Quadav", "NIN", nil } -- Effigy Shield
xi.dynamis.mobList[zoneID][151].info = {"NM", "Effigy Shield", "Quadav", "BRD", nil } -- Effigy Shield
xi.dynamis.mobList[zoneID][152].info = {"NM", "Effigy Shield", "Quadav", "DRK", nil } -- Effigy Shield
xi.dynamis.mobList[zoneID][153].info = {"NM", "Effigy Shield", "Quadav", "SAM", nil } -- Effigy Shield

xi.dynamis.mobList[zoneID][154].info = {"TE normal", "Vanguard Vindicator", "Quadav", "WAR", nil } -- 10min TE
xi.dynamis.mobList[zoneID][155].info = {"TE normal", "Vanguard Constable",  "Quadav", "WHM", nil } -- 10min TE
xi.dynamis.mobList[zoneID][156].info = {"TE normal", "Vanguard Militant",   "Quadav", "MNK", nil } -- 10min TE


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
    {"KoDho_killed", "GiPha_killed", "ZeVho_killed"}, -- 3 NMs to spawn Boss
    {"MegaBoss_Killed"} -- Spawns wave after boss dies
}

------------------------------------------
--            Wave Spawning             --
-- Note: Wave 1 spawns at start.        --
------------------------------------------
--xi.dynamis.mobList[zoneID].wave# = { MobIndex#1, MobIndex#2, MobIndex#3 }

xi.dynamis.mobList[zoneID][1].wave =
{
    1  , -- (001-Q) Adamantking Effigy
    2  , -- (002-Q) Adamantking Effigy
    3  , -- (003-Q) Adamantking Effigy
    4  , -- (004-Q) Adamantking Effigy
    5  , -- (005-Q) Adamantking Effigy
    6  , -- (006-Q) Adamantking Effigy
    7  , -- (007-Q) Adamantking Effigy
    8  , -- (008-Q) Adamantking Effigy
    9  , -- (009-Q) Adamantking Effigy
    10 , -- (010-Q) Adamantking Effigy
    11 , -- (011-Q) Adamantking Effigy
    12 , -- (012-Q) Adamantking Effigy
    13 , -- (013-Q) Adamantking Effigy
    14 , -- (014-Q) Adamantking Effigy
    15 , -- (015-Q) Adamantking Effigy
    16 , -- (016-Q) Adamantking Effigy
    17 , -- (017-Q) Adamantking Effigy
    18 , -- (018-Q) Adamantking Effigy
    19 , -- (019-Q) Adamantking Effigy
    20 , -- (020-Q) Adamantking Effigy
    21 , -- (021-Q) Adamantking Effigy
    22 , -- (022-Q) Adamantking Effigy
    23 , -- (023-Q) Adamantking Effigy
    24 , -- (024-Q) Adamantking Effigy
    25 , -- (025-Q) Adamantking Effigy
    27 , -- (027-Q) Adamantking Effigy
    28 , -- (028-Q) Adamantking Effigy
    32 , -- (032-Q) Adamantking Effigy
    33 , -- (033-Q) Adamantking Effigy
    34 , -- (034-Q) Adamantking Effigy
    35 , -- (035-Q) Adamantking Effigy
    36 , -- (036-Q) Adamantking Effigy
    37 , -- (037-Q) Adamantking Effigy
    38 , -- (038-Q) Adamantking Effigy
    39 , -- (039-Q) Adamantking Effigy
    40 , -- (040-Q) Adamantking Effigy
    41 , -- (041-Q) Adamantking Effigy
    42 , -- (042-Q) Adamantking Effigy
    43 , -- (043-Q) Adamantking Effigy
    44 , -- (044-Q) Adamantking Effigy
    45 , -- (045-Q) Adamantking Effigy
    46 , -- (046-Q) Adamantking Effigy
    47 , -- (047-Q) Adamantking Effigy
    48 , -- (048-Q) Adamantking Effigy
    49 , -- (049-Q) Adamantking Effigy
    50 , -- (050-Q) Adamantking Effigy
    51 , -- (051-Q) Adamantking Effigy
    52 , -- (052-Q) Adamantking Effigy
    53 , -- (053-Q) Adamantking Effigy
    55 , -- (055-Q) Adamantking Effigy
    56 , -- (056-Q) Adamantking Effigy
    57 , -- (057-Q) Adamantking Effigy
    58 , -- (058-Q) Adamantking Effigy
    59 , -- (059-Q) Adamantking Effigy
    60 , -- (060-Q) Adamantking Effigy
    61 , -- (061-Q) Adamantking Effigy
    62 , -- (062-Q) Adamantking Effigy
    63 , -- (063-Q) Adamantking Effigy
    64 , -- (064-Q) Adamantking Effigy
    65 , -- (065-Q) Adamantking Effigy
    66 , -- (066-Q) Adamantking Effigy
    67 , -- (067-Q) Adamantking Effigy
    68 , -- (068-Q) Adamantking Effigy
    69 , -- (069-Q) Adamantking Effigy
    70 , -- (070-Q) Adamantking Effigy
    71 , -- (071-Q) Adamantking Effigy
    72 , -- (072-Q) Adamantking Effigy
    73 , -- (073-Q) Adamantking Effigy
    74 , -- (074-Q) Adamantking Effigy
    75 , -- (075-Q) Adamantking Effigy
    76 , -- (076-Q) Adamantking Effigy
    77 , -- (077-Q) Adamantking Effigy
    78 , -- (078-Q) Adamantking Effigy
    79 , -- (079-Q) Adamantking Effigy
    80 , -- (080-Q) Adamantking Effigy
    81 , -- (081-Q) Adamantking Effigy
    82 , -- (082-Q) Adamantking Effigy
    83 , -- (083-Q) Adamantking Effigy
    84 , -- (084-Q) Adamantking Effigy
    85 , -- (085-Q) Adamantking Effigy
    86 , -- (086-Q) Adamantking Effigy
    87 , -- (087-Q) Adamantking Effigy
    88 , -- (088-Q) Adamantking Effigy
    90 , -- (090-Q) Adamantking Effigy
    91 , -- (091-Q) Adamantking Effigy
    93 , -- (093-Q) Adamantking Effigy
    94 , -- (094-Q) Adamantking Effigy
    95 , -- (095-Q) Adamantking Effigy
    96 , -- (096-Q) Adamantking Effigy
    97 , -- (097-Q) Adamantking Effigy
    98 , -- (098-Q) Adamantking Effigy
    99 , -- (099-Q) Adamantking Effigy
    100, -- (100-Q) Adamantking Effigy
    101, -- (101-Q) Adamantking Effigy
    102, -- (102-Q) Adamantking Effigy
    103, -- (103-Q) Adamantking Effigy
    104, -- (104-Q) Adamantking Effigy
    105, -- (105-Q) Adamantking Effigy
    106, -- (106-Q) Adamantking Effigy
    107, -- (107-Q) Adamantking Effigy
    108, -- (108-Q) Adamantking Effigy
    109  -- (109-Q) Adamantking Effigy
}

xi.dynamis.mobList[zoneID][2].wave =
{
    110  -- (110-Q) Gu'Dha Effigy
}

xi.dynamis.mobList[zoneID][3].wave =
{
    112, -- (112-Q) Adamantking Effigy
    113, -- ( 113 ) Adamantking Effigy
    114, -- (114-Q) Adamantking Effigy
    115, -- (115-Q) Adamantking Effigy
    116, -- (116-Q) Adamantking Effigy
    117, -- (117-Q) Adamantking Effigy
    118, -- (118-Q) Adamantking Effigy
    119, -- (119-Q) Adamantking Effigy
    120, -- (120-Q) Adamantking Effigy
    121, -- (121-Q) Adamantking Effigy
    122, -- (122-Q) Adamantking Effigy
    123, -- (123-Q) Adamantking Effigy
    124, -- (124-Q) Adamantking Effigy
    125, -- (125-Q) Adamantking Effigy
    126, -- (126-Q) Adamantking Effigy
    127, -- (127-Q) Adamantking Effigy
    128, -- (128-Q) Adamantking Effigy
    129, -- (129-Q) Adamantking Effigy
    130, -- (130-Q) Adamantking Effigy
    131, -- (131-Q) Adamantking Effigy
    132, -- (132-Q) Adamantking Effigy
    133, -- (133-Q) Adamantking Effigy
    134, -- (134-Q) Adamantking Effigy
    135, -- (135-Q) Adamantking Effigy
    136, -- (136-Q) Adamantking Effigy
    137, -- (137-Q) Adamantking Effigy
    138, -- (138-Q) Adamantking Effigy
    139, -- (139-Q) Adamantking Effigy
    140, -- (140-Q) Adamantking Effigy
    141, -- (141-Q) Adamantking Effigy
    142  -- (142-Q) Adamantking Effigy
}

----------------------------------------------------------------------------------------------------
--                                  Setup of Children Spawning                                    --
----------------------------------------------------------------------------------------------------
------------------------------------------
--          Normal Child Spawn          --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].mobchildren = {#WAR, #MNK, #WHM, #BLM, #RDM, #THF, #PLD, #DRK, #BST, #BRD, #RNG, #SAM, #NIN, #DRG, #SMN}

xi.dynamis.mobList[zoneID][1  ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 BLM  1 NIN
xi.dynamis.mobList[zoneID][2  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil  }  -- 1 BRD  1 SAM
xi.dynamis.mobList[zoneID][3  ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 RDM
xi.dynamis.mobList[zoneID][4  ].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 THF
xi.dynamis.mobList[zoneID][5  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil  }  -- 1 BRD  1 DRG
xi.dynamis.mobList[zoneID][6  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  -- 2 BST
xi.dynamis.mobList[zoneID][7  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  -- 2 BST
xi.dynamis.mobList[zoneID][8  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  -- 2 BST
xi.dynamis.mobList[zoneID][9  ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil  }  -- 1 BRD  1 SAM
xi.dynamis.mobList[zoneID][10 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil  }  -- 1 BRD  1 SAM
xi.dynamis.mobList[zoneID][11 ].mobchildren = {   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 WAR  1 BLM  1 NIN
xi.dynamis.mobList[zoneID][12 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil,   1, nil  }  -- 1 BRD  1 SAM  1 DRG
xi.dynamis.mobList[zoneID][13 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 WHM  1 NIN
xi.dynamis.mobList[zoneID][14 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 1 BLM  1 DRK
xi.dynamis.mobList[zoneID][16 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 RDM
xi.dynamis.mobList[zoneID][18 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 THF
xi.dynamis.mobList[zoneID][20 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil  }  -- 1 BLM  1 DRK  1 NIN
xi.dynamis.mobList[zoneID][21 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 RDM  1 DRG
xi.dynamis.mobList[zoneID][22 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil  }  -- 1 DRK  1 BRD
xi.dynamis.mobList[zoneID][23 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 BLM  1 SAM
xi.dynamis.mobList[zoneID][24 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }  -- 1 MNK  1 RNG
xi.dynamis.mobList[zoneID][25 ].mobchildren = {   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 WHM
xi.dynamis.mobList[zoneID][27 ].mobchildren = { nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 RDM  1 THF
xi.dynamis.mobList[zoneID][29 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 PLD  1 NIN
xi.dynamis.mobList[zoneID][30 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 WAR  1 SAM
xi.dynamis.mobList[zoneID][31 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  -- 1 BLM  1 BRD
xi.dynamis.mobList[zoneID][32 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil  }  -- 1 WHM  1 DRK  1 NIN
xi.dynamis.mobList[zoneID][33 ].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 THF
xi.dynamis.mobList[zoneID][34 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 WHM  1 SAM
xi.dynamis.mobList[zoneID][35 ].mobchildren = { nil,   1, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil  }  -- 1 MNK  1 PLD  1 BRD
xi.dynamis.mobList[zoneID][36 ].mobchildren = { nil,   1, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 MNK  1 RDM  1 PLD
xi.dynamis.mobList[zoneID][37 ].mobchildren = { nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 RDM  1 PLD  1 NIN
xi.dynamis.mobList[zoneID][40 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  }  -- 1 SMN
xi.dynamis.mobList[zoneID][42 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil, nil, nil  }  -- 2 BST
xi.dynamis.mobList[zoneID][43 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 BLM  1 SAM
xi.dynamis.mobList[zoneID][45 ].mobchildren = {   1,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 MNK  1 RDM
xi.dynamis.mobList[zoneID][46 ].mobchildren = {   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 WAR  1 RDM  1 SAM
xi.dynamis.mobList[zoneID][47 ].mobchildren = { nil,   1, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 1 MNK  1 RDM  1 DRK
xi.dynamis.mobList[zoneID][48 ].mobchildren = { nil, nil, nil,   1, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 BLM  1 THF  1 PLD
xi.dynamis.mobList[zoneID][49 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 NIN
xi.dynamis.mobList[zoneID][50 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  -- 1 WAR  1 BRD
xi.dynamis.mobList[zoneID][51 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1,   1, nil  }  -- 1 RDM  1 NIN  1 DRG
xi.dynamis.mobList[zoneID][52 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil,   1, nil, nil, nil  }  -- 1 DRK  1 BRD  1 SAM
xi.dynamis.mobList[zoneID][53 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WHM
xi.dynamis.mobList[zoneID][55 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WHM
xi.dynamis.mobList[zoneID][56 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  }  -- 1 SMN
xi.dynamis.mobList[zoneID][57 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1  }  -- 1 SMN
xi.dynamis.mobList[zoneID][58 ].mobchildren = {   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 MNK  1 WHM
xi.dynamis.mobList[zoneID][59 ].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 THF
xi.dynamis.mobList[zoneID][60 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 1 MNK  1 WHM  1 DRK
xi.dynamis.mobList[zoneID][61 ].mobchildren = { nil,   1,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 MNK  1 WHM  1 PLD
xi.dynamis.mobList[zoneID][62 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WHM
xi.dynamis.mobList[zoneID][63 ].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 MNK  1 WHM  1 DRG
xi.dynamis.mobList[zoneID][64 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil,   1  }  -- 1 DRK  1 BST  1 SMN
xi.dynamis.mobList[zoneID][65 ].mobchildren = { nil,   1, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil  }  -- 1 MNK  1 DRK  1 BRD
xi.dynamis.mobList[zoneID][66 ].mobchildren = {   1, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WAR  1 RDM  1 THF
xi.dynamis.mobList[zoneID][68 ].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 BLM  1 PLD  1 SAM
xi.dynamis.mobList[zoneID][69 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WHM
xi.dynamis.mobList[zoneID][70 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  }  -- 2 RNG
xi.dynamis.mobList[zoneID][71 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }  -- 1 RNG
xi.dynamis.mobList[zoneID][72 ].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 THF  1 DRG
xi.dynamis.mobList[zoneID][73 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil  }  -- 1 DRK  1 SAM
xi.dynamis.mobList[zoneID][75 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 PLD  1 NIN
xi.dynamis.mobList[zoneID][76 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  -- 1 WAR  1 BRD
xi.dynamis.mobList[zoneID][77 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 BLM  1 DRG
xi.dynamis.mobList[zoneID][78 ].mobchildren = { nil,   1, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 MNK  1 BLM  1 PLD
xi.dynamis.mobList[zoneID][79 ].mobchildren = { nil,   1, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 1 MNK  1 BLM  1 DRK
xi.dynamis.mobList[zoneID][82 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 NIN
xi.dynamis.mobList[zoneID][83 ].mobchildren = { nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 PLD  1 NIN
xi.dynamis.mobList[zoneID][86 ].mobchildren = {   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 WAR  1 NIN
xi.dynamis.mobList[zoneID][87 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil,   1, nil, nil, nil  }  -- 1 DRK  1 BRD  1 SAM
xi.dynamis.mobList[zoneID][88 ].mobchildren = { nil,   2, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 2 MNK  1 DRK
xi.dynamis.mobList[zoneID][89 ].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   2, nil, nil, nil, nil  }  -- 1 WAR  1 MNK  1 WHM  1 BLM  2 RNG
xi.dynamis.mobList[zoneID][90 ].mobchildren = { nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WHM  1 PLD
xi.dynamis.mobList[zoneID][91 ].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WHM
xi.dynamis.mobList[zoneID][93 ].mobchildren = { nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 MNK  1 THF  1 DRG
xi.dynamis.mobList[zoneID][95 ].mobchildren = { nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 THF  1 PLD
xi.dynamis.mobList[zoneID][96 ].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 RDM  1 NIN
xi.dynamis.mobList[zoneID][97 ].mobchildren = { nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 BLM  1 THF
xi.dynamis.mobList[zoneID][98 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil, nil  }  -- 1 BRD  1 NIN
xi.dynamis.mobList[zoneID][99 ].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil  }  -- 1 DRK  1 BRD
xi.dynamis.mobList[zoneID][100].mobchildren = { nil, nil, nil, nil,   1, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 RDM  1 PLD
xi.dynamis.mobList[zoneID][101].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil  }  -- 1 SAM  1 DRG
xi.dynamis.mobList[zoneID][102].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 THF
xi.dynamis.mobList[zoneID][105].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 RDM  1 SAM
xi.dynamis.mobList[zoneID][106].mobchildren = { nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil  }  -- 1 BLM  1 NIN
xi.dynamis.mobList[zoneID][107].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 MNK  1 DRG
xi.dynamis.mobList[zoneID][108].mobchildren = { nil, nil, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 RDM  1 DRG
xi.dynamis.mobList[zoneID][109].mobchildren = { nil, nil, nil,   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 BLM  1 PLD
xi.dynamis.mobList[zoneID][112].mobchildren = {   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 3 WAR
xi.dynamis.mobList[zoneID][113].mobchildren = { nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 3 BLM
xi.dynamis.mobList[zoneID][114].mobchildren = { nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 3 MNK
xi.dynamis.mobList[zoneID][115].mobchildren = { nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil  }  -- 3 DRK
xi.dynamis.mobList[zoneID][116].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil  }  -- 3 RNG
xi.dynamis.mobList[zoneID][117].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil  }  -- 3 DRG
xi.dynamis.mobList[zoneID][118].mobchildren = { nil, nil, nil, nil, nil,   4, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 4 THF
xi.dynamis.mobList[zoneID][119].mobchildren = { nil, nil,   4, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 4 WHM
xi.dynamis.mobList[zoneID][120].mobchildren = { nil, nil, nil, nil, nil, nil,   4, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 4 PLD
xi.dynamis.mobList[zoneID][121].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3  }  -- 3 SMN
xi.dynamis.mobList[zoneID][122].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   4, nil, nil, nil  }  -- 4 SAM
xi.dynamis.mobList[zoneID][123].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil,   4, nil, nil, nil, nil, nil  }  -- 4 BRD
xi.dynamis.mobList[zoneID][124].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil  }  -- 3 NIN
xi.dynamis.mobList[zoneID][125].mobchildren = { nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 3 RDM
xi.dynamis.mobList[zoneID][126].mobchildren = {   1, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  -- 1 WAR  1 THF  1 BRD
xi.dynamis.mobList[zoneID][127].mobchildren = { nil, nil, nil,   1, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 1 BLM  1 PLD  1 DRK
xi.dynamis.mobList[zoneID][128].mobchildren = { nil,   1,   1, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil, nil  }  -- 1 MNK  1 WHM  1 RNG
xi.dynamis.mobList[zoneID][129].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   2  }  -- 2 SMN
xi.dynamis.mobList[zoneID][130].mobchildren = { nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 MNK  1 DRG
xi.dynamis.mobList[zoneID][131].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil,   1, nil  }  -- 1 RNG  1 DRG
xi.dynamis.mobList[zoneID][132].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1,   1,   1, nil, nil  }  -- 1 RNG  1 SAM  1 NIN
xi.dynamis.mobList[zoneID][133].mobchildren = { nil, nil, nil, nil,   1,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  -- 1 RDM  1 THF  1 BRD
xi.dynamis.mobList[zoneID][134].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 1 PLD  1 DRK
xi.dynamis.mobList[zoneID][135].mobchildren = { nil, nil, nil, nil, nil, nil,   1,   1, nil, nil, nil, nil, nil, nil, nil  }  -- 1 PLD  1 DRK
xi.dynamis.mobList[zoneID][136].mobchildren = { nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil  }  -- 1 WHM  1 SAM  1 DRG
xi.dynamis.mobList[zoneID][137].mobchildren = {   1, nil, nil,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil  }  -- 1 WAR  1 BLM  1 DRG
xi.dynamis.mobList[zoneID][138].mobchildren = { nil, nil, nil, nil, nil,   1, nil, nil, nil,   1, nil, nil, nil, nil, nil  }  -- 1 THF  1 BRD
xi.dynamis.mobList[zoneID][139].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil,   1, nil, nil  }  -- 1 RNG  1 NIN
xi.dynamis.mobList[zoneID][140].mobchildren = {   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil,   1, nil, nil, nil  }  -- 1 WAR  1 MNK  1 SAM
xi.dynamis.mobList[zoneID][141].mobchildren = { nil, nil,   1,   1,   1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil  }  -- 1 WHM  1 BLM  1 RDM
xi.dynamis.mobList[zoneID][142].mobchildren = { nil, nil, nil, nil, nil, nil, nil, nil,   3, nil, nil, nil, nil, nil, nil  }  -- 3 BST

------------------------------------------
--            NM Child Spawn            --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].nmchildren = {MobIndex(NM1), MobIndex(NM2), MobIndex(NM3)}
-- boolean value = forceLink true/false

xi.dynamis.mobList[zoneID][25 ].nmchildren = { true, 26 }
xi.dynamis.mobList[zoneID][28 ].nmchildren = { true, 29, 30, 31 }
xi.dynamis.mobList[zoneID][42 ].nmchildren = { true, 144 } -- Be'Ebo Tortoisedriver (BST)
xi.dynamis.mobList[zoneID][53 ].nmchildren = { true, 54, 145 } -- Gi'Pha Manameister (BLM)
xi.dynamis.mobList[zoneID][55 ].nmchildren = { true, 146 } -- Gu'Nhi Noondozer (SMN)
xi.dynamis.mobList[zoneID][62 ].nmchildren = { true, 143 } -- Aa'Nyu Dismantler (DRK)
xi.dynamis.mobList[zoneID][69 ].nmchildren = { true, 148 } -- Ke'Dhe Cannonball (MNK)
xi.dynamis.mobList[zoneID][88 ].nmchildren = { true, 89 }
xi.dynamis.mobList[zoneID][89 ].nmchildren = { true, 154, 155, 156 } -- Vanguard Vindicator/Constable/Militant (3x 10min TEs)
xi.dynamis.mobList[zoneID][91 ].nmchildren = { true, 92, 147 } -- Ze'Vho Fallsplitter (DRK)
xi.dynamis.mobList[zoneID][110].nmchildren = { true, 111, 149, 150, 151, 152, 153 } -- Boss spawns 5 NMs (Effigy Shields) and 1 statue

------------------------------------------
--          Mob Position Info           --
-- Note: Must be setup for parent mobs, --
-- but is optional for children.        --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].pos = {xpos, ypos, zpos, rot}

xi.dynamis.mobList[zoneID][1  ].pos = { 81.7644, 0.0000, -71.8662, 0   } -- W1 Mog C
xi.dynamis.mobList[zoneID][2  ].pos = { 76.1541, 0.0000, -66.1046, 10  } -- W1 Mog N
xi.dynamis.mobList[zoneID][3  ].pos = { 60.4041, 0.0000, -81.5565, 8   } -- W1 Mog S
xi.dynamis.mobList[zoneID][4  ].pos = { 42.8057, 0.0000, -56.8658, 80  } -- W1 AH E.Alley S
xi.dynamis.mobList[zoneID][5  ].pos = { 38.2376, 0.0000, -42.7884, 75  } -- W1 AH E.Alley C
xi.dynamis.mobList[zoneID][6  ].pos = { 39.9337, 0.7986, -88.8102, 192 } -- W1 Choc C
xi.dynamis.mobList[zoneID][7  ].pos = { 49.9168, 0.8720, -90.7635, 182 } -- W1 Choc E
xi.dynamis.mobList[zoneID][8  ].pos = { 28.6896, 0.8720, -91.7210, 202 } -- W1 Choc W
xi.dynamis.mobList[zoneID][9  ].pos = { 19.0447, 0.0000, -71.2227, 45  } -- W1 AH EE
xi.dynamis.mobList[zoneID][10 ].pos = { 10.7120, 0.0000, -78.6646, 53  } -- W1 AH E
xi.dynamis.mobList[zoneID][11 ].pos = {  7.0503, 0.0000,-100.7739, 192 } -- W1 W of Choc
xi.dynamis.mobList[zoneID][12 ].pos = {  0.0159, 0.0000, -73.3527, 61  } -- W1 AH C
xi.dynamis.mobList[zoneID][13 ].pos = { -9.0602, 0.0000, -78.5527, 69  } -- W1 AH W
xi.dynamis.mobList[zoneID][14 ].pos = {-18.9468, 0.0000, -71.3164, 77  } -- W1 AH WW
xi.dynamis.mobList[zoneID][15 ].pos = { 16.3665,-3.0000, -54.6565, 175 } -- W1 AHtop EE
xi.dynamis.mobList[zoneID][16 ].pos = {  8.4347,-3.0000, -56.4465, 183 } -- W1 AHtop E
xi.dynamis.mobList[zoneID][17 ].pos = { -0.0019,-3.0000, -57.3668, 191 } -- W1 AHtop C
xi.dynamis.mobList[zoneID][18 ].pos = { -8.4375,-3.0000, -56.5214, 199 } -- W1 AHtop W
xi.dynamis.mobList[zoneID][19 ].pos = {-16.4125,-3.0000, -54.3911, 207 } -- W1 AHtop WW
xi.dynamis.mobList[zoneID][20 ].pos = {-35.5730, 0.0000, -78.3345, 9   } -- W1 SW of AH
xi.dynamis.mobList[zoneID][21 ].pos = {-24.4831, 0.0000, -97.2766, 192 } -- W1 S.Gate NW
xi.dynamis.mobList[zoneID][22 ].pos = {-10.4154,-1.0008,-106.0800, 192 } -- W1 S.Gate C
xi.dynamis.mobList[zoneID][23 ].pos = {-24.4167,-1.0008,-106.3167, 192 } -- W1 S.Gate W
xi.dynamis.mobList[zoneID][24 ].pos = { -5.6342,-1.0008,-115.6188, 192 } -- W1 S.Gate SE
xi.dynamis.mobList[zoneID][25 ].pos = {-16.2038,-1.0008,-122.3855, 192 } -- W1 S.Gate S
xi.dynamis.mobList[zoneID][26 ].pos = {-23.9244,-1.0008,-121.6056, 227 } -- W1 spawned by 330
xi.dynamis.mobList[zoneID][27 ].pos = {-26.3670,-1.0008,-121.4364, 192 } -- W1 S.Gate SW
xi.dynamis.mobList[zoneID][28 ].pos = {-37.0065, 0.0000, -56.1556, 60  } -- W1 W of AH (S)
xi.dynamis.mobList[zoneID][29 ].pos = {-35.4041, 0.0000, -58.2174, 60  } -- W1 spawned by 313
xi.dynamis.mobList[zoneID][30 ].pos = {-38.9458, 0.0000, -58.3568, 60  } -- W1 spawned by 313
xi.dynamis.mobList[zoneID][31 ].pos = {-37.0648, 0.0000, -53.8018, 64  } -- W1 spawned by 313
xi.dynamis.mobList[zoneID][32 ].pos = {-38.4296, 0.0000, -38.0029, 60  } -- W1 W of AH (C)
xi.dynamis.mobList[zoneID][33 ].pos = {-28.5587, 0.0000, -25.8180, 82  } -- W1 W of AH (NE)
xi.dynamis.mobList[zoneID][34 ].pos = {-46.8709, 0.0000, -20.4151, 49  } -- W1 W of AH (NW)
xi.dynamis.mobList[zoneID][35 ].pos = {  0.4871, 0.0000, -24.9742, 128 } -- W1 AH N.Alley C
xi.dynamis.mobList[zoneID][36 ].pos = { -4.9191, 0.0000, -17.1571, 190 } -- W1 AH N.Alley Catwalk
xi.dynamis.mobList[zoneID][37 ].pos = { 30.4976, 0.0000, -26.9415, 55  } -- W1 AH E.Alley N
xi.dynamis.mobList[zoneID][38 ].pos = {-41.0685, 0.0000,  -2.1238, 255 } -- W1 W of Boytz (S)
xi.dynamis.mobList[zoneID][39 ].pos = {-45.5975, 0.0000,   4.8671, 128 } -- W1 W of Boytz (C)
xi.dynamis.mobList[zoneID][40 ].pos = {-44.9282,-3.4933,  15.1018, 93  } -- W1 W of Boytz (N)
xi.dynamis.mobList[zoneID][41 ].pos = {-57.7503, 0.0000,  41.0368, 192 } -- W1 Corner Shed E
xi.dynamis.mobList[zoneID][42 ].pos = {-64.5615, 0.0000,  41.3409, 192 } -- W1 Corner Sheds W
xi.dynamis.mobList[zoneID][43 ].pos = { -21.3849, 7.0000, 31.8739, 119 } -- W1 O.St. Entr N
xi.dynamis.mobList[zoneID][44 ].pos = { -20.1820, 7.0000, 27.5603, 130 } -- W1 O.St. Entr S
xi.dynamis.mobList[zoneID][45 ].pos = {   2.0635, 7.0000, 18.2131, 159 } -- W1 O.St. NW
xi.dynamis.mobList[zoneID][46 ].pos = {  -2.5034, 7.0000, -6.0080, 0   } -- W1 O.St. SW
xi.dynamis.mobList[zoneID][47 ].pos = {  21.0685, 7.0000,  1.1670, 115 } -- W1 O.St. NE
xi.dynamis.mobList[zoneID][48 ].pos = {  14.0251, 7.0000, -8.5442, 192 } -- W1 O.St. SE
xi.dynamis.mobList[zoneID][49 ].pos = {  30.9778, 7.0000,  5.6604, 64  } -- W1 O.St. CW S.Well Base
xi.dynamis.mobList[zoneID][50 ].pos = {  31.0277, 0.0000, 23.8121, 64  } -- W1 O.St. CW S.Well#2
xi.dynamis.mobList[zoneID][51 ].pos = {  69.9420, 7.0000,  2.5947, 64  } -- W1 Alch NW
xi.dynamis.mobList[zoneID][52 ].pos = {  81.9570, 7.0000,  2.3986, 64  } -- W1 Alch NE
xi.dynamis.mobList[zoneID][53 ].pos = {  90.2082, 7.0029, -2.4041, 128 } -- W1 Alch E
xi.dynamis.mobList[zoneID][54 ].pos = {  90.0454, 7.0000, -5.9869, 133 } -- W1 spawned by 222
xi.dynamis.mobList[zoneID][55 ].pos = {  73.8867, 7.0029,-34.8135, 185 } -- W1 Gal.Dist. S
xi.dynamis.mobList[zoneID][56 ].pos = {  83.5793, 7.0000,-32.4353, 145 } -- W1 Gal.Dist. E
xi.dynamis.mobList[zoneID][57 ].pos = {  63.8661, 7.0000,-32.7333, 215 } -- W1 Gal.Dist. W
xi.dynamis.mobList[zoneID][58 ].pos = {-78.0000, 0.0000,   4.0000, 0   } -- W1 Under Bridge NE
xi.dynamis.mobList[zoneID][59 ].pos = {-74.0000, 0.0000,   0.0000, 0   } -- W1 Under Bridge E
xi.dynamis.mobList[zoneID][60 ].pos = {-78.0000, 0.0000,  -4.0000, 0   } -- W1 Under Bridge SE
xi.dynamis.mobList[zoneID][61 ].pos = {-91.2000, 0.0000,   6.0000, 0   } -- W1 Under Bridge NW
xi.dynamis.mobList[zoneID][62 ].pos = {-91.2000, 0.0000,  -1.0000, 0   } -- W1 Under Bridge W
xi.dynamis.mobList[zoneID][63 ].pos = {-91.2000, 0.0000,  -6.0000, 0   } -- W1 Under Bridge SW
xi.dynamis.mobList[zoneID][64 ].pos = {-108.8306, 0.0000, -9.2511, 234 } -- W1 Chokepoint/Zeruhn Sect
xi.dynamis.mobList[zoneID][65 ].pos = { -99.3387, 8.0000, 46.4492, 72  } -- W1 Markets S
xi.dynamis.mobList[zoneID][66 ].pos = {-103.6146,10.0026, 56.2027, 60  } -- W1 Markets C
xi.dynamis.mobList[zoneID][67 ].pos = {-111.2602,12.0000, 65.9353, 64  } -- W1 Markets W
xi.dynamis.mobList[zoneID][68 ].pos = { -96.7740,12.0000, 66.2248, 64  } -- W1 Markets E
xi.dynamis.mobList[zoneID][69 ].pos = {-104.0242,12.0000, 72.8178, 64  } -- W1 Markets N
xi.dynamis.mobList[zoneID][70 ].pos = {-108.1392,-0.3415,-37.2321, 189 } -- W1 Depot Ramp Base
xi.dynamis.mobList[zoneID][71 ].pos = { -99.4389,-8.0000,-59.8070, 127 } -- W1 Depot Ramp Top
xi.dynamis.mobList[zoneID][72 ].pos = { -52.6932,-8.0000,-54.5636, 106 } -- W1 Depot Balc N
xi.dynamis.mobList[zoneID][73 ].pos = { -52.3919,-8.0000,-66.1270, 147 } -- W1 Depot Balc C
xi.dynamis.mobList[zoneID][74 ].pos = { -58.0759,-8.0000,-79.5513, 194 } -- W1 Depot Balc S
xi.dynamis.mobList[zoneID][75 ].pos = {-128.0898,-0.5724, -0.9718, 64  } -- W1 Zer N.Ramp (NW)
xi.dynamis.mobList[zoneID][76 ].pos = {-133.1783,-0.5393,  4.0241, 64  } -- W1 Zer N.Ramp (SW)
xi.dynamis.mobList[zoneID][77 ].pos = {-133.5637, 0.0000,-31.0000, 96  } -- W1 Zer S.Clearing (NW)
xi.dynamis.mobList[zoneID][78 ].pos = {-122.6414, 0.0000,-43.4918, 192 } -- W1 Zer S.Clearing (N)
xi.dynamis.mobList[zoneID][79 ].pos = {-117.1745, 0.0000,-43.4918, 192 } -- W1 Zer S.Clearing (NE)
xi.dynamis.mobList[zoneID][80 ].pos = {-123.7850,-3.4933,-74.1327, 189 } -- W1 Zer S.Clearing (S)
xi.dynamis.mobList[zoneID][81 ].pos = {-122.9294, 0.0000,-78.9028, 165 } -- W1 Zer S.Clearing (SE)
xi.dynamis.mobList[zoneID][82 ].pos = {-138.1234,-11.9249,29.2820, 28  } -- W1 Zer N.Ramp (top)
xi.dynamis.mobList[zoneID][83 ].pos = {-147.1535, 0.0000,  4.2789, 60  } -- W1 Zer W.Clearing (NE)
xi.dynamis.mobList[zoneID][84 ].pos = {-155.1991, 0.0000,  2.2134, 28  } -- W1 Zer W.Clearing (N)
xi.dynamis.mobList[zoneID][85 ].pos = {-164.7690,-3.4933, -2.0815, 2   } -- W1 Zer W.Clearing (NW)
xi.dynamis.mobList[zoneID][86 ].pos = {-161.1492, 0.0000,-11.3847, 249 } -- W1 Zer W.Clearing (W)
xi.dynamis.mobList[zoneID][87 ].pos = {-152.0940, 0.0000,-20.0017, 245 } -- W1 Zer W.Clearing (S)
xi.dynamis.mobList[zoneID][88 ].pos = {-153.7795, 0.0000,-40.9650, 191 } -- W1 Zer W.Ramp Base
xi.dynamis.mobList[zoneID][89 ].pos = {-160.1865, 0.0000,-40.8198, 232 } -- W1 spawned by 13
xi.dynamis.mobList[zoneID][90 ].pos = {-175.8118,-7.7793,-21.0173, 223 } -- W1 Zer W.Ramp (S)
xi.dynamis.mobList[zoneID][91 ].pos = {-178.4068,-8.1360,-17.9503, 254 } -- W1 Zer W.Ramp (W)
xi.dynamis.mobList[zoneID][92 ].pos = {-177.2654,-8.3147,-13.5608, 17  } -- W1 spawned by 1
xi.dynamis.mobList[zoneID][93 ].pos = {-173.8426,-7.8933,-10.8492, 21  } -- W1 Zer W.Ramp (N)
xi.dynamis.mobList[zoneID][94 ].pos = {-29.5942, 0.0000,  23.0013, 0   } -- W1 N of Boytz, Catwalk
xi.dynamis.mobList[zoneID][95 ].pos = { -14.0588, 0.0000, 30.0374, 143 } -- W1 O.St. Entr Bridge
xi.dynamis.mobList[zoneID][96 ].pos = {  -0.3031, 0.0000, 37.6598, 125 } -- W1 O.St. Entr Catwalk
xi.dynamis.mobList[zoneID][97 ].pos = {   8.8358, 0.0000, 22.4781, 170 } -- W1 O.St. CW Enc.#1
xi.dynamis.mobList[zoneID][98 ].pos = {   2.1785, 0.0000, 10.0314, 154 } -- W1 O.St. CW Bridge
xi.dynamis.mobList[zoneID][99 ].pos = {   8.9690, 0.0000, -5.4239, 192 } -- W1 O.St. CW W Enc.#1
xi.dynamis.mobList[zoneID][100].pos = {   8.8837, 0.0000,-16.3382, 192 } -- W1 O.St. CW W Enc.#2
xi.dynamis.mobList[zoneID][101].pos = {  17.7209, 0.0000,  7.9742, 133 } -- W1 O.St. CW Enc.#2
xi.dynamis.mobList[zoneID][102].pos = {  36.0086, 0.0000,  8.1324, 191 } -- W1 O.St. CW Enc.#3
xi.dynamis.mobList[zoneID][103].pos = {  37.0316, 0.0000, 20.2594, 147 } -- W1 O.St. CW S.Well#1
xi.dynamis.mobList[zoneID][104].pos = {  60.1261, 0.0000,  8.1024, 129 } -- W1 O.St. CW Enc.#4
xi.dynamis.mobList[zoneID][105].pos = {  60.0449, 0.0000, -1.2954, 192 } -- W1 O.St. CW E Enc.#1
xi.dynamis.mobList[zoneID][106].pos = {  50.8795,-0.0029,-13.2487, 232 } -- W1 O.St. CW E Enc.#2
xi.dynamis.mobList[zoneID][107].pos = {  61.7784, 0.0000,-20.6739, 187 } -- W1 O.St. CW E Enc.#3
xi.dynamis.mobList[zoneID][108].pos = {  69.9259, 0.0000, 10.5869, 64  } -- W1 O.St. CW Enc.#5
xi.dynamis.mobList[zoneID][109].pos = {  86.0668, 0.0000, 10.5541, 64  } -- W1 O.St. CW Enc.#6
xi.dynamis.mobList[zoneID][110].pos = {-16.1024,-1.0008,-124.9145, 192 } -- W2 Final Boss South Gate
xi.dynamis.mobList[zoneID][111].pos = {-31.7986,-1.0008,-122.3744, 218 } -- W2 W of Final Boss
xi.dynamis.mobList[zoneID][112].pos = {-20.0432,-3.0000, -58.9616, 56  } -- W3 AH WW
xi.dynamis.mobList[zoneID][113].pos = {-12.3780,-3.0000, -61.4330, 89  } -- W3 AH W
xi.dynamis.mobList[zoneID][114].pos = {  0.1313,-3.0000, -62.5700, 66  } -- W3 AH C
xi.dynamis.mobList[zoneID][115].pos = { 10.7283,-3.0000, -61.6430, 30  } -- W3 AH E
xi.dynamis.mobList[zoneID][116].pos = { 19.1724,-3.0000, -59.4239, 67  } -- W3 AH EE
xi.dynamis.mobList[zoneID][117].pos = { 18.1155, 0.0000, -99.2747, 144 } -- W3 W of Choco (N)
xi.dynamis.mobList[zoneID][118].pos = { 16.5028, 0.0000,-110.3989, 198 } -- W3 W of Choco (C)
xi.dynamis.mobList[zoneID][119].pos = { 16.5175, 0.0000,-121.5445, 190 } -- W3 W of Choco (S)
xi.dynamis.mobList[zoneID][120].pos = {  9.4977, 0.0000,-121.5922, 201 } -- W3 far W of Choco
xi.dynamis.mobList[zoneID][121].pos = { 31.6634, 0.0000, -64.0405, 86  } -- W3 Alley W
xi.dynamis.mobList[zoneID][122].pos = { 39.7658, 0.0000, -59.6651, 64  } -- W3 Alley E
xi.dynamis.mobList[zoneID][123].pos = { 54.8432, 0.0000, -67.1650, 93  } -- W3 Outside Mog NW
xi.dynamis.mobList[zoneID][124].pos = { 64.4780, 0.0000, -66.9347, 103 } -- W3 Outside Mog N
xi.dynamis.mobList[zoneID][125].pos = { 76.5238, 0.0000, -67.1802, 92  } -- W3 Outside Mog NE
xi.dynamis.mobList[zoneID][126].pos = { 62.2124, 0.0000, -85.9488, 159 } -- W3 Outside Mog SW
xi.dynamis.mobList[zoneID][127].pos = { 67.9729, 0.0000, -85.3997, 171 } -- W3 Outside Mog S
xi.dynamis.mobList[zoneID][128].pos = { 77.0071, 0.0000, -79.6646, 140 } -- W3 Outside Mog SE
xi.dynamis.mobList[zoneID][129].pos = { 90.1017, 0.6234, -71.7804, 128 } -- W3 Mog Clockwise #1
xi.dynamis.mobList[zoneID][130].pos = { 90.4399, 0.9944, -57.0740, 66  } -- W3 Mog Clockwise #2
xi.dynamis.mobList[zoneID][131].pos = { 90.7621, 0.9944, -87.7146, 190 } -- W3 Mog Clockwise #12
xi.dynamis.mobList[zoneID][132].pos = {102.6341, 0.9944, -56.2798, 114 } -- W3 Mog Clockwise #3
xi.dynamis.mobList[zoneID][133].pos = {102.8179, 0.9944, -88.3096, 146 } -- W3 Mog Clockwise #11
xi.dynamis.mobList[zoneID][134].pos = {110.9067, 0.9944, -56.7192, 121 } -- W3 Mog Clockwise #4
xi.dynamis.mobList[zoneID][135].pos = {110.8669, 0.9944, -88.1171, 135 } -- W3 Mog Clockwise #10
xi.dynamis.mobList[zoneID][136].pos = {101.4331, 0.9944, -65.9948, 185 } -- W3 Mog N
xi.dynamis.mobList[zoneID][137].pos = {101.6548, 0.9944, -78.9599, 69  } -- W3 Mog S
xi.dynamis.mobList[zoneID][138].pos = {119.3663, 0.9944, -54.6408, 89  } -- W3 Mog Clockwise #5
xi.dynamis.mobList[zoneID][139].pos = {118.7241, 0.9944, -88.4772, 161 } -- W3 Mog Clockwise #9
xi.dynamis.mobList[zoneID][140].pos = {117.2807, 0.9944, -65.8843, 128 } -- W3 Mog Clockwise #6
xi.dynamis.mobList[zoneID][141].pos = {117.2807, 0.9944, -77.7863, 128 } -- W3 Mog Clockwise #8
xi.dynamis.mobList[zoneID][142].pos = {117.2442, 0.9944, -71.5537, 128 } -- W3 Mog Clockwise #7

----------------------------------------------------------------------------------------------------
--                                    Setup of Mob Functions                                      --
----------------------------------------------------------------------------------------------------
------------------------------------------
--             Patrol Paths             --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].patrolPath = {xpos1,ypos1,zpos1, xpos2,ypos2,zpos2,  xpos3,ypos3,zpos3}

-- xi.dynamis.mobList[zoneID][8  ].patrolPath = { -96,  -2, -123,     -60,  -2, -113,    -96,   -2, -123  }    -- Entrance Bridge W

xi.dynamis.mobList[zoneID].patrolPaths = {6, 35, 11, 21, 14, 12, 9, 34, 25, 32, 58, 60, 59, 61, 63, 62, 75, 76, 70, 71, 47, 49, 50, 104, 102}
xi.dynamis.mobList[zoneID][6  ].patrolPath = { {40,    0,   -85},  {  40,    1,  -96,}                      } -- W1 Choc C
xi.dynamis.mobList[zoneID][35 ].patrolPath = { { 3,    0,   -25},  { -12,    0,  -25,}                      } -- W1 AH N.Alley C
xi.dynamis.mobList[zoneID][11 ].patrolPath = { { 7,    0,  -100},  {   5,    0,  -79,}                      } -- W1 W of Choc
xi.dynamis.mobList[zoneID][21 ].patrolPath = { {-24,    0, -100},  { -24,    0,  -79,}                      } -- W1 W of Choc
xi.dynamis.mobList[zoneID][14 ].patrolPath = { {-20,    0,  -79},  { -16,   -3,  -64,}                      } -- W1 AH WW
xi.dynamis.mobList[zoneID][12 ].patrolPath = { { 0,    0,   -79},  {  0,    -3,  -64,}                      } -- W1 AH C
xi.dynamis.mobList[zoneID][9  ].patrolPath = { {20,    0,   -79},  {  16,   -3,  -64,}                      } -- W1 AH EE
xi.dynamis.mobList[zoneID][34 ].patrolPath = { {-44,    0,  -29},  { -42,    0,   -9,}                      } -- W1 W of AH (NW)
xi.dynamis.mobList[zoneID][25 ].patrolPath = { {-10,   -1, -114},  { -25,   -1, -114,}                      } -- W1 S.Gate S
xi.dynamis.mobList[zoneID][32 ].patrolPath = { {-32,    0,  -38},  { -45,    0,  -38,}                      } -- W1 W of AH (C)
xi.dynamis.mobList[zoneID][58 ].patrolPath = { {-78,    0,    4},  { -70,    0,    9,}                      } -- W1 Under Bridge NE
xi.dynamis.mobList[zoneID][60 ].patrolPath = { {-78,    0,   -4},  { -70,    0,   -9,}                      } -- W1 Under Bridge SE
xi.dynamis.mobList[zoneID][59 ].patrolPath = { {-70,    0,    0},  { -78,    0,    0,}                      } -- W1 Under Bridge E
xi.dynamis.mobList[zoneID][61 ].patrolPath = { {-94,    0,    9},  { -87,    0,    4,}                      } -- W1 Under Bridge NW
xi.dynamis.mobList[zoneID][63 ].patrolPath = { {-94,    0,   -9},  { -87,    0,   -4,}                      } -- W1 Under Bridge SW
xi.dynamis.mobList[zoneID][62 ].patrolPath = { {-94,    0,    0},  { -86,    0,    0,}                      } -- W1 Under Bridge W
xi.dynamis.mobList[zoneID][75 ].patrolPath = { {-128, -1.6,   4},  {-128,    0,   -6,}                      } -- W1 Zer N.Ramp (SW)
xi.dynamis.mobList[zoneID][76 ].patrolPath = { {-132,    0,  -6},  {-132, -1.6,    4,}                      } -- W1 Zer N.Ramp (NW)
xi.dynamis.mobList[zoneID][70 ].patrolPath = { {-108,   -8, -60},  {-108,   -0, -35  }, {-108,    0,  -14,} } -- W1 Depot Ramp Base
xi.dynamis.mobList[zoneID][71 ].patrolPath = { {-102,   -8, -60},  { -60,    0,  -60,}                      } -- W1 Depot Ramp Top
xi.dynamis.mobList[zoneID][47 ].patrolPath = { {  31,    7,  -2},  {   4,    7,   -2,}                      } -- W1 O.St. NE
xi.dynamis.mobList[zoneID][49 ].patrolPath = { {  31,    7,   5},  {  31,    3,   16,}                      } -- W1 O.St. CW S.Well Base
xi.dynamis.mobList[zoneID][50 ].patrolPath = { {  31,    0,  24},  {  31,    2,   18,}                      } -- W1 O.St. CW S.Well#2
xi.dynamis.mobList[zoneID][104].patrolPath = { {  74,    0,   8},  {  60,    0,    8,}                      } -- W1 O.St. CW Enc.#4
xi.dynamis.mobList[zoneID][102].patrolPath = { {  36,    0,   8},  {  21,    0,    8,}                      } -- W1 O.St. CW Enc.#3

------------------------------------------
--          Statue Eye Colors           --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eye.BLUE -- Flags for blue eyes. (HP)
-- xi.dynamis.mobList[zoneID][MobIndex].eyes = xi.dynamis.eye.GREEN -- Flags for green eyes. (MP)

xi.dynamis.mobList[zoneID][7  ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][8  ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][25 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][26 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][31 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][38 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][39 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][42 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][81 ].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][82 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][85 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][92 ].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][104].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][112].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][114].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][116].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][119].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][120].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][121].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][122].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][124].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][125].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][127].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][129].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][132].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][133].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][136].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][137].eyes = xi.dynamis.eye.GREEN
xi.dynamis.mobList[zoneID][138].eyes = xi.dynamis.eye.BLUE
xi.dynamis.mobList[zoneID][139].eyes = xi.dynamis.eye.BLUE

------------------------------------------
--        Time Extension Values         --
------------------------------------------
-- xi.dynamis.mobList[zoneID][MobIndex].timeExtension = 15

xi.dynamis.mobList[zoneID].timeExtensionList = {1, 19, 41, 146, 113, 154, 155, 156}
xi.dynamis.mobList[zoneID][1  ].timeExtension = 20 -- Adamantking Effigy
xi.dynamis.mobList[zoneID][19 ].timeExtension = 20 -- Adamantking Effigy
xi.dynamis.mobList[zoneID][41 ].timeExtension = 20 -- Adamantking Effigy
xi.dynamis.mobList[zoneID][113].timeExtension = 30 -- Goblin Golem
xi.dynamis.mobList[zoneID][146].timeExtension = 30 -- Gu'Nhi Noondozer
xi.dynamis.mobList[zoneID][154].timeExtension = 10 -- Vanguard Vindicator
xi.dynamis.mobList[zoneID][155].timeExtension = 10 -- Vanguard Constable
xi.dynamis.mobList[zoneID][156].timeExtension = 10 -- Vanguard Militant
