--------------------------------------------
--          Dynamis 75 Era Module         --
--------------------------------------------
--------------------------------------------
--       Module Required Scripts          --
--------------------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/utils")
require("scripts/globals/zone")
require("scripts/globals/msg")
require("scripts/globals/pathfind")
require("scripts/globals/dynamis")
require("modules/module_utils")
--------------------------------------------
--       Module Extended Scripts          --
--------------------------------------------
require("modules/era/lua_dynamis/mobs/era_beaucedine_mobs")
require("modules/era/lua_dynamis/mobs/era_buburimu_mobs")
require("modules/era/lua_dynamis/mobs/era_qufim_mobs")
require("modules/era/lua_dynamis/mobs/era_valkurm_mobs")
require("modules/era/lua_dynamis/mobs/era_xarcabard_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_bastok_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_beaucedine_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_buburimu_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_jeuno_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_qufim_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_san_d_oria_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_valkurm_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_windurst_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_xarcabard_mobs")
require("scripts/zones/Dynamis-Xarcabard/IDs")
--------------------------------------------

local m = Module:new("era_dynamis_spawning")

xi = xi or {  }
xi.dynamis = xi.dynamis or {  }

xi.dynamis.SUBLINK_ID = 2
--------------------------------------------
--          Dynamis Mob Spawning          --
--------------------------------------------

xi.dynamis.spawnWaveIndicies = function(zone, waveNumber, indicies)
    if not waveNumber then
        return
    end

    if not indicies then
        return
    end

    local zoneID = zone:getID()

    local mobList = xi.dynamis.mobList[zone:getID()][waveNumber].wave
    if not mobList then
        return
    end

    for _, mobIndex in indicies do
        local mobType = xi.dynamis.mobList[zoneID][mobIndex].info[1]
        if mobType == "NM" then
            xi.dynamis.nmDynamicSpawn(mobIndex, nil, true, zoneID)
        else
            xi.dynamis.nonStandardDynamicSpawn(mobIndex, nil, true, zoneID)
        end
    end

    -- Account for previous waves if this is not the first wave
    if waveNumber > 1 then
        for n = 1, waveNumber do
            zone:setLocalVar(string.format("Wave_%i_Spawned", n), 1)
        end
    end

    -- Update current variables for wave
    zone:setLocalVar(string.format("Wave_%i_Spawned", waveNumber), 1)
    zone:setLocalVar(string.format("[DYNA]CurrentWave_%s", zoneID), waveNumber)
end

xi.dynamis.spawnWave = function(zone, zoneID, waveNumber)
    for _, mobIndex in pairs(xi.dynamis.mobList[zoneID][waveNumber].wave) do
        local mobType = xi.dynamis.mobList[zoneID][mobIndex].info[1]
        if mobType == "NM" then -- NMs
            xi.dynamis.nmDynamicSpawn(mobIndex, nil, true, zoneID)
        else -- Nightmare Mobs and Statues
            xi.dynamis.nonStandardDynamicSpawn(mobIndex, nil, true, zoneID)
        end
    end
    if waveNumber == 5 and zoneID == xi.zone.DYNAMIS_XARCABARD then
        local playersInZone = zone:getPlayers()
        for _, player in pairs(playersInZone) do
            player:messageSpecial(zones[xi.zone.DYNAMIS_XARCABARD].text.PRISON_OF_SOULS_HAS_SET_FREE)
        end
    end
    zone:setLocalVar(string.format("Wave_%i_Spawned", waveNumber), 1)
    zone:setLocalVar(string.format("[DYNA]CurrentWave_%s", zoneID), waveNumber)
end

xi.dynamis.parentOnEngaged = function(mob, target)
    local oMobIndex = mob:getZone():getLocalVar(string.format("MobIndex_%s", mob:getID()))
    if mob:getLocalVar("SpawnedChildren") == 0 and oMobIndex ~= 0 then
        mob:setLocalVar("SpawnedChildren", 1)
        local zoneID = mob:getZoneID()
        local oMob = mob
        local eyes = mob:getLocalVar("eyeColor")
        if eyes ~= nil then
            mob:setAnimationSub(eyes)
        end
        if xi.dynamis.mobList[zoneID][oMobIndex].nmchildren ~= nil then
            for index, MobIndex in pairs(xi.dynamis.mobList[zoneID][oMobIndex].nmchildren) do
                if MobIndex == true or MobIndex == false then
                    index = index + 1
                else
                    local forceLink = xi.dynamis.mobList[zoneID][oMobIndex].nmchildren[1]
                    local mobType = xi.dynamis.mobList[zoneID][MobIndex].info[1]
                    if mobType == "NM" then -- NMs
                        xi.dynamis.nmDynamicSpawn(MobIndex, oMobIndex, forceLink, zoneID, target, oMob)
                        index = index + 1
                    else -- Nightmare Mobs and Statues
                        xi.dynamis.nonStandardDynamicSpawn(MobIndex, oMob, forceLink, zoneID, target, oMobIndex)
                        index = index + 1
                    end
                end
            end
        end
        if xi.dynamis.mobList[zoneID][oMobIndex].mobchildren ~= nil then
            xi.dynamis.normalDynamicSpawn(mob, oMobIndex, target) -- Normies have their own loop, so they don't need one here.
        end
    end
end

xi.dynamis.normalDynamicSpawn = function(oMob, oMobIndex, target)
    local mobFamily = oMob:getFamily()
    local mobZoneID = oMob:getZoneID()
    local zone = GetZone(mobZoneID)
    local normalMobLookup =
    {
        -- NOTE: To use default SpellList and SkillList set to nil.
        -- [Parent's Family]
        --{
            -- [ZoneID] -- If applicable
            --{
                -- [JobID] = { Name, groupId, groupZoneId, SpellList, SkillList },
            -- },
            -- [ZoneID] -- If applicable
            --{
                -- [FloorVar]
                -- {
                    -- [JobID] = { Name, groupId, groupZoneId, SpellList, SkillList },
                --  },
            -- },
            -- [JobID] = { Name, groupId, groupZoneId, SpellList, SkillList },
        -- },
        [4] = -- Vanguard Eye
        {
            [xi.zone.DYNAMIS_BEAUCEDINE] = -- Spawn Hydras (Done)
            {
                [1]  = { "H. Warrior",     159, 134, 0,    359, 1155, true }, -- HWAR
                [2]  = { "H. Monk",        160, 134, 0,    359, 1155, true }, -- HMNK
                [3]  = { "H. White Mage",  161, 134, 1,    359, 1155, true }, -- HWHM
                [4]  = { "H. Black Mage",  164, 134, 5000, 359, 1155, true }, -- HBLM
                [5]  = { "H. Red Mage",    162, 134, 3,    359, 1155, true }, -- HRDM
                [6]  = { "H. Thief",       165, 134, 0,    359, 1155, true }, -- HTHF
                [7]  = { "H. Paladin",     166, 134, 4,    359, 1155, true }, -- HPLD
                [8]  = { "H. Dark Knight", 167, 134, 5,    359, 1155, true }, -- HDRK
                [9]  = { "H. Beastmaster", 168, 134, 0,    359, 1155, true }, -- HBST
                [10] = { "H. Bard",        170, 134, 6,    359, 1155, true }, -- HBRD
                [11] = { "H. Ranger",      171, 134, 0,    359, 1155, true }, -- HRNG
                [12] = { "H. Samurai",     172, 134, 0,    359, 1155, true }, -- HSAM
                [13] = { "H. Ninja",       173, 134, 7,    359, 1155, true }, -- HNIN
                [14] = { "H. Dragoon",     174, 134, 0,    359, 1155, true }, -- HDRG
                [15] = { "H. Summoner",    176, 134, 0,    359, 1155, true }, -- HSMN
            },
            [xi.zone.DYNAMIS_XARCABARD] = -- Spawn Kindred (Done)
            {
                [1]  = { "K. Warrior",     32, 135, 0,    358, 131 }, -- KWAR
                [2]  = { "K. Monk",        33, 135, 0,    358, 131 }, -- KMNK
                [3]  = { "K. White Mage",  29, 135, 1,    358, 131 }, -- KWHM
                [4]  = { "K. Black Mage",  30, 135, 5000, 358, 131 }, -- KBLM
                [5]  = { "K. Red Mage",    31, 135, 3,    358, 131 }, -- KRDM
                [6]  = { "K. Thief",       34, 135, 0,    358, 131 }, -- KTHF
                [7]  = { "K. Paladin",     15, 135, 4,    358, 131 }, -- KPLD
                [8]  = { "K. Dark Knight", 16, 135, 5,    358, 131 }, -- KDRK
                [9]  = { "K. Beastmaster", 17, 135, 0,    358, 131 }, -- KBST
                [10] = { "K. Bard",        20, 135, 6,    358, 131 }, -- KBRD
                [11] = { "K. Ranger",      19, 135, 0,    358, 131 }, -- KRNG
                [12] = { "K. Samurai",     22, 135, 0,    358, 131 }, -- KSAM
                [13] = { "K. Ninja",       23, 135, 7,    358, 131 }, -- KNIN
                [14] = { "K. Dragoon",     27, 135, 0,    358, 131 }, -- KDRG
                [15] = { "K. Summoner",    24, 135, 0,    358, 131 }, -- KSMN
            },
            [xi.zone.DYNAMIS_TAVNAZIA] = -- Spawn Kindred and Hydra
            {
                [2] = -- Floor 2 Spawn Hydras (Done)
                {
                    [1]  = { "H. Warrior",     159, 134, 0,    359, 1155, true }, -- HWAR
                    [2]  = { "H. Monk",        160, 134, 0,    359, 1155, true }, -- HMNK
                    [3]  = { "H. White Mage",  161, 134, 1,    359, 1155, true }, -- HWHM
                    [4]  = { "H. Black Mage",  164, 134, 5000, 359, 1155, true }, -- HBLM
                    [5]  = { "H. Red Mage",    162, 134, 3,    359, 1155, true }, -- HRDM
                    [6]  = { "H. Thief",       165, 134, 0,    359, 1155, true }, -- HTHF
                    [7]  = { "H. Paladin",     166, 134, 4,    359, 1155, true }, -- HPLD
                    [8]  = { "H. Dark Knight", 167, 134, 5,    359, 1155, true }, -- HDRK
                    [9]  = { "H. Beastmaster", 168, 134, 0,    359, 1155, true }, -- HBST
                    [10] = { "H. Bard",        170, 134, 6,    359, 1155, true }, -- HBRD
                    [11] = { "H. Ranger",      171, 134, 0,    359, 1155, true }, -- HRNG
                    [12] = { "H. Samurai",     172, 134, 0,    359, 1155, true }, -- HSAM
                    [13] = { "H. Ninja",       173, 134, 7,    359, 1155, true }, -- HNIN
                    [14] = { "H. Dragoon",     174, 134, 0,    359, 1155, true }, -- HDRG
                    [15] = { "H. Summoner",    176, 134, 0,    359, 1155, true }, -- HSMN
                },
                [3] = -- Floor 3 Spawn Kindred (Done)
                {
                    [1]  = { "K. Warrior",     32, 135, 0,    358, 131 }, -- KWAR
                    [2]  = { "K. Monk",        33, 135, 0,    358, 131 }, -- KMNK
                    [3]  = { "K. White Mage",  29, 135, 1,    358, 131 }, -- KWHM
                    [4]  = { "K. Black Mage",  30, 135, 5000, 358, 131 }, -- KBLM
                    [5]  = { "K. Red Mage",    31, 135, 3,    358, 131 }, -- KRDM
                    [6]  = { "K. Thief",       34, 135, 0,    358, 131 }, -- KTHF
                    [7]  = { "K. Paladin",     15, 135, 4,    358, 131 }, -- KPLD
                    [8]  = { "K. Dark Knight", 16, 135, 5,    358, 131 }, -- KDRK
                    [9]  = { "K. Beastmaster", 17, 135, 0,    358, 131 }, -- KBST
                    [10] = { "K. Bard",        20, 135, 6,    358, 131 }, -- KBRD
                    [11] = { "K. Ranger",      19, 135, 0,    358, 131 }, -- KRNG
                    [12] = { "K. Samurai",     22, 135, 0,    358, 131 }, -- KSAM
                    [13] = { "K. Ninja",       23, 135, 7,    358, 131 }, -- KNIN
                    [14] = { "K. Dragoon",     27, 135, 0,    358, 131 }, -- KDRG
                    [15] = { "K. Summoner",    24, 135, 0,    358, 131 }, -- KSMN
                },
            },
        },
        [92] = -- Goblin Replica
        {
            [1]  = { "V. Smithy",      125, 134, 0,    327, 131 }, -- GWAR
            [2]  = { "V. Pitfighter",  126, 134, 0,    327, 131 }, -- GMNK
            [3]  = { "V. Alchemist",   141, 134, 1,    327, 131 }, -- GWHM
            [4]  = { "V. Shaman",      127, 134, 5000, 327, 131 }, -- GBLM
            [5]  = { "V. Enchanter",   128, 134, 3,    327, 131 }, -- GRDM
            [6]  = { "V. Welldigger",  132, 134, 0,    327, 131 }, -- GTHF
            [7]  = { "V. Armorer",     133, 134, 4,    327, 131 }, -- GPLD
            [8]  = { "V. Tinkerer",    147, 134, 5,    327, 131 }, -- GDRK
            [9]  = { "V. Pathfinder",  129, 134, 0,    327, 131 }, -- GBST
            [10] = { "V. Maestro",     131, 134, 6,    327, 131 }, -- GBRD
            [11] = { "V. Ambusher",    134, 134, 0,    327, 131 }, -- GRNG
            [12] = { "V. Ronin",       137, 134, 0,    327, 131 }, -- GSAM
            [13] = { "V. Hitman",      138, 134, 7,    327, 131 }, -- GNIN
            [14] = { "V. Dragontamer", 140, 134, 0,    327, 131 }, -- GDRG
            [15] = { "V. Necromancer", 135, 134, 0,    327, 131 }, -- GSMN
        },
        [93] = -- Orc Statue
        {
            [1]  = { "V. Footsoldier", 59, 134, 0,    334, 131 }, -- OWAR
            [2]  = { "V. Grappler",    64, 134, 0,    334, 131 }, -- OMNK
            [3]  = { "V. Amputator",   67, 134, 1,    334, 131 }, -- OWHM
            [4]  = { "V. Mesmerizer",  75, 134, 5000, 334, 131 }, -- OBLM
            [5]  = { "V. Vexer",       61, 134, 3,    334, 131 }, -- ORDM
            [6]  = { "V. Pillager",    78, 134, 0,    334, 131 }, -- OTHF
            [7]  = { "V. Trooper",     57, 134, 4,    334, 131 }, -- OPLD
            [8]  = { "V. Neckchopper", 58, 134, 5,    334, 131 }, -- ODRK
            [9]  = { "V. Hawker",      76, 134, 0,    334, 131 }, -- OBST
            [10] = { "V. Bugler",      81, 134, 6,    334, 131 }, -- OBRD
            [11] = { "V. Predator",    70, 134, 0,    334, 131 }, -- ORNG
            [12] = { "V. Gutslasher",  66, 134, 0,    334, 131 }, -- OSAM
            [13] = { "V. Backstabber", 62, 134, 7,    334, 131 }, -- ONIN
            [14] = { "V. Impaler",     69, 134, 0,    334, 131 }, -- ODRG
            [15] = { "V. Dollmaster",  72, 134, 0,    334, 131 }, -- OSMN
        },
        [94] = -- Quadav Statue (Done)
        {
            [1]  = { "V. Vindicator",  19, 134, 0,    337, 131 }, -- QWAR
            [2]  = { "V. Militant",    25, 134, 0,    337, 131 }, -- QMNK
            [3]  = { "V. Constable",   29, 134, 1,    337, 131 }, -- QWHM
            [4]  = { "V. Thaumaturge", 42, 134, 5000, 337, 131 }, -- QBLM
            [5]  = { "V. Protector",   20, 134, 3,    337, 131 }, -- QRDM
            [6]  = { "V. Purloiner",   33, 134, 0,    337, 131 }, -- QTHF
            [7]  = { "V. Defender",    30, 134, 4,    337, 131 }, -- QPLD
            [8]  = { "V. Vigilante",   38, 134, 5,    337, 131 }, -- QDRK
            [9]  = { "V. Beasttender", 21, 134, 0,    337, 131 }, -- QBST
            [10] = { "V. Minstrel",    23, 134, 6,    337, 131 }, -- QBRD
            [11] = { "V. Mason",       34, 134, 0,    337, 131 }, -- QRNG
            [12] = { "V. Hatamoto",    31, 134, 0,    337, 131 }, -- QSAM
            [13] = { "V. Kusa",        32, 134, 7,    337, 131 }, -- QNIN
            [14] = { "V. Drakekeeper", 26, 134, 0,    337, 131 }, -- QDRG
            [15] = { "V. Undertaker",  35, 134, 0,    337, 131 }, -- QSMN
        },
        [95] = -- Yagudo Statue
        {
            [1]  = { "V. Skirmisher", 93, 134, 0,     360, 131 }, -- YWAR
            [2]  = { "V. Sentinel",   91, 134, 0,     360, 131 }, -- YMNK
            [3]  = { "V. Priest",     101, 134, 1,    360, 131 }, -- YWHM
            [4]  = { "V. Prelate",    105, 134, 5000, 360, 131 }, -- YBLM
            [5]  = { "V. Visionary",  95, 134, 3,     360, 131 }, -- YRDM
            [6]  = { "V. Liberator",  96, 134, 0,     360, 131 }, -- YTHF
            [7]  = { "V. Exemplar",   98, 134, 4,     360, 131 }, -- YPLD
            [8]  = { "V. Inciter",    103, 134, 5,    360, 131 }, -- YDRK
            [9]  = { "V. Ogresoother",99, 134, 0,     360, 131 }, -- YBST
            [10] = { "V. Chanter",    104, 134, 6,    360, 131 }, -- YBRD
            [11] = { "V. Salvager",   111, 134, 0,    360, 131 }, -- YRNG
            [12] = { "V. Persecutor", 118, 134, 0,    360, 131 }, -- YSAM
            [13] = { "V. Assassin",   92, 134, 7,     360, 131 }, -- YNIN
            [14] = { "V. Partisan",   108, 134, 0,    360, 131 }, -- YDRG
            [15] = { "V. Oracle",     112, 134, 0,    360, 131 }, -- YSMN
        },
        [359] = -- Hydra NM
        {
            [1]  = { "H. Warrior",     159, 134, 0,    359, 1155, true }, -- HWAR
            [2]  = { "H. Monk",        160, 134, 0,    359, 1155, true }, -- HMNK
            [3]  = { "H. White Mage",  161, 134, 1,    359, 1155, true }, -- HWHM
            [4]  = { "H. Black Mage",  164, 134, 5000, 359, 1155, true }, -- HBLM
            [5]  = { "H. Red Mage",    162, 134, 3,    359, 1155, true }, -- HRDM
            [6]  = { "H. Thief",       165, 134, 0,    359, 1155, true }, -- HTHF
            [7]  = { "H. Paladin",     166, 134, 4,    359, 1155, true }, -- HPLD
            [8]  = { "H. Dark Knight", 167, 134, 5,    359, 1155, true }, -- HDRK
            [9]  = { "H. Beastmaster", 168, 134, 0,    359, 1155, true }, -- HBST
            [10] = { "H. Bard",        170, 134, 6,    359, 1155, true }, -- HBRD
            [11] = { "H. Ranger",      171, 134, 0,    359, 1155, true }, -- HRNG
            [12] = { "H. Samurai",     172, 134, 0,    359, 1155, true }, -- HSAM
            [13] = { "H. Ninja",       173, 134, 7,    359, 1155, true }, -- HNIN
            [14] = { "H. Dragoon",     174, 134, 0,    359, 1155, true }, -- HDRG
            [15] = { "H. Summoner",    176, 134, 0,    359, 1155, true }, -- HSMN
        },
        ["Drops"] =
        {
            [xi.zone.DYNAMIS_BASTOK] =
            {
                [337] = { 2558 }, -- Quadav,
            },
            [xi.zone.DYNAMIS_BEAUCEDINE] =
            {
                [337] = { 2557 }, -- Quadav
                [334] = { 2547 }, -- Orc
                [327] = { 2542 }, -- Goblin
                [360] = { 2552 }, -- Yagudo
                [359] = { 3220 }, -- Hydra
            },
            [xi.zone.DYNAMIS_BUBURIMU] =
            {
                [337] = { 2555 }, -- Quadav
                [334] = { 2545 }, -- Orc
                [327] = { 2540 }, -- Goblin
                [360] = { 2550 }, -- Yagudo
            },
            [xi.zone.DYNAMIS_JEUNO] =
            {
                [327] = { 2543 }, -- Goblin
            },
            [xi.zone.DYNAMIS_QUFIM] =
            {
                [337] = { 2556 }, -- Quadav
                [334] = { 2546 }, -- Orc
                [327] = { 2541 }, -- Goblin
                [360] = { 2551 }, -- Yagudo
            },
            [xi.zone.DYNAMIS_SAN_DORIA] =
            {
                [334] = { 2548 }, -- Orc
            },
            [xi.zone.DYNAMIS_TAVNAZIA] =
            {
                [359] = { 0 }, -- Hydra
                [358] = { 0 }, -- Kindred
            },
            [xi.zone.DYNAMIS_VALKURM] =
            {
                [337] = { 2554 }, -- Quadav
                [334] = { 2544 }, -- Orc
                [327] = { 2539 }, -- Goblin
                [360] = { 2549 }, -- Yagudo
            },
            [xi.zone.DYNAMIS_WINDURST] =
            {
                [360] = { 2553 }, -- Yagudo
            },
            [xi.zone.DYNAMIS_XARCABARD] =
            {
                [358] = { 1442 }, -- Kindred
            }
        }
    }

    for job, number in pairs(xi.dynamis.mobList[mobZoneID][oMobIndex].mobchildren) do
        local indexJob = 1
        local indexEndJob = number
        local nameObj = nil
        local spawnAnim = oMob ~= nil
        if oMob:getFamily() == 4 then
            if oMob:getLocalVar("Floor") == 2 or oMob:getLocalVar("Floor") == 3 then
                nameObj = normalMobLookup[mobFamily][mobZoneID][oMob:getLocalVar("Floor")]
            else
                nameObj = normalMobLookup[mobFamily][mobZoneID]
            end
        else
            nameObj = normalMobLookup[mobFamily]
        end

        if nameObj[job][7] then -- Skip special spawn animation
            spawnAnim = false
        end

        while (indexJob <= indexEndJob) and (nameObj ~= nil) do
            local mobArg = zone:insertDynamicEntity({
                objtype = xi.objType.MOB,
                name = nameObj[job][1],
                x = oMob:getXPos()+math.random()*6-3,
                y = oMob:getYPos()-0.3,
                z = oMob:getZPos()+math.random()*6-3,
                rotation = oMob:getRotPos(),
                groupId = nameObj[job][2],
                groupZoneId = nameObj[job][3],
                onMobSpawn = function(mobArg)
                    xi.dynamis.setMobStats(mobArg)
                    -- set all dyna mobs to same sublink so for example statues link when seeing normal mobs
                    mobArg:setMobMod(xi.mobMod.SUBLINK, xi.dynamis.SUBLINK_ID)
                end,
                onMobEngaged = function(mobArg, target) xi.dynamis.mobOnEngaged(mobArg, target) end,
                onMobRoam = function(mobArg) end,
                onMobDeath = function(mobArg, player, optParams)
                    xi.dynamis.mobOnDeath(mobArg)
                end,
                onMobDespawn = function (mob) xi.dynamis.mobOnDespawn(mob) end,
                releaseIdOnDisappear = true,
                spawnSet = 3,
                specialSpawnAnimation = spawnAnim,
                entityFlags = nameObj[job][6],
                mixins =
                {
                    require("scripts/mixins/job_special"),
                },
            })
            mobArg:setSpawn(oMob:getXPos()+math.random()*6-3, oMob:getYPos()-0.3, oMob:getZPos()+math.random()*6-3, oMob:getRotPos())
            mobArg:spawn()

            if mobArg:getFamily() == 359 then
                mobArg:timer(1600, function(mobArg)
                    mobArg:updateLook()
                end)
            end

            if normalMobLookup["Drops"][mobArg:getZoneID()][mobArg:getFamily()][1] ~= nil then
                mobArg:setDropID(normalMobLookup["Drops"][mobArg:getZoneID()][mobArg:getFamily()][1])
            end
            if nameObj[job][4] ~= nil then -- If SpellList ~= nil set SpellList
                mobArg:setSpellList(nameObj[job][4])
            end
            if nameObj[job][5] ~= nil then -- If SkillList ~= nil set SkillList
                mobArg:setMobMod(xi.mobMod.SKILL_LIST, nameObj[job][5])
            end
            if oMob ~= nil and oMob ~= 0 then
                mobArg:setLocalVar("Parent", oMob:getID())
                mobArg:updateEnmity(target)
            end
            indexJob = indexJob + 1 -- Increment to the next mob of the same job.
        end
        job = job + 1 -- Increment to the next job.
    end
end

xi.dynamis.nonStandardDynamicSpawn = function(mobIndex, oMob, forceLink, zoneID, target, oMobIndex)
    local mobMobType = xi.dynamis.mobList[zoneID][mobIndex].info[1]
    local mobName = xi.dynamis.mobList[zoneID][mobIndex].info[2]
    local xPos = 0
    local yPos = 0
    local zPos = 0
    local rPos = 0
    if xi.dynamis.mobList[zoneID][mobIndex].pos ~= nil then
        xPos = xi.dynamis.mobList[zoneID][mobIndex].pos[1]
        yPos = xi.dynamis.mobList[zoneID][mobIndex].pos[2]
        zPos = xi.dynamis.mobList[zoneID][mobIndex].pos[3]
        rPos = xi.dynamis.mobList[zoneID][mobIndex].pos[4]
    elseif oMob ~= nil then
        xPos = oMob:getXPos()+math.random()*6-3
        yPos = oMob:getYPos()-0.3
        zPos = oMob:getZPos()+math.random()*6-3
        rPos = oMob:getRotPos()
    end
    local zone = GetZone(zoneID)
    local nonStandardLookup =
    {
        ["Statue"] =
        {
            ["Vanguard Eye"] = { "Vanguard Eye" , 163, 134, 1144, 5000, 4 }, -- Vanguard Eye (VEye)
            ["Prototype Eye"] = { "Prototype Eye" , 61, 42, 1144, 5000, 4 }, -- Prototype Eye (PEye)
            ["Goblin Statue"] = { "Goblin Statue" , 158, 134, 1144, 1, 92 }, -- Goblin Statue (GStat)
            ["Goblin Replica"] = { "Goblin Replica" , 157, 134, 1144, 1, 92 }, -- Goblin Statue (GRStat)
            ["Statue Prototype"] = { "Stat. Prototype" , 36, 42, 1144, 1, 92 }, -- Goblin Statue (GPStat)
            ["Serjeant Tombstone"] = { "Serj. Tombstone" , 89, 134, 2201, 5000, 93 }, -- Orc Statue (OStat)
            ["Warchief Tombstone"] = { "War. Tombstone" , 90, 134, 2201, 5000, 93 }, -- Orc Statue (OWStat)
            ["Tombstone Prototype"] = { "Tomb. Prototype" , 20, 42, 2201, 5000, 93 }, -- Orc Statue (TPStat)
            ["Adamantking Effigy"] = { "Adamantking Eff" , 55, 134, 20, 0, 94 }, -- Quadav Statue (QStat)
            ["Adamantking Image"] = { "Adamantking Img" , 56, 134, 20, 0, 94 }, -- Quadav Statue (QIStat)
            ["Effigy Prototype"] = { "Eff. Prototype" , 9, 42, 20, 0, 94 }, -- Quadav Statue (QPStat)
            ["Avatar Idol"] = { "Avatar Idol" , 124, 134, 195, 5000, 95 }, -- Yagudo Statue (YStat)
            ["Manifest Icon"] = { "Manifest Icon" , 68, 39, 195, 5000, 95 }, -- Yagudo Statue (YMStat)
            ["Avatar Icon"] = { "Avatar Icon" , 123, 134, 195, 5000, 95 }, -- Yagudo Statue (AIStat)
            ["Icon Prototype"] = { "Icon Prototype" , 32, 42, 195, 5000, 95 }, -- Yagudo Statue (YPStat)
        },
        ["Nightmare"] =
        {
            ["Nightmare Bunny"] = { "N. Bunny" , 97, 40, 1789, 0, 206 }, -- NBun
            ["Nightmare Cockatrice"] = { "N. Cockatrice" , 19, 174, 1805, 0, 70 }, -- NCoc
            ["Nightmare Crab"] = { "N. Crab" , 93, 40, 1791, 0, 77 }, -- NCra
            ["Nightmare Crawler"] = { "N. Crawler" , 99, 40, 1798, 0, 79 }, -- Ncra
            ["Nightmare Dhalmel"] = { "N. Dhalmel" , 94, 40, 2796, 0, 80 }, -- NDha
            ["Nightmare Eft"] = { "N. Eft" , 101, 40, 2795, 0, 98 }, -- NEft
            ["Nightmare Mandragora"] = { "N. Mandragora" , 98, 40, 1789, 0, 178 }, -- NMan
            ["Nightmare Raven"] = { "N. Raven" , 100, 40, 1788, 0, 55 }, -- NRav
            ["Nightmare Scorpion"] = { "N. Scorpion" , 96, 40, 1787, 0, 217 }, -- NSco
            ["Nightmare Urganite"] = { "N. Urganite" , 95, 40, 1785, 0, 251 }, -- NUrg
            ["Nightmare Cluster"] = { "N. Cluster" , 130, 134, 0, 0, 68 }, -- NClu
            ["Nightmare Hornet"] = { "N. Hornet" , 130, 134, 0, 0, 48 }, -- NHor
            ["Nightmare Leech"] = { "N. Leech" , 130, 134, 0, 0, 172 }, -- NLee
            ["Nightmare Makara"] = { "N. Makara" , 130, 134, 0, 0, 197 }, -- NMak
            ["Nightmare Taurus"] = { "N. Taurus" , 130, 134, 0, 0, 240 }, -- NTau
            ["Nightmare Antlion"] = { "N. Antlion" , 130, 134, 0, 0, 26 }, -- NAnt
            ["Nightmare Bugard"] = { "N. Bugard" , 130, 134, 0, 0, 58 }, -- NBug
            ["Nightmare Worm"] = { "N. Worm" , 130, 134, 0, 0, 258 }, -- NWor
            ["Nightmare Hippogryph"] = { "N. Hippogryph" , 2, 39, 1792, 0, 141 }, -- NHip
            ["Nightmare Manticore"] = { "N. Manticore" , 3, 39, 1799, 0, 179 }, -- NMat
            ["Nightmare Sabotender"] = { "N. Sabotender" , 11, 39, 1792, 0, 212 }, -- NSab
            ["Nightmare Sheep"] = { "N. Sheep" , 13, 39, 1794, 0, 226 }, -- NShe
            ["Nightmare Fly"] = { "N. Fly" , 4, 39, 1794, 0, 113 }, -- NFly
            ["Nightmare Gaylas"] = { "N. Gaylas" , 80, 41, 1793, 0, 47 }, -- NGay
            ["Nightmare Kraken"] = { "N. Kraken" , 75, 41, 1793, 0, 218 }, -- NKra
            ["Nightmare Raptor"] = { "N. Raptor" , 84,41, 1793, 0, 210 }, -- NRap
            ["Nightmare Roc"] = { "N. Roc" , 83, 41, 1793, 0, 125 }, -- NRoc
            ["Nightmare Snoll"] = { "N. Snoll" , 86, 41, 1803, 0, 232 }, -- NSno
            ["Nightmare Diremite"] = { "N. Diremite" , 82, 41, 1790, 0, 81 }, -- NDir
            ["Nightmare Stirge"] = { "N. Stirge" , 78, 41, 1804, 0, 46 }, -- NSti
            ["Nightmare Tiger"] = { "N. Tiger" , 81, 41, 1804, 0, 242 }, -- NTig
            ["Nightmare Weapon"] = { "N. Weapon" , 77, 41, 1804, 0, 110 }, -- NWea
        },
        ["Elemental"] =
        {
            ["Fire Elemental"] = { "Fire Ele.", 14, 38, 0, 17, 0 }, -- FEle
            ["Water Elemental"] = { "Water Ele.", 17, 38, 0, 15, 0 }, -- WEle
            ["Thunder Elemental"] = { "Thunder Ele.", 18, 38, 0, 16, 0 }, -- TEle
            ["Earth Elemental"] = { "Earth Ele.", 13, 38, 0, 13, 0 }, -- EEle
            ["Air Elemental"] = { "Air Ele.", 11, 38, 0, 12, 0 }, -- AEle
            ["Ice Elemental"] = { "Ice Ele.", 15, 38, 0, 14, 0 }, -- IEle
            ["Light Elemental"] = { "Light Ele.", 16, 38, 0, 19, 0 }, -- LEle
            ["Dark Elemental"] = { "Dark Ele.", 12, 38, 0, 18, 0 }, -- DEle
        },
        ["Beastmen"] =
        {
            ["Vanguard Vindicator"] = { "V. Vindicator", 19, 134, 2558, 0, 337 }, -- QWAR (Bastok)
            ["Vanguard Constable"] = { "V. Constable", 29, 134, 2558,1, 337 }, -- QWHM (Bastok)
            ["Vanguard Militant"] = { "V. Militant", 25, 134, 2558, 0, 337 }, -- QMNK (Bastok)
        },
        ["Other"] =
        {
            ["Vanguard Dragon"] = { "V. Dragon", 70, 135, 2559, 0, 87 }, -- VDra
        },
    }
    -- superlinking is used to make sure dyna-xarc statue triplets with NMs will link
    -- this is required due to current navmesh and placement of child mobs
    local superlinkDynaXarcTable = {
        [127] = 1,
        [128] = 1,
        [129] = 1,
        [130] = 2,
        [131] = 2,
        [132] = 2,
        [133] = 3,
        [134] = 3,
        [135] = 3,
        [136] = 4,
        [137] = 4,
        [138] = 4,
        [139] = 5,
        [140] = 5,
        [141] = 5,
    }
    local mobFunctions =
    {
        ["Statue"] =
        {
            ["onMobSpawn"] = { function(mob)
                xi.dynamis.setStatueStats(mob, mobIndex)
                if zoneID == xi.zone.DYNAMIS_XARCABARD and superlinkDynaXarcTable[mobIndex] then
                    mob:setMobMod(xi.mobMod.SUPERLINK, superlinkDynaXarcTable[mobIndex])
                end
            end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob, target) xi.dynamis.statueOnFight(mob, target) end },
            ["onMobRoam"] = { function(mob) xi.dynamis.mobOnRoam(mob) end },
            ["mixins"] = {  }
        },
        ["Nightmare"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.setNightmareStats(mob) mob:setRoamFlags(xi.roamFlag.NONE) end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob) end },
            ["onMobRoam"] = { function(mob) end },
            ["mixins"] = {  }
        },
        ["Beastmen"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.setMobStats(mob) end },
            ["onMobEngaged"] = { function(mob, target) xi.dynamis.mobOnEngaged(mob, target) end },
            ["onMobFight"] = { function(mob) end },
            ["onMobRoam"] = { function(mob) end },
            ["mixins"] = {  require("scripts/mixins/job_special"), }
        },
        ["Elemental"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.setNightmareStats(mob) end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob) end },
            ["onMobRoam"] = { function(mob) end },
            ["mixins"] = {  }
        },
        ["Other"] =
        {
            ["onMobSpawn"] = { function(mob)
                xi.dynamis.setMobStats(mob)
                mob:addImmunity(xi.immunity.SLEEP)
            end },
            ["onMobEngaged"] = { function(mob, target) xi.dynamis.mobOnEngaged(mob, target) end },
            ["onMobFight"] = { function(mob) end },
            ["onMobRoam"] = { function(mob) end },
            ["mixins"] = {  }
        },
    }
    local dropLists =
    {
        [xi.zone.DYNAMIS_XARCABARD] =
        {
            [4]  = 6000, -- Eye
            [92] = 6000, -- Goblin
            [93] = 6001, -- Orc
            [94] = 6002, -- Quadav
            [95] = 6003, -- Yagudo
        },
        [xi.zone.DYNAMIS_BEAUCEDINE] =
        {
            [4]  = 6000, -- Eye
            [92] = 6000, -- Goblin
            [93] = 6001, -- Orc
            [94] = 6002, -- Quadav
            [95] = 6003, -- Yagudo
        },
    }

    local dropList = nonStandardLookup[mobMobType][mobName][4]

    local mob = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
        name = nonStandardLookup[mobMobType][mobName][1],
        x = xPos,
        y = yPos,
        z = zPos,
        rotation = rPos,
        groupId = nonStandardLookup[mobMobType][mobName][2],
        groupZoneId = nonStandardLookup[mobMobType][mobName][3],
        onMobSpawn = function(mob)
            local specFunc = mobFunctions[mobMobType]["onMobSpawn"][1]
            specFunc(mob)
            -- set all dyna mobs to same sublink so for example statues link when seeing normal mobs
            mob:setMobMod(xi.mobMod.SUBLINK, xi.dynamis.SUBLINK_ID)
        end,
        onMobEngaged = mobFunctions[mobMobType]["onMobEngaged"][1],
        onMobFight = mobFunctions[mobMobType]["onMobFight"][1],
        onMobRoam =  mobFunctions[mobMobType]["onMobRoam"][1],
        onMobDeath = function(mob, player, optParams)
            xi.dynamis.mobOnDeath(mob)
        end,
        onMobDespawn = function (mob) xi.dynamis.mobOnDespawn(mob) end,
        releaseIdOnDisappear = true,
        spawnSet = 3,
        specialSpawnAnimation = oMob ~= nil,
        mixins = mobFunctions[mobMobType]["mixins"],
    })
    mob:setSpawn(xPos, yPos, zPos, rPos)
    mob:spawn()
    mob:getZone():setLocalVar(string.format("MobIndex_%s", mob:getID()), mobIndex)
    mob:setLocalVar(string.format("MobIndex_%s", mob:getID()), mobIndex)

    if dropLists[zoneID] and dropLists[zoneID][mob:getFamily()] then
        dropList = dropLists[zoneID][mob:getFamily()]
    end

    mob:setDropID(dropList)

    if nonStandardLookup[mobMobType][mobName][5] ~= nil then -- If SpellList ~= nil set SpellList
        mob:setSpellList(nonStandardLookup[mobMobType][mobName][5])
    end

    if nonStandardLookup[mobMobType][mobName][6] ~= nil then -- If SkillList ~= nil set SkillList
        mob:setMobMod(xi.mobMod.SKILL_LIST, nonStandardLookup[mobMobType][mobName][6])
    end

    if xi.dynamis.mobList[zoneID][mobIndex].info[5] ~= nil then
        zone:setLocalVar(string.format("%s", xi.dynamis.mobList[zoneID][mobIndex].info[5]), 0)
        mob:setLocalVar("hasMobVar", 1)
    end

    if oMob ~= nil and oMob ~= 0 then
        mob:setLocalVar("Parent", oMob:getID())
        if forceLink == true then mob:updateEnmity(oMob:getTarget()) end
    end
end

xi.dynamis.nmDynamicSpawn = function(mobIndex, oMobIndex, forceLink, zoneID, target, oMob, mainDynaLord)
    local zone  = GetZone(zoneID)
    local xPos  = 0
    local yPos  = 0
    local zPos  = 0
    local rPos  = 0
    local flags = 0
    if mobIndex == nil then
        return
    end
    local mobName = xi.dynamis.mobList[zoneID][mobIndex].info[2]
    if xi.dynamis.mobList[zoneID][mobIndex].pos then
        xPos = xi.dynamis.mobList[zoneID][mobIndex].pos[1]
        yPos = xi.dynamis.mobList[zoneID][mobIndex].pos[2]
        zPos = xi.dynamis.mobList[zoneID][mobIndex].pos[3]
        rPos = xi.dynamis.mobList[zoneID][mobIndex].pos[4]
    else
        xPos = oMob:getXPos()+math.random()*6-3
        yPos = oMob:getYPos()-0.3
        zPos = oMob:getZPos()+math.random()*6-3
        rPos = oMob:getRotPos()
    end
    xi.dynamis.nmInfoLookup =
    {
        -- Below use used to lookup Beastmen NMs
        -- Goblin
        -- Dynamis - Beaucedine (Done)
        ["Ascetox Ratgums"] = { "A.Ratgums", 143, 134, 176, 5000, 5013, "Beastmen" }, -- Asce (BLM)
        ["Bordox Kittyback"] = { "B.Kittyback", 146, 134, 176, 0, 5013, "Beastmen" }, -- Bord (THF)
        ["Brewnix Bittypupils"] = { "B.Bittypupils", 142, 134, 176, 1, 5013, "Beastmen" }, -- Brew (WHM)
        ["Draklix Scalecrust"] = { "D.Scalecrust", 149, 134, 176, 0, 5013, "Beastmen" }, -- Drak (DRG)
        ["Droprix Granitepalms"] = { "D.Granitepalms", 139, 134, 176, 0, 5013, "Beastmen" }, -- Drop (MNK)
        ["Gibberox Pimplebeak"] = { "G.Pimplebeak", 144, 134, 176, 3, 5013, "Beastmen" }, -- Gibb (RDM)
        ["Moltenox Stubthumbs"] = { "M.Stubthunmbs", 136, 134, 176, 0, 5013, "Beastmen" }, -- Molt (WAR)
        ["Morblox Chubbychin"] = { "M.Chubbychin", 153, 134, 176, 0, 5013, "Beastmen" }, -- Morb (SMN)
        ["Routsix Rubbertendon"] = { "R.Rubbertendon", 151, 134, 176, 0, 5013, "Beastmen" }, -- Rout (BST)
        ["Ruffbix Jumbolobes"] = { "R.Jumolobes", 148, 134, 176, 4, 5013, "Beastmen" }, -- Ruff (PLD)
        ["Shisox Widebrow"] = { "S.Widebrow", 156, 134, 176, 0, 5013, "Beastmen" }, -- Shis (SAM)
        ["Slinkix Trufflesniff"] = { "S.Trufflesniff", 155, 134, 176, 0, 5013, "Beastmen" }, -- Slin (RNG)
        ["Swypestix Tigershins"] = { "S.Tigershins", 145, 134, 176, 7, 5013, "Beastmen" }, -- Swyp (NIN)
        ["Tocktix Thinlids"] = { "T.Thinlids", 150, 134, 176, 5, 5013, "Beastmen" }, -- Tock (DRK)
        ["Whistix Toadthroat"] = { "W.Toadthroat", 154, 134, 176, 6, 5013, "Beastmen" }, -- Whis (BRD)
        -- Dynamis - Buburimu (Done)
        ["Gosspix Blabberlips"] = { "G.Blabberlips", 24, 40, 2667, 3, 5013, "Beastmen" }, -- Goss (RDM)
        ["Shamblix Rottenheart"] = { "S.Rottenheart", 16, 40, 2667, 5, 5013, "Beastmen" }, -- Sham (DRK)
        ["Woodnix Shrillwhistle"] = { "W.Shrillwhistle", 6, 40, 2667, 0, 5013, "Beastmen" }, -- Wood (BST)
        -- Dynamis - Jeuno (Done)
        ["Bandrix Rockjaw"] = { "B.Rockjaw", 32, 188, 143, 0, 5013, "Beastmen" }, -- Band (THF)
        ["Buffrix Eargone"] = { "B.Eargone", 33, 188, 143, 4, 5013, "Beastmen" }, -- Buff (PLD)
        ["Cloktix Longnail"] = { "C.Longnail", 51, 188, 143, 5, 5013, "Beastmen" }, -- Cloc (DRK)
        ["Elixmix Hooknose"] = { "E.Hooknose", 31, 188, 143, 1, 5013, "Beastmen" }, -- Elix (WHM)
        ["Gabblox Magpietongue"] = { "G.Magpietongue", 11, 188, 143, 3, 5013, "Beastmen" }, -- Gabb (RDM)
        ["Hermitrix Toothrot"] = { "H.Toothrot", 27, 188, 143, 5000, 5013, "Beastmen" }, -- Herm (BLM)
        ["Humnox Drumbelly"] = { "H.Drumbelly", 34, 188, 143, 6, 5013, "Beastmen" }, -- Humn (BRD)
        ["Lurklox Dhalmelneck"] = { "L.Dhalmelneck", 36, 188, 143, 0, 5013, "Beastmen" }, -- Lurk (RNG)
        ["Morgmox Moldnoggin"] = { "M.Moldnoggin", 29, 188, 143, 0, 5013, "Beastmen" }, -- Morg (SMN)
        ["Sparkspox Sweatbrow"] = { "S.Sweatbrow", 30, 188, 143, 0, 5013, "Beastmen" }, -- Spar (WAR)
        ["Ticktox Beadyeyes"] = { "T.Beadyeyes", 35, 188, 143, 5, 5013, "Beastmen" }, -- Tick (DRK)
        ["Trailblix Goatmug"] = { "T.Goatmug", 37, 188, 143, 0, 5013, "Beastmen" }, -- Trai (BST)
        ["Tufflix Loglimbs"] = { "T.Loglimbs", 21, 188, 143, 4, 5013, "Beastmen" }, -- Tuff (PLD)
        ["Wyrmwix Snakespecs"] = { "W.Snakespecs", 28, 188, 143, 0, 5013, "Beastmen" }, -- Snak (DRG)
        ["Karashix Swollenskull"] = { "K.Swollenskull", 39, 188, 143, 0, 5013, "Beastmen" }, -- Kara (SAM)
        ["Kikklix Longlegs"] = { "K.Longlegs", 38, 188, 143, 0, 5013, "Beastmen" }, -- Kikk (MNK)
        ["Rutrix Hamgams"] = { "R.Hamgams", 40, 188, 143, 0, 5013, "Beastmen" }, -- Rutr (BST)
        ["Snypestix Eaglebeak"] = { "S.Eaglebeak", 41, 188, 143, 7, 5013, "Beastmen" }, -- Snyp (NIN)
        ["Mortilox Wartpaws"] = { "M.Wartpaws", 52, 188, 143, 0, 5013, "Beastmen" }, -- Mort (SMN)
        ["Jabkix Pigeonpecs"] = { "J.Pigeonpecs", 24, 188, 143, 0, 5013, "Beastmen" }, -- Jabk (MNK)
        ["Smeltix Thickhide"] = { "S.Thickhide", 23, 188, 143, 0, 5013, "Beastmen" }, -- Smel (WAR)
        ["Wasabix Callusdigit"] = { "W.Callusdigit", 25, 188, 143, 0, 5013, "Beastmen" }, -- Wasa (SAM)
        ["Anvilix Sootwrists"] = { "A.Sootwrists", 42, 188, 143, 0, 5013, "Beastmen" }, -- Anvi (WAR)
        ["Blazox Boneybod"] = { "B.Boneybod", 49, 188, 143, 0, 5013, "Beastmen" }, -- Blaz (BST)
        ["Bootrix Jaggedelbow"] = { "B.Jaggedelbow", 43, 188, 143, 0, 5013, "Beastmen" }, -- Boot (MNK)
        ["Distilix Stickytoes"] = { "D.Stickytoes", 45, 188, 143, 1, 5013, "Beastmen" }, -- Dist (WHM)
        ["Eremix Snottynostril"] = { "E.Snottynostril", 46, 188, 143, 5000, 5013, "Beastmen" }, -- Erem (BLM)
        ["Jabbrox Grannyguise"] = { "J.Grannyguise", 47, 188, 143, 3, 5013, "Beastmen" }, -- Jabb (RDM)
        ["Mobpix Mucousmouth"] = { "M.Mucousmouth", 44, 188, 143, 0, 5013, "Beastmen" }, -- Mobp (THF)
        ["Prowlox Barrelbelly"] = { "P.Barrelbelly", 50, 188, 143, 0, 5013, "Beastmen" }, -- Prow (RNG)
        ["Scruffix Shaggychest"] = { "S.Shaggychest", 48, 188, 143, 4, 5013, "Beastmen" }, -- Scru (PLD)
        ["Slystix Megapeepers"] = { "S.Megapeepers", 53, 188, 143, 7, 5013, "Beastmen" }, -- Slys (NIN)
        ["Tymexox Ninefingers"] = { "T.Ninefingers", 54, 188, 143, 5, 5013, "Beastmen" }, -- Tyme (DRK)
        -- Orc
        -- Dynamis - Beaucedine (Done)
        ["Cobraclaw Buchzvotch"] = { "C.Buchzvotch", 65, 134, 493, 0, 5012, "Beastmen" }, -- CBuc (MNK)
        ["Deathcaller Bidfbid"] = { "D.Bidfbid", 73, 134, 493, 0, 5012, "Beastmen" }, -- DBid (SMN)
        ["Drakefeast Wubmfub"] = { "D.Wubmfub", 88, 134, 493, 0, 5012, "Beastmen" }, -- DWub (DRG)
        ["Elvaanlopper Grokdok"] = { "E.Grokdok", 82, 134, 493, 0, 5012, "Beastmen" }, -- EGro (RNG)
        ["Galkarider Retzpratz"] = { "G.Retzpratz", 71, 134, 493, 0, 5012, "Beastmen" }, -- GRet (RNG)
        ["Heavymail Djidzbad"] = { "H.Djidzbad", 80, 134, 493, 4, 5012, "Beastmen" }, -- HDji (PLD)
        ["Humegutter Adzjbadj"] = { "H.Adzjbadj", 60, 134, 493, 0, 5012, "Beastmen" }, -- HAbz (WAR)
        ["Jeunoraider Gepkzip"] = { "J.Gepkzip", 63, 134, 493, 7, 5012, "Beastmen" }, -- JGep (NIN)
        ["Lockbuster Zapdjipp"] = { "L.Zapdjipp", 79, 134, 493, 0, 5012, "Beastmen" }, -- LZap (THF)
        ["Mithraslaver Debhabob"] = { "M.Debhabob", 85, 134, 493, 0, 5012, "Beastmen" }, -- MDeb (BST)
        ["Skinmask Ugghfogg"] = { "S.Ugghfogg", 83, 134, 493, 5, 5012, "Beastmen" }, -- SUgg (DRK)
        ["Spinalsucker Galflmall"] = { "S.Galflmall", 73, 134, 493, 3, 5012, "Beastmen" }, -- SGal (RDM)
        ["Taruroaster Biggsjig"] = { "T.Biggsjig", 84, 134, 493, 5000, 5012, "Beastmen" }, -- TBig (BLM)
        ["Ultrasonic Zeknajak"] = { "U.Zeknajak", 87, 134, 493, 6, 5012, "Beastmen" }, -- UZek (BRD)
        ["Wraithdancer Gidbnod"] = { "W.Gidbnod", 63, 134, 493, 1, 5012, "Beastmen" }, -- WGid (WHM)
        -- Dynamis Buburimu (Done)
        ["Elvaansticker Bxafraff"] = { "E.Bxafraff", 35, 40, 760, 0, 5012, "Beastmen" }, -- Elva (DRG)
        ["Flamecaller Zoeqdoq"] = { "F.Zoeqdoq", 34, 40, 760, 5000, 5012, "Beastmen" }, -- Flam (BLM)
        ["Hamfist Gukhbuk"] = { "H.Gukhbuk", 46, 40, 760, 0, 5012, "Beastmen" }, -- Hamf (MNK)
        ["Lyncean Juwgneg"] = { "L.Juvgneg", 47, 40, 760, 0, 5012, "Beastmen" }, -- Lync (RNG)
        -- Dynamis - San d'Oria (Done)
        ["Wyrmgnasher Bjakdek"] = { "W.Bjakdek", 25, 185, 3111, 0, 5012, "Beastmen" }, -- WyrB (DRG)
        ["Reapertongue Gadgquok"] = { "R.Gadgquok", 23, 185, 3111, 0, 5012, "Beastmen" }, -- ReaG (SMN)
        ["Voidstreaker Butchnotch"] = { "V.Butchnotch", 26, 185, 3111, 7, 5012, "Beastmen" }, -- VoiB (NIN)
        ["Battlechoir Gitchfotch"] = { "B.Gitchfotch", 2, 185, 3111, 6, 5012, "Beastmen" }, -- BatG (BRD)
        ["Soulsender Fugbrag"] = { "S.Fugbrag", 3, 185, 3111, 6, 5012, "Beastmen" }, -- SouF (BRD)
        -- Quadav
        -- Dynamis - Beaucedine (Done)
        ["Be'Zhe Keeprazer"] = { "B.Keeprazer", 53, 134, 261, 0, 5011, "Beastmen" }, -- BeZh (SMN)
        ["De'Bho Pyrohand"] = { "D.Pyrohand", 43, 134, 261, 5000, 5011, "Beastmen" }, --DeBh (BLM)
        ["Ga'Fho Venomtouch"] = { "G.Venomtouch", 39, 134, 261, 3, 5011, "Beastmen" }, -- GaFh (WHM)
        ["Go'Tyo Magenapper"] = { "G.Magenapper", 44, 134, 261, 0, 5011, "Beastmen" }, -- GoTy (DRG)
        ["Gu'Khu Dukesniper"] = { "G.Dukesniper", 50, 134, 261, 0, 5011, "Beastmen" }, -- GuKh (RNG)
        ["Gu'Nha Wallstormer"] = { "G.Wallstormer", 24, 134, 261, 0, 5011, "Beastmen" }, -- Guha (WAR)
        ["Ji'Fhu Infiltrator"] = { "J.Infiltrator", 37, 134, 261, 0, 5011, "Beastmen" }, -- JiFh (THF)
        ["Ji'Khu Towercleaver"] = { "J.Towercleaver", 51, 134, 261, 0, 5011, "Beastmen" }, -- JiKh (SAM)
        ["Mi'Rhe Whisperblade"] = { "M.Whisperblade", 52, 134, 261, 7, 5011, "Beastmen" }, -- MiRh (NIN)
        ["Mu'Gha Legionkiller"] = { "M.Legionkiller", 47, 134, 261, 4, 5011, "Beastmen" }, -- MuGh (PLD)
        ["Na'Hya Floodmaker"] = { "N.Floodmaker", 28, 134, 261, 3, 5011, "Beastmen" }, -- NaHy (RDM)
        ["Nu'Bhi Spiraleye"] = { "N.Spiraleye", 41, 134, 261, 6, 5011, "Beastmen" }, -- NuBh (BRD)
        ["So'Gho Adderhandler"] = { "S.Adderhandler", 48, 134, 261, 0, 5011, "Beastmen" }, -- SoGh (BST)
        ["So'Zho Metalbender"] = { "S.Metalbender", 46, 134, 261, 0, 5011, "Beastmen" }, -- SoZh (MNK)
        ["Ta'Hyu Gallanthunter"] = { "T.Gallanthunter", 40, 134, 261, 5, 5011, "Beastmen" }, -- TaHy (DRK)
        -- Dynamis Buburimu (Done)
        ["Gi'Bhe Flesheater"] = { "G.Flesheater", 57, 40, 2901, 1, 5011, "Beastmen" }, -- GiBh (WHM)
        ["Qu'Pho Bloodspiller"] = { "Q.Bloodspiller", 56, 40, 2901, 0, 5011, "Beastmen" }, -- QuPh (WAR)
        ["Te'Zha Ironclad"] = { "T.Ironclad", 69, 40, 2901, 4, 5011, "Beastmen" }, -- TeZh (PLD)
        ["Va'Rhu Bodysnatcher"] = { "V.Bodysnatcher", 68, 40, 2901, 0, 5011, "Beastmen" }, -- VaRh (THF)
        -- Dynamis - Bastok (Done)
        ["Aa'Nyu Dismantler"] = { "A.Dismantler", 40, 134, 2907, 5, 5011, "Beastmen" }, -- AaNy (DRK)
        ["Gu'Nhi Noondozer"] = { "G.Noondozer", 53, 134, 2907, 0, 5011, "Beastmen" }, -- GuNh (SMN)
        ["Be'Ebo Tortoisedriver"] = { "B.Tortoisedriver", 48, 134, 2907, 0, 5011, "Beastmen" }, -- BeEb (BST)
        ["Gi'Pha Manameister"] = { "G.Manameister", 43, 134, 2907, 5000, 5011, "Beastmen" }, -- GiPh (BLM)
        ["Ko'Dho Cannonball"] = { "K.Cannonball", 46, 134, 2907, 0, 5011, "Beastmen" }, -- KoDh (MNK)
        ["Ze'Vho Fallsplitter"] = { "Z.Fallsplitter", 40, 134, 2907, 5, 5011, "Beastmen" }, -- ZeVh (DRK)
        ["Effigy Shield PLD"] = { "Effigy Shield", 30, 134, 2907, 4, 5011, "Beastmen" }, -- EPLD (PLD)
        ["Effigy Shield NIN"] = { "Effigy Shield", 32, 134, 2907, 7, 5011, "Beastmen" }, -- ENIN (NIN)
        ["Effigy Shield BRD"] = { "Effigy Shield", 23, 134, 2907, 6, 5011, "Beastmen" }, -- EBRD (BRD)
        ["Effigy Shield DRK"] = { "Effigy Shield", 38, 134, 2907, 5, 5011, "Beastmen" }, -- EDRK (DRK)
        ["Effigy Shield SAM"] = { "Effigy Shield", 31, 134, 2907, 0, 5011, "Beastmen" }, -- ESAM (SAM)
        -- Yagudo
        -- Dynamis - Beaucedine (Done)
        ["Bhuu Wjato the Firepool"] = { "B.Firepool", 106, 134, 265, 5000, 5014, "Beastmen" }, -- Bhuu (BLM)
        ["Caa Xaza the Madpiercer"] = { "C.Madpiercer", 107, 134, 265, 3, 5014, "Beastmen" }, -- CaaX (RDM)
        ["Foo Peku the Bloodcloak"] = { "F.Bloodcloak", 94, 134, 265, 0, 5014, "Beastmen" }, -- FooP (WAR)
        ["Guu Waji the Preacher"] = { "G.Preacher", 113, 134, 265, 4, 5014, "Beastmen" }, -- GuuW (PLD)
        ["Hee Mida the Meticulous"] = { "H.Meticulous", 120, 134, 265, 0, 5014, "Beastmen" }, -- HeeM (RNG)
        ["Knii Hoqo the Bisector"] = { "K.Bisector", 121, 134, 265, 0, 5014, "Beastmen" }, -- Knii (SAM)
        ["Koo Saxu the Everfast"] = { "K.Everfast", 102, 134, 265, 1, 5014, "Beastmen" }, -- KooS (WHM)
        ["Kuu Xuka the Nimble"] = { "K.Nimble", 115, 134, 265, 7, 5014, "Beastmen" }, -- KuuX (NIN)
        ["Maa Zaua the Wyrmkeeper"] = { "M.Wyrmkeeper", 109, 134, 265, 0, 5014, "Beastmen" }, -- MaaZ (DRG)
        ["Nee Huxa the Judgemental"] = { "N.Judgemental", 114, 134, 265, 5, 5014, "Beastmen" }, -- NeeH (DRK)
        ["Puu Timu the Phantasmal"] = { "P.Phantasmal", 122, 134, 265, 0, 5014, "Beastmen" }, -- PuuT (SMN)
        ["Ryy Qihi the Idolrobber"] = { "R.Idolrobber", 110, 134, 265, 0, 5014, "Beastmen" }, -- RyyQ (THF)
        ["Soo Jopo the Fiendking"] = { "S.Fiendking", 116, 134, 265, 0, 5014, "Beastmen" }, -- SooJ (BST)
        ["Xaa Chau the Roctalon"] = { "X.Roctalon", 97, 134, 265, 0, 5014, "Beastmen" }, -- XaaC (MNK)
        ["Xhoo Fuza the Sublime"] = { "X.Sublime", 119, 134, 265, 6, 5014, "Beastmen" }, -- Xhoo (BRD)
        -- Dynamis - Buburimu (Done)
        ["Baa Dava the Bibliopage"] = { "B.Bibliopage", 24, 187, 2085, 0, 5014, "Beastmen" }, -- BaaD (SMN)
        ["Doo Peku the Fleetfoot"] = { "D.Fleetfoot", 115, 134, 2085, 7, 5014, "Beastmen" }, -- DooP (NIN)
        ["Koo Rahi the Levinblade"] = { "K.Levinblade", 121, 134, 2085, 0, 5014, "Beastmen" }, -- KooR (SAM)
        ["Ree Nata the Melomanic"] = { "R.Melomanic", 119, 134, 2085, 6, 5014, "Beastmen" }, -- ReeN (BRD)
        -- Dynamis - Windurst (Done)
        ["Xoo Kaza the Solemn"] = { "X.Solemn", 27, 187, 1560, 5000, 5014, "Beastmen" }, -- XooK (BLM)
        ["Haa Pevi the Stentorian"] = { "H.Stentorian", 24, 187, 1560, 0, 5014, "Beastmen" }, -- HaaP (SMN)
        ["Wuu Qoho the Razorclaw"] = { "W.Razorclaw", 26, 187, 1560, 0, 5014, "Beastmen" }, -- WuuQ (MNK)
        ["Loo Hepe the Eyepiercer"] = { "L.Eyepiercer", 25, 187, 1560, 3, 5014, "Beastmen" }, -- LooH (RDM)
        ["Muu Febi the Steadfast"] = { "Muu.Steadfast", 3, 187, 1560, 4, 5014, "Beastmen" }, -- MuuF (PLD)
        ["Maa Febi the Steadfast"] = { "Maa.Steadfast", 2, 187, 1560, 4, 5014, "Beastmen" }, -- MaaF (PLD)
        -- Kindred
        -- Dynamis - Xarcabard (Done)
        ["Count Zaebos"] = { "C.Zaebos", 51, 135, 521, 0, 358, "XarcNM" }, -- Zaeb (WAR)
        ["Duke Berith"] = { "D.Berith", 47, 135, 714, 3, 358, "XarcNM" }, -- Beri (RDM)
        ["Marquis Decarabia"] = { "M.Decarabia", 21, 135, 1626, 6, 358, "XarcNM" }, -- Deca (BRD)
        ["Duke Gomory"] = { "D.Gomory", 39, 135, 715, 0, 358, "XarcNM" }, -- Gomo (MNK)
        ["Marquis Andras"] = { "M.Andras", 54, 135, 1624, 0, 358, "XarcNM" }, -- Andr (BST)
        ["Prince Seere"] = { "P.Seere", 43, 135, 2021, 1, 358, "XarcNM" }, -- Seer (WHM)
        ["Duke Scox"] = { "D.Scox", 57, 135, 717, 5, 358, "XarcNM" }, -- Scox (DRK)
        ["Marquis Gamygyn"] = { "M.Gamygyn", 65, 135, 1628, 7, 358, "XarcNM" }, -- Gamy (NIN)
        ["Marquis Orias"] = { "M.Orias", 46, 135, 1630, 5000, 358, "XarcNM" }, -- Oria (BLM)
        ["Count Raum"] = { "C.Raum", 42, 135, 519, 0, 358, "XarcNM" }, --  Raum (THF)
        ["Marquis Nebiros"] = { "M.Nebiros", 67, 135, 1629, 0, 358, "XarcNM" }, -- Nebi (SMN)
        ["Marquis Sabnak"] = { "M.Sabnak", 49, 135, 1631, 4, 358, "XarcNM" }, -- Sabn (PLD)
        ["Count Vine"] = { "C.Vine", 62, 135, 520, 0, 358, "XarcNM" }, -- Vine (SAM)
        ["King Zagan"] = { "K.Zagan", 60, 135, 1452, 0, 358, "XarcNM" }, -- Zaga (DRG)
        ["Marquis Cimeries"] = { "M.Cimeries", 56, 135, 1625, 0, 358, "XarcNM" }, -- Cime (RNG)
        -- Hydra
        -- Dynamis - Beaucedine (Done)
        ["Dagourmarche"] = { "Dagourmarche", 10, 134, 559, 0, 359, "Dagourmarche" }, -- Dago (DRG/BST/SMN)
        ["Goublefaupe"] = { "Goublefaupe", 6, 134, 1211, 5001, 359, "Goublefaupe" }, -- Goub (WAR/PLD/RDM)
        ["Mildaunegeux"] = { "Mildaunegeux", 8, 134, 1672, 7, 359, "Mildaunegeux" }, -- Mild (MNK/THF/NIN)
        ["Quiebitiel"] = { "Quiebitiel", 7, 134, 2066, 5002, 359, "Quiebitiel" }, -- Quie (WHM/BLM/BRD)
        ["Velosareon"] = { "Velosareon", 9, 134, 2574, 5, 359, "Velosareon" }, -- Velo (RNG/SAM/DRK)
        -- Below is used to lookup non-beastmen NMs.
        -- Dynamis - Bastok (Done)
        ["Gu'Dha Effigy"] = { "Gu'Dha Effigy", 1, 186, 2906, 0, 94, "Statue Megaboss" }, -- BMb (Bastok Megaboss)
        -- Dynamis - Jeuno (Done)
        ["Goblin Golem"] = { "Goblin Golem", 1, 188, 1085, 47, 92, "Statue Megaboss" }, -- JMb
        -- Dynamis - San d'Oria (Done)
        ["Overlord's Tombstone"] = { "O. Tombstone", 1, 185, 1967, 49, 93, "Statue Megaboss" }, -- SMb
        -- Dynamis - Windurst (Done)
        ["Tzee Xicu Manifest"] = { "Tzee Xicu Mani.", 1, 187, 2510, 50, 95, "Statue Megaboss" }, -- WMb
        -- Dynamis - Xarcabard Non-Beastmen (Done)
        ["Animated Hammer"] = { "A.Hammer", 81, 135, 0, 0, 9, "Animated Weapon" }, -- AHam
        ["Animated Staff"] = { "A.Staff", 87, 135, 0, 0, 23, "Animated Weapon" }, -- ASta
        ["Animated Longsword"] = { "A.Longsword", 84, 135, 0, 0, 24, "Animated Weapon" }, -- ALon
        ["Animated Tabar"] = { "A.Tabar", 88, 135, 0, 0, 8, "Animated Weapon" }, -- ATab
        ["Animated Great Axe"] = { "A.Great Axe", 80, 135, 0, 0, 12, "Animated Weapon" }, -- AGre
        ["Animated Claymore"] = { "A.Claymore", 78, 135, 0, 0, 14, "Animated Weapon" }, -- ACla
        ["Animated Spear"] = { "A.Spear", 86, 135, 0, 0, 19, "Animated Weapon" }, -- ASpe
        ["Animated Scythe"] = { "A.Scythe", 85, 135, 0, 0, 20, "Animated Weapon" }, -- AScy
        ["Animated Kunai"] = { "A.Kunai", 83, 135, 0, 0, 17, "Animated Weapon" }, -- AKun
        ["Animated Tachi"] = { "A.Tachi", 89, 135, 0, 0, 13, "Animated Weapon" }, -- ATac
        ["Animated Dagger"] = { "A.Dagger", 79, 135, 0, 0, 11, "Animated Weapon" }, -- ADag
        ["Animated Knuckles"] = { "A.Knuckles", 82, 135, 0, 0,15, "Animated Weapon" }, -- AKnu
        ["Animated Longbow"] = { "A.Longbow", 11, 135, 0, 0, 7, "Animated Weapon" }, -- Alon
        ["Animated Gun"] = { "A.Gun", 12, 135, 0, 0, 18, "Animated Weapon" }, -- AGun
        ["Animated Horn"] = { "A.Horn", 13, 135, 0, 0, 16, "Animated Weapon" }, -- AHor
        ["Animated Shield"] = { "A.Shield", 14, 135, 0, 0, 21, "Animated Weapon" }, -- AShi
        ["Satellite Hammer"] = { "S.Hammer", 81, 135, 0, 0, 9, "Satellite Weapon", 5251 }, -- SHam
        ["Satellite Staff"] = { "S.Staff", 87, 135, 0, 0, 23, "Satellite Weapon", 5251 }, -- SSta
        ["Satellite Longsword"] = { "S.Longsword", 84, 135, 0, 0, 24, "Satellite Weapon", 5763 }, -- SLon
        ["Satellite Tabar"] = { "S.Tabar", 88, 135, 0, 0, 8, "Satellite Weapon", 5251 }, -- STab
        ["Satellite Great Axe"] = { "S.Great Axe", 80, 135, 0, 0, 12, "Satellite Weapon", 5763 }, -- SGre
        ["Satellite Claymore"] = { "S.Claymore", 78, 135, 0, 0, 14, "Satellite Weapon", 5763 }, -- SCla
        ["Satellite Spear"] = { "S.Spear", 86, 135, 0, 0, 19, "Satellite Weapon", 5251 }, -- SSpe
        ["Satellite Scythe"] = { "S.Scythe", 85, 135, 0, 0, 20, "Satellite Weapon", 5763 }, -- SScy
        ["Satellite Kunai"] = { "S.Kunai", 83, 135, 0, 0, 17, "Satellite Weapon", 5251 }, -- SKun
        ["Satellite Tachi"] = { "S.Tachi", 89, 135, 0, 0, 13, "Satellite Weapon", 5251 }, -- STac
        ["Satellite Dagger"] = { "S.Dagger", 79, 135, 0, 0, 11, "Satellite Weapon", 5763 }, -- SDag
        ["Satellite Knuckles"] = { "S.Knuckles", 82, 135, 0, 0, 15, "Satellite Weapon", 5251 }, -- SKnu
        ["Satellite Longbow"] = { "S.Longbow", 11, 135, 0, 0, 7, "Satellite Weapon", 5251 }, -- Slon
        ["Satellite Gun"] = { "S.Gun", 12, 135, 0, 0, 18, "Satellite Weapon", 5251 }, -- SGun
        ["Satellite Horn"] = { "S.Horn", 13, 135, 0, 0, 16, "Satellite Weapon", 5763 }, -- SHor
        ["Satellite Shield"] = { "S.Shield", 14, 135, 0, 0, 21, "Satellite Weapon", 5251 }, -- SShi
        ["Ying"] = { "Ying", 2, 135, 0, 0, 87, "Ying", 159 }, -- Ying
        ["Yang"] = { "Yang", 3, 135, 0, 0, 87, "Yang", 159 }, -- Yang
        ["Dynamis Lord"] = { "Dynamis Lord", 1, 135, 730, 86, 361, "Dynamis Lord", 135 }, -- DL
        -- Dynamis - Beaucedine Non-Beastmen (Done)
        ["Angra Mainyu"] = { "Angra Mainyu", 1, 134, 3207, 5000, 4, "Angra Mainyu" }, -- Angr
        ["Fire Pukis"] = { "Fire Pukis", 2, 135, 0, 0, 87, "Pukis" }, -- FPuk
        ["Wind Pukis"] = { "Wind Pukis", 2, 135, 0, 0, 87, "Pukis" }, -- WPuk
        ["Petro Pukis"] = { "Petro Pukis", 2, 135, 0, 0, 87, "Pukis" }, -- PPuk
        ["Poison Pukis"] = { "Poison Pukis", 2, 135, 0, 0, 87, "Pukis" }, -- pPuk
        ["Dynamis Statue"] = { "D. Statue" , 199, 134, 1144, 1, 92, "Enabled Auto Attack" }, -- Dynamis Statue (DynS)
        ["Dynamis Tombstone"] = { "D. Tombstone" , 201, 134, 2201, 5000, 93, "Enabled Auto Attack" }, -- Dynamis Tombstone (DynT)
        ["Dynamis Effigy"] = { "D. Effigy" , 200, 134, 20, 0, 94, "Enabled Auto Attack" }, -- Dynamis Effigy (DynE)
        ["Dynamis Icon"] = { "D. Icon" , 198, 134, 195, 5000, 95, "Enabled Auto Attack" }, -- Dynamis Icon (DynI)
        -- Dynamis - Buburimu Non-Beastmen (Done)
        ["Aitvaras"] = { "Aitvaras", 105, 40, 230, 0, 5008, "Buburimu Dwagon" }, -- Aitv
        ["Alklha"] = { "Alklha", 105, 40, 230, 0, 5006, "Buburimu Dwagon" }, -- Alkl
        ["Barong"] = { "Barong", 105, 40, 230, 0, 5004, "Buburimu Dwagon" }, -- Baro
        ["Basilic"] = { "Basilic", 105, 40, 230, 0, 5007, "Buburimu Dwagon" }, -- Basi
        ["Jurik"] = { "Jurik", 105, 40, 230, 0, 5003, "Buburimu Dwagon" }, -- Juri
        ["Koschei"] = { "Koschei", 105, 40, 230, 0, 5009, "Buburimu Dwagon" }, -- Kosc
        ["Stihi"] = { "Stihi", 105, 40, 230, 0, 5001, "Buburimu Dwagon" }, -- Stih
        ["Stollenwurm"] = { "Stollenwurm", 105, 40, 230, 0, 5010, "Buburimu Dwagon" }, -- Stol
        ["Tarasca"] = { "Tarasca", 105, 40, 230, 0, 5005, "Buburimu Dwagon" }, -- Tara
        ["Vishap"] = { "Vishap", 105, 40, 230, 0, 5002, "Buburimu Dwagon" }, -- Vish
        ["Apocalyptic Beast"] = { "Apoc. Beast", 1, 40, 146, 0, 0, "Apocalyptic Beast" }, -- Apoc
        -- Dynamis - Valkurm (Done)
        ["Dragontrap_1"] = { "Dragontrap", 63, 77, 2910, 0, 114, "No Auto Attack" }, -- Drat
        ["Dragontrap_2"] = { "Dragontrap", 63, 77, 2910, 0, 114, "No Auto Attack" }, -- Drat
        ["Dragontrap_3"] = { "Dragontrap", 63, 77, 2910, 0, 114, "No Auto Attack" }, -- Drat
        ["Fairy Ring"] = { "Fairy Ring", 10, 39, 2910, 0, 116, "Fairy Ring" }, -- FaiR
        ["Nant'ina"] = { "Nant'ina", 8, 39, 2910, 0, 5000, "Nant'ina" }, -- Nant
        ["Stcemqestcint"] = { "Stcemqestcint", 6, 39, 2910, 0, 245, "No Auto Attack" }, -- Stce
        ["Nightmare Morbol"] = { "N. Morbol", 33, 85, 0, 0, 186, "Nightmare Morbol" }, -- NMor
        ["Cirrate Christelle"] = { "C. Christelle", 1, 39, 472, 0, 0, "Cirrate Christelle" }, -- Cirr
        -- Dynamis - Qufim Non-Beastmen (Done)
        ["Scolopendra"] = { "Scolopendra", 76, 41, 3131, 0, 218, "Enabled Auto Attack" }, -- Scol
        ["Suttung"] = { "Suttung", 85, 41, 3131, 0, 135, "Enabled Auto Attack" }, -- Sutt
        ["Stringes"] = { "Stringes", 79, 41, 3131, 0, 46, "Enabled Auto Attack" }, -- Stri
        ["Antaeus"] = { "Antaeus", 1, 41, 112, 0, 126, "Antaeus" }, -- Anta
        -- Dynamis - Tavnazia Non-Beastmen
        ["Diabolos Club"] = { "D. Club", 4, 42, 0, nil, nil, "Diabolos Club" }, -- DiaC
        ["Diabolos Diamond"] = { "D. Diamond", 3, 42, 0, nil, nil, "Diabolos Diamond" }, -- DiaD
        ["Diabolos Heart"] = { "D. Heart", 2, 42, 0, nil, nil, "Diabolos Heart" }, -- DiaH
        ["Diabolos Spade"] = { "D. Spade", 1, 42, 0, nil, nil, "Diabolos Spade" }, -- DiaS
    }
    xi.dynamis.nmFunctions =
    {
        ["Beastmen"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.setNMStats(mob) end },
            ["onMobEngaged"] = { function(mob, target) xi.dynamis.mobOnEngaged(mob, target) end },
            ["onMobFight"] = { function(mob) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.mobOnDeath(mob, player, optParams) end },
            ["mixins"] = {  require("scripts/mixins/job_special"), require("scripts/mixins/remove_doom")  },
        },
        ["XarcNM"] =
        {
            ["onMobSpawn"] = { function(mob)
                xi.dynamis.setNMStats(mob)
                mob:addImmunity(xi.immunity.SLEEP)
                if mob:getName() == "DE_M.Orias" then
                    mob:addImmunity(xi.immunity.SILENCE)
                end
            end },
            ["onMobEngaged"] = { function(mob, target) xi.dynamis.mobOnEngaged(mob, target) end },
            ["onMobFight"] = { function(mob) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.mobOnDeath(mob, player, optParams) end },
            ["mixins"] = {  require("scripts/mixins/job_special"), require("scripts/mixins/remove_doom")  },
        },
        ["Statue Megaboss"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.setMegaBossStats(mob) end },
            ["onMobEngaged"] = { function(mob, target)  end },
            ["onMobFight"] = { function(mob) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.megaBossOnDeath(mob, player) end },
            ["mixins"] = {   },
        },
        ["Angra Mainyu"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnAngra(mob) end },
            ["onMobEngaged"] = { function(mob, target) xi.dynamis.onEngagedAngra(mob, target) end },
            ["onMobFight"] = { function(mob, target) xi.dynamis.onFightAngra(mob, target) end },
            ["onMobRoam"] = { function(mob) xi.dynamis.onRoamAngra(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) xi.dynamis.onMagicPrepAngra(mob) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.megaBossOnDeath(mob, player) end },
            ["mixins"] = {   },
        },
        ["Dagourmarche"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnDagour(mob) end },
            ["onMobEngaged"] = { function(mob, target)  xi.dynamis.onEngagedDagour(mob, target) end },
            ["onMobFight"] = { function(mob, target) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) xi.dynamis.onWeaponskillPrepDagour(mob) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.mobOnDeath(mob, player, optParams) end },
            ["mixins"] = {  require("scripts/mixins/job_special"),  },
        },
        ["Goublefaupe"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnGouble(mob) end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob, target) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.mobOnDeath(mob, player, optParams) end },
            ["mixins"] = {  require("scripts/mixins/job_special"),  },
        },
        ["Mildaunegeux"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnMildaun(mob) end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob, target) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.mobOnDeath(mob, player, optParams) end },
            ["mixins"] = {  require("scripts/mixins/job_special"),  },
        },
        ["Quiebitiel"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnQuieb(mob) end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob, target) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.mobOnDeath(mob, player, optParams) end },
            ["mixins"] = {  require("scripts/mixins/job_special"),  },
        },
        ["Velosareon"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnVelosar(mob) end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob, target) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.mobOnDeath(mob, player, optParams) end },
            ["mixins"] = {  require("scripts/mixins/job_special"),  },
        },

        ["Apocalyptic Beast"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnApoc(mob) end },
            ["onMobEngaged"] = { function(mob, target)  xi.dynamis.onEngagedApoc(mob, target) end },
            ["onMobFight"] = { function(mob, target) xi.dynamis.onFightApoc(mob, target) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob, target) end },
            ["onMobWeaponSkill"] = { function(mob, target, skill) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.megaBossOnDeath(mob, player, optParams) end },
            ["mixins"] = {   },
        },
        ["Antaeus"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnAntaeus(mob) end },
            ["onMobEngaged"] = { function(mob, target)  xi.dynamis.onEngagedAntaeus(mob, target) end },
            ["onMobFight"] = { function(mob, target) xi.dynamis.onFightAntaeus(mob, target) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.megaBossOnDeath(mob, player) end },
            ["mixins"] = {   },
        },
        ["Cirrate Christelle"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnCirrate(mob) end },
            ["onMobEngaged"] = { function(mob, target) xi.dynamis.onEngagedCirrate(mob, target) end },
            ["onMobFight"] = { function(mob, target) xi.dynamis.onFightCirrate(mob, target) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) xi.dynamis.onWeaponskillPrepCirrate(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.megaBossOnDeath(mob, player) end },
            ["mixins"] = {   },
        },
        ["Fairy Ring"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnFairy(mob) end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob, target) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.mobOnDeath(mob, player, optParams) end },
            ["mixins"] = {   },
        },
        ["Nant'ina"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnNoAuto(mob) end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob, target) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) xi.dynamis.onWeaponskillPrepNantina(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.mobOnDeath(mob, player, optParams) end },
            ["mixins"] = {   },
        },
        ["Nightmare Morbol"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.setNMStats(mob) end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob, target) xi.dynamis.onFightMorbol(mob, target) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.mobOnDeath(mob, player, optParams) end },
            ["mixins"] = {   },
        },
        ["Dynamis Lord"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnDynaLord(mob) end },
            ["onMobEngaged"] = { function(mob, target)  xi.dynamis.onEngagedDynaLord(mob, target) end },
            ["onMobFight"] = { function(mob, target) xi.dynamis.onFightDynaLord(mob, target) end },
            ["onMobRoam"] = { function(mob) xi.dynamis.onMobRoamXarc(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target) xi.dynamis.onMagicPrepDynaLord(mob, target) end },
            ["onMobWeaponSkillPrepare"] = { function(mob, target) xi.dynamis.onWeaponskillPrepDynaLord(mob, target) end },
            ["onMobWeaponSkill"] = { function(mob, skill) xi.dynamis.onWeaponskillDynaLord(mob, skill) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.onDeathDynaLord(mob, player, optParams) end },
            ["mixins"] = {   },
        },
        ["Ying"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnYing(mob) end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob) xi.dynamis.onFightYing(mob, target) end },
            ["onMobRoam"] = { function(mob) xi.dynamis.onMobRoamXarc(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob, target) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.onDeathYing(mob, player, optParams) end },
            ["mixins"] = {   },
        },
        ["Yang"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnYang(mob) end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob) xi.dynamis.onFightYang(mob, target) end },
            ["onMobRoam"] = { function(mob) xi.dynamis.onMobRoamXarc(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob, target) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.onDeathYang(mob, player, optParams) end },
            ["mixins"] = {   },
        },
        ["Animated Weapon"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnAnimated(mob) end },
            ["onMobEngaged"] = { function(mob, target)  xi.dynamis.onEngagedAnimated(mob, target) end },
            ["onMobFight"] = { function(mob, target) xi.dynamis.onFightAnimated(mob, target) end },
            ["onMobRoam"] = { function(mob) xi.dynamis.onMobRoamXarc(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target) end },
            ["onMobWeaponSkillPrepare"] = { function(mob, target) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.mobOnDeath(mob, player, optParams) end },
            ["mixins"] = {  require("scripts/mixins/families/animated_weapons"),  },
        },
        ["Satellite Weapon"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnSatellite(mob) end },
            ["onMobEngaged"] = { function(mob, target) xi.dynamis.onEngageSatellite(mob, target) end },
            ["onMobFight"] = { function(mob, target) xi.dynamis.onFightSatellite(mob, target) end },
            ["onMobRoam"] = { function(mob) xi.dynamis.onMobRoamXarc(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob, target) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob) end },
            ["mixins"] = {   },
        },
        ["Buburimu Dwagon"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnNoAuto(mob) end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob, target) xi.dynamis.onFightDwagon(mob, target) end },
            ["onMobRoam"] = { function(mob) xi.dynamis.onRoamDwagon(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.mobOnDeath(mob, player, optParams) end },
            ["mixins"] = {   },
        },
        ["No Auto Attack"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.onSpawnNoAuto(mob) end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob, target) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.mobOnDeath(mob, player, optParams) end },
            ["mixins"] = {   },
        },
        ["Enabled Auto Attack"] =
        {
            ["onMobSpawn"] = { function(mob) xi.dynamis.setNMStats(mob) end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob, target) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.mobOnDeath(mob, player, optParams) end },
            ["mixins"] = {   },
        },
        ["Pukis"] =
        {
            ["onMobSpawn"] = { function(mob)
                xi.dynamis.setNMStats(mob)
                mob:addImmunity(xi.immunity.SLEEP)
            end },
            ["onMobEngaged"] = { function(mob, target) end },
            ["onMobFight"] = { function(mob, target) end },
            ["onMobRoam"] = { function(mob) end },
            ["onMobMagicPrepare"] = { function(mob, target, spellId) end },
            ["onMobWeaponSkillPrepare"] = { function(mob) end },
            ["onMobWeaponSkill"] = { function(mob) end },
            ["onMobDeath"] = { function(mob, player, optParams) xi.dynamis.mobOnDeath(mob, player, optParams) end },
            ["mixins"] = {   },
        }
        ,
    }

    if xi.dynamis.nmInfoLookup[mobName][8] then
        flags = xi.dynamis.nmInfoLookup[mobName][8]
    end

    local mob = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
        name = xi.dynamis.nmInfoLookup[mobName][1],
        x = xPos,
        y = yPos,
        z = zPos,
        rotation = rPos,
        groupId = xi.dynamis.nmInfoLookup[mobName][2],
        groupZoneId = xi.dynamis.nmInfoLookup[mobName][3],
        onMobSpawn = function(mob)
            local specFunc = xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobSpawn"][1]
            specFunc(mob)
            -- set all dyna mobs to same sublink so for example statues link when seeing normal mobs
            mob:setMobMod(xi.mobMod.SUBLINK, xi.dynamis.SUBLINK_ID)
        end,
        onMobEngaged= xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobEngaged"][1],
        onMobFight= xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobFight"][1],
        onMobRoam= xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobRoam"][1],
        onMobMagicPrepare= xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobMagicPrepare"][1],
        onMobWeaponSkillPrepare= xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobWeaponSkillPrepare"][1],
        onMobWeaponSkill= xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobWeaponSkill"][1],
        onMobDeath= xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobDeath"][1],
        onMobDespawn = function (mob) xi.dynamis.mobOnDespawn(mob) end,
        releaseIdOnDisappear = true,
        spawnSet = 3,
        specialSpawnAnimation = oMob ~= nil,
        entityFlags = flags,
        mixins = xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["mixins"],
    })
    if oMob ~= nil then
        if mainDynaLord == oMob:getID() and mobName == "Dynamis Lord" then
            mob:setSpawn(target:getXPos(), target:getYPos(), target:getZPos(), target:getRotPos())
            mob:spawn()
            mob:setSpawn(xPos, yPos, zPos, rPos)
            mob:setLocalVar("Clone", 1)
            -- do not set zone mobIndex for clones as zone 179 should only be real DL
        elseif mainDynaLord == oMob:getID() and mobName == "Ying" or mobName == "Yang" then
            mob:setSpawn(oMob:getXPos(), oMob:getYPos(), oMob:getZPos(), oMob:getRotPos())
            mob:spawn()
            mob:setSpawn(xPos, yPos, zPos, rPos)
            zone:setLocalVar(string.format("%s", mobIndex), mob:getID())
        else
            mob:setSpawn(xPos, yPos, zPos, rPos)
            mob:spawn()
            zone:setLocalVar(string.format("%s", mobIndex), mob:getID())
        end
    else
        mob:setSpawn(xPos, yPos, zPos, rPos)
        mob:spawn()
        zone:setLocalVar(string.format("%s", mobIndex), mob:getID())
    end
    zone:setLocalVar(string.format("MobIndex_%s", mob:getID()), mobIndex)
    mob:setLocalVar(string.format("MobIndex_%s", mob:getID()), mobIndex)
    mob:setLocalVar("MobIndex", mobIndex)
    mob:setDropID(xi.dynamis.nmInfoLookup[mobName][4])
    if xi.dynamis.nmInfoLookup[mobName][5] ~= nil then -- If SpellList ~= nil set SpellList
        mob:setSpellList(xi.dynamis.nmInfoLookup[mobName][5])
    end
    if xi.dynamis.nmInfoLookup[mobName][6] ~= nil then -- If SkillList ~= nil set SkillList
        mob:setMobMod(xi.mobMod.SKILL_LIST, xi.dynamis.nmInfoLookup[mobName][6])
    end
    if oMobIndex ~= nil then
        mob:setLocalVar("Parent", oMobIndex)
        mob:setLocalVar("ParentID", oMob:getID())
        oMob:setLocalVar(string.format("ChildID_%s", mobIndex), mob:getID())
    end
    if xi.dynamis.mobList[zoneID][mobIndex].info[5] ~= nil then
        zone:setLocalVar(string.format("%s", xi.dynamis.mobList[zoneID][mobIndex].info[5]), 0)
        mob:setLocalVar("hasMobVar", 1)
    end

    zone:setLocalVar(mobName, mob:getID())
    if forceLink == true then
        mob:updateEnmity(target)
    end
end

xi.dynamis.spawnDynamicPet =function(target, oMob, mobJob)
    local mobFamily = oMob:getFamily()
    local zoneID = oMob:getZoneID()
    local oMobIndex = oMob:getZone():getLocalVar(string.format("MobIndex_%s", oMob:getID()))
    local isNM = false
    local mobName = oMob:getName()
    local zone = oMob:getZone()
    local functionLookup = "Normal"
    if oMobIndex ~= 0 then
        if xi.dynamis.mobList[zoneID][oMobIndex].info[1] == "NM" then
            isNM = true
        end
        if xi.dynamis.mobList[zoneID][oMobIndex].info[2] ~= nil then
            mobName = xi.dynamis.mobList[zoneID][oMobIndex].info[2]
        end
    end
    if mobJob == nil then
        mobJob = oMob:getMainJob()
    end
    local nameObj = nil
    local petList =
    {
        -- Note: To set default SpellList and SkillList use nil.
        -- [Parent's Family] =
        -- {
            -- [Mob's Job] =
            --  {
            --     [false] = { Name, groupId, groupZoneId, Droplist, SpellList, SkillList }, -- Non-NM Pet
            --     [true] -- Is an NM
            --     {
            --          [ParentName] = { Name, groupId, groupZoneId, Droplist, SpellList, SkillList }, -- NM Pet
            --      },
            --    },
        --  },
        -- [Mob's Name (Used for Non-Beastmen NMs)] = { Name, groupId, groupZoneId, Droplist, SpellList, SkillList }, -- NM Pet
        [xi.job.BST] =
        {
            [327] = -- Goblin Family
            {
                [false] = { "V. Slime" , 130, 134, 0, 54, 229 }, -- Normal Goblin BST (VSlime)
            },
            [334] = -- Orc Family
            {
                [false] = { "V. Hecteyes", 77, 134, 0, 51, 139 }, -- Normal Orc BST (VHec)
                [true] = -- Orc NM
                {
                    ["Mithraslaver Debhabob"] = { "V. Hecteyes", 77, 134, 0, 51, 139 }, -- NM Orc BST (VHec)
                },
            },
            [337] = -- Quadav Family
            {
                [false] = { "V. Scorpion", 22, 134, 0, 53, 217 }, -- Normal Quadav BST (VSco)
                [true] = -- Quadav NM
                {
                    ["So'Gho Adderhandler"] = { "V. Scorpion", 22, 134, 0, 53, 217 }, -- NM Quadav BST (VSco)
                    ["Be'Ebo Tortoisedriver"] = { "V. Scorpion", 22, 134, 0, 53, 217 }, -- NM Quadav BST (VSco)
                },
            },
            [358] = -- Kindred Family
            {
                [false] = { "K. Vouvire", 100, 135, 0, 0, 267 }, -- Normal Kindred BST (KVou)
                [true] = -- NM Kindred
                {
                    ["Marquis Andras"] = { "A. Vouvire", 55, 135, 0, 0, 267 }, -- NM Kindred BST (AVou)
                },
            },
            [359] = -- Hydra Family
            {
                [false] = { "H. Hound", 169, 134, 0, 0, 143 }, -- Normal Hydra BST (HHou)
                [true] = -- Hydra NM
                {
                    ["Dagourmarche"] = { "D. Hound", 169, 134, 0, 0, 143 }, -- NM Hydra BST (DHou)
                },
            },
            [360] = -- Yagudo Family
            {
                [false] = { "V. Crow", 100, 134, 0, 52, 55 }, -- Normal Yagudo BST (VCro)
                [true] = -- Yagudo NM
                {
                    ["Soo Jopo the Fiendking"] = { "V. Crow", 100, 134, 0, 52, 55 }, -- NM Yagudo BST (VCro)
                },
            },
            [373] = -- Goblin Armored Family
            {
                [true] = -- Goblin NM
                {
                    ["Trailblix Goatmug"] = { "V. Slime" , 130, 134, 0, 54, 229 }, -- NM Goblin BST (VSlime)
                    ["Rutrix Hamgams"] = { "V. Slime" , 130, 134, 0, 54, 229 }, -- NM Goblin BST (VSlime)
                    ["Blazox Boneybod"] = { "V. Slime", 130, 134, 0, 54, 229 }, -- NM Goblin BST (VSlime)
                    ["Routsix Rubbertendon"] = { "V. Slime" , 130, 134, 0, 54, 229 }, -- NM Goblin BST (VSlime)
                    ["Blazax Boneybad"] = { "V. Slime" , 130, 134, 0, 54, 229 }, -- NM Goblin BST (VSlime)
                    ["Woodnix Shrillwistle"] = { "W. Slime" , 7, 40, 0, 54, 229 }, -- NM Goblin BST (WSSlime)
                },
            },
        },
        [xi.job.DRG] =
        {
            [327] = -- Goblin Family
            {
                [false] = { "V. Wyvern", 27, 134, 0, 0, 714 },
            },
            [334] = -- Orc Family
            {
                [false] = { "V. Wyvern", 27, 134, 0, 0, 714 },
                [true] =
                {
                    ["Elvaansticker Bxafraff"] = { "V. Wyvern", 27, 134, 0, 0, 714 }, -- Normal Vanguard's Wyvern (Vwyv)
                    ["Wyrmgnasher Bjakdek"] = { "V. Wyvern", 27, 134, 0, 0, 714 }, -- Normal Vanguard's Wyvern (Vwyv)
                    ["Drakefeast Wubmfub"] = { "V. Wyvern", 27, 134, 0, 0, 714 }, -- Normal Vanguard's Wyvern (Vwyv)
                },
            },
            [337] = -- Quadav Family
            {
                [false] = { "V. Wyvern", 27, 134, 0, 0, 714 },
                [true] =
                {
                    ["Go'Tyo Magenapper"] = { "V. Wyvern", 27, 134, 0, 0, 714 }, -- Normal Vanguard's Wyvern (Vwyv)
                },
            },
            [358] = -- Kindred Family
            {
                [false] = { "K. Wyvern", 27, 134, 0, 0, 714 },
                [true] =
                {
                    ["King Zagan"] = { "Zagan's Wyvern", 61, 135, 0, 0, 714 }, -- Zagan's Wyvern (Zwyv)
                },
            },
            [359] = -- Hydra Family
            {
                [false] = { "H. Wyvern", 27, 134, 0, 0, 714 },
                [true] =
                {
                    ["Dagourmarche"] = { "D. Wyvern", 27, 134, 0, 0, 714 }, -- Dagourmache's Wyvern (DWyv)
                },
            },
            [360] = -- Yagudo Family
            {
                [false] = { "V. Wyvern", 27, 134, 0, 0, 714 },
                [true] =
                {
                    ["Maa Zaua the Wyrmkeeper"] = { "V. Wyvern", 27, 134, 0, 0, 714 }, -- Normal Vanguard's Wyvern (Vwyv)
                },
            },
            [87] = -- Dwagon Family
            {
                [false] = { "V. Wyvern", 27, 134, 0, 0, 714 },
                [true] =
                {
                    ["Apocalyptic Beast"] = { "Dragon's Wyvern", 27, 134, 0, 0, 714 }, -- Dragon's Wyvern (Dwyv)
                },
            },
            [373] = -- Goblin Armored Family
            {
                [true] =
                {
                    ["Draklix Scalecrust"] = { "V. Wyvern", 27, 134, 0, 0, 714 }, -- Normal Vanguard's Wyvern (Vwyv)
                    ["Wyrmwix Snakespecs"] = { "V. Wyvern", 27, 134, 0, 0, 714 }, -- Normal Vanguard's Wyvern (Vwyv)
                },
            },
        },
        [xi.job.SMN] =
        {
            [327] = -- Goblin Family
            {
                [false] = { "V. Avatar" , 36, 134, 0, 0, 34 }, -- Vanguard's Avatar (VAva)
            },
            [334] = -- Orc Family
            {
                [false] = { "V. Avatar" , 36, 134, 0, 0, 34 }, -- Vanguard's Avatar (VAva)
                [true] = -- Orc NM
                {
                    ["Deathcaller Bidfbid"] = { "V. Avatar" , 36, 134, 0, 0, 34 }, -- Vanguard's Avatar (VAva)
                    ["Reapertongue Gadgquok"] = { "V. Avatar" , 36, 134, 0, 0, 34 }, -- Vanguard's Avatar (VAva)
                },
            },
            [337] = -- Quadav Family
            {
                [false] = { "V. Avatar" , 36, 134, 0, 0, 34 }, -- Vanguard's Avatar (VAva)
                [true] = -- Quadav NM
                {
                    ["Be'Zhe Keeprazer"] = { "V. Avatar" , 36, 134, 0, 0, 34 }, -- Vanguard's Avatar (VAva)
                    ["Gu'Nhi Noondozer"] = { "V. Avatar" , 36, 134, 0, 0, 34 }, -- Vanguard's Avatar (VAva)
                },
            },
            [358] = -- Kindred Family
            {
                [false] = { "K. Avatar" , 25, 135, 0, 0, 34 }, -- Kindred's Avatar (KAva)
                [true] = -- NM Kindred
                {
                    ["Marquis Nebiros"] = { "Nebiros' Avatar", 68, 135, 0, 0, 34 }, -- Nebrios's Avatar (NAva)
                },
            },
            [359] = -- Hydra Family
            {
                [false] = { "H. Avatar", 177, 134, 0, 0, 34 }, -- Hydra's Avatar (HAva)
                [true] = -- Hydra NM
                {
                    ["Dagourmarche"] = { "D. Avatar", 177, 134, 0, 0, 34 }, -- Dagourmache's Avatar (DAva)
                },
            },
            [360] = -- Yagudo Family
            {
                [false] = { "V. Avatar" , 36, 134, 0, 0, 34 }, -- Vanguard's Avatar (VAva)
                [true] = -- Yagudo NM
                {
                    ["Baa Dava the Bibliophage"] = { "V. Avatar" , 36, 134, 0, 0, 34 }, -- Vanguard's Avatar (VAva)
                    ["Puu Timu the Phantasmal"] = { "V. Avatar" , 36, 134, 0, 0, 34 }, -- Vanguard's Avatar (VAva)
                    ["Haa Pevi the Stentorian"] = { "V. Avatar" , 36, 134, 0, 0, 34 }, -- Vanguard's Avatar (VAva)
                },
            },
            [87] = -- Dwagon Family
            {
                [true] = -- Dwagon NM
                {
                    ["Apocalyptic Beast"] = { "Dragon's Avatar", 36, 134, 0, 0, 34 }, -- Dragon's Avatar (Dava)
                },
            },
            [373] = -- Goblin Armored Family
            {
                [true] = -- Goblin NM
                {
                    ["Morblox Chubbychin"] = { "V. Avatar" , 36, 134, 0, 0, 34 }, -- Vanguard's Avatar (VAva)
                    ["Morgmox Moldnoggin"] = { "V. Avatar" , 36, 134, 0, 0, 34 }, -- Vanguard's Avatar (VAva)
                    ["Mortilox Wartpaws"] = { "V. Avatar" , 36, 134, 0, 0, 34 }, -- Vanguard's Avatar (VAva)
                },
            },
        },
    }
    local petFunctions =
    {
        [xi.job.SMN] =
        {
            ["Apocalyptic Beast"] =
            {
                ["onMobFight"] = { function(mob, target) end },
                ["onMobRoam"] = { function(mob) end },
                ["mixins"] = {  require("scripts/mixins/families/avatar"),  },
            },
            ["Dagourmarche"] =
            {
                ["onMobFight"] = { function(mob, target) xi.dynamis.onFightMultiPet(mob, target) end },
                ["onMobRoam"] = { function(mob) xi.dynamis.onRoamMultiPet(mob) end },
                ["mixins"] = {  require("scripts/mixins/families/avatar"), },
            },
            ["Normal"] =
            {
                ["onMobFight"] = { function(mob, target) end },
                ["onMobRoam"] = { function(mob) end },
                ["mixins"] = { require("scripts/mixins/families/avatar_persist"), },
            },
        },
        [xi.job.BST] =
        {
            ["Dagourmarche"] =
            {
                ["onMobFight"] = { function(mob, target) xi.dynamis.onFightMultiPet(mob, target) end },
                ["onMobRoam"] = { function(mob) xi.dynamis.onRoamMultiPet(mob) end },
                ["mixins"] = {   },
            },
            ["Normal"] =
            {
                ["onMobFight"] = { function(mob, target) end },
                ["onMobRoam"] = { function(mob) end },
                ["mixins"] = {   },
            },
        },
        [xi.job.DRG] =
        {
            ["Apocalyptic Beast"] =
            {
                ["onMobFight"] = { function(mob, target) xi.dynamis.onFightApocDRG(mob, target) end },
                ["onMobRoam"] = { function(mob) xi.dynamis.onRoamApocDRG(mob) end },
                ["mixins"] = {   },
            },
            ["Dagourmarche"] =
            {
                ["onMobFight"] = { function(mob, target) xi.dynamis.onFightMultiPet(mob, target) end },
                ["onMobRoam"] = { function(mob) xi.dynamis.onRoamMultiPet(mob) end },
                ["mixins"] = {   },
            },
            ["Normal"] =
            {
                ["onMobFight"] = { function(mob, target) end },
                ["onMobRoam"] = { function(mob) end },
                ["mixins"] = {   },
            },
        },
    }
    local nameFunction = { "Apocalyptic Beast", "Dagourmarche"}
    if isNM == true then
        nameObj = petList[mobJob][mobFamily][isNM][mobName]
    else
        nameObj = petList[mobJob][mobFamily][isNM]
    end
    for _, name in pairs(nameFunction) do
        if name == mobName then
            functionLookup = mobName
            break
        end
    end
    local mob = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
        name = nameObj[1],
        x = oMob:getXPos(),
        y = oMob:getYPos(),
        z = oMob:getXPos(),
        rotation = oMob:getRotPos(),
        groupId = nameObj[2],
        groupZoneId = nameObj[3],
        onMobSpawn = function(mob)
            xi.dynamis.setPetStats(mob)
            -- set all dyna mobs to same sublink so for example statues link when seeing normal mobs
            mob:setMobMod(xi.mobMod.SUBLINK, xi.dynamis.SUBLINK_ID)
        end,
        onMobFight = petFunctions[mobJob][functionLookup]["onMobFight"][1],
        onMobRoam = petFunctions[mobJob][functionLookup]["onMobRoam"][1],
        onMobDeath = function(mob, player, optParams) xi.dynamis.onPetDeath(mob) end,
        onMobDespawn = function (mob) xi.dynamis.mobOnDespawn(mob) end,
        releaseIdOnDisappear = true,
        spawnSet = 3,
        specialSpawnAnimation = oMob ~= nil,
        mixins = petFunctions[mobJob][functionLookup]["mixins"],
    })
    mob:setSpawn(oMob:getXPos()+math.random()*6-3, oMob:getYPos()-0.3, oMob:getZPos()+math.random()*6-3, oMob:getRotPos())
    mob:spawn()
    mob:setDropID(nameObj[4])
    if nameObj[5] ~= nil then -- If SpellList ~= nil set SpellList
        mob:setSpellList(nameObj[5])
    end
    if nameObj[6] ~= nil then -- If SkillList ~= nil set SkillList
        mob:setMobMod(xi.mobMod.SKILL_LIST, nameObj[6])
    end
    oMob:setPet(mob)
    mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0, true)
    mob:updateEnmity(target)
end

--------------------------------------------
--        Dynamis Mob Pathing/Roam        --
--------------------------------------------

xi.dynamis.mobOnRoam = function(mob) -- Handle pathing.
    if mob:getRoamFlags() == xi.roamFlag.SCRIPTED then
        local zoneID = mob:getZoneID()
        local mobIndex = mob:getLocalVar(string.format("MobIndex_%s", mob:getID()))
        for _, index in pairs(xi.dynamis.mobList[zoneID].patrolPaths) do
            local table = xi.dynamis.mobList[zoneID][index].patrolPath
            local maxDest = #table
            if mobIndex == index then
                for path, point in pairs(table) do
                    local next = table[path + 1]
                    local last = table[maxDest]
                    local first = table[1]
                    local prev = { x = point[1], y = point[2], z = point[3]}
                    local dest = nil
                    if next ~= nil then
                        dest = { x = next[1], y = next[2], z = next[3]}
                    end
                    local last = { x = last[1], y = last[2], z = last[3]}
                    local first = { x = first[1], y = first[2], z = first[3]}
                    local spawn = mob:getSpawnPos()
                    local current = mob:getPos()
                    if last.x == current.x and last.y == current.y and last.z == current.z then
                        mob:pathTo(first.x, first.y, first.z)
                        return
                    elseif prev.x == current.x and prev.y == current.y and prev.z == current.z then
                        mob:pathTo(dest.x, dest.y, dest.z)
                        return
                    elseif spawn.x == current.x and spawn.y == current.y and spawn.z == current.z then
                        mob:pathTo(first.x, first.y, first.z)
                        return
                    end
                end
            end
        end
    end
end

--------------------------------------------
--            Dynamis Mob Stats           --
--------------------------------------------
xi.dynamis.setSpecialSkill = function(mob)
    local specialSkills =
    {
        [337] = 1123, -- Quadav
        [358] = 1146, -- Kindred
    }
    for family, skill in pairs(specialSkills) do
        if mob:getFamily() == family and (mob:getMainJob() == xi.job.NIN or mob:getMainJob() == xi.job.RNG) then
            mob:setMobMod(xi.mobMod.SPECIAL_SKILL, skill)
        end
    end
end

local familyEES =
{
    [  3] = xi.jsa.EES_AERN,    -- Aern
    [ 25] = xi.jsa.EES_ANTICA,  -- Antica
    [115] = xi.jsa.EES_SHADE,   -- Fomor
    [126] = xi.jsa.EES_GIGA,    -- Gigas
    [127] = xi.jsa.EES_GIGA,    -- Gigas
    [128] = xi.jsa.EES_GIGA,    -- Gigas
    [129] = xi.jsa.EES_GIGA,    -- Gigas
    [130] = xi.jsa.EES_GIGA,    -- Gigas
    [133] = xi.jsa.EES_GOBLIN,  -- Goblin
    [169] = xi.jsa.EES_KINDRED, -- Kindred
    [171] = xi.jsa.EES_LAMIA,   -- Lamiae
    [182] = xi.jsa.EES_MERROW,  -- Merrow
    [184] = xi.jsa.EES_GOBLIN,  -- Moblin
    [189] = xi.jsa.EES_ORC,     -- Orc
    [200] = xi.jsa.EES_QUADAV,  -- Quadav
    [201] = xi.jsa.EES_QUADAV,  -- Quadav
    [202] = xi.jsa.EES_QUADAV,  -- Quadav
    [221] = xi.jsa.EES_SHADE,   -- Shadow
    [222] = xi.jsa.EES_SHADE,   -- Shadow
    [223] = xi.jsa.EES_SHADE,   -- Shadow
    [246] = xi.jsa.EES_TROLL,   -- Troll
    [270] = xi.jsa.EES_YAGUDO,  -- Yagudo
    [327] = xi.jsa.EES_GOBLIN,  -- Goblin
    [328] = xi.jsa.EES_GIGA,    -- Gigas
    [334] = xi.jsa.EES_ORC,     -- OrcNM
    [335] = xi.jsa.EES_MAAT,    -- Maat
    [337] = xi.jsa.EES_QUADAV,  -- QuadavNM
    [358] = xi.jsa.EES_KINDRED, -- Kindred
    [359] = xi.jsa.EES_SHADE,   -- Fomor
    [360] = xi.jsa.EES_YAGUDO,  -- YagudoNM
    [373] = xi.jsa.EES_GOBLIN,  -- Goblin_Armored
}

xi.dynamis.setMobStats = function(mob)
    if mob ~= nil then
        mob:setMobType(xi.mobskills.mobType.BATTLEFIELD)
        mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0, true)
        xi.dynamis.setSpecialSkill(mob)
        mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
        local job = mob:getMainJob()

        mob:setTrueDetection(true)

        if     mob:getFamily() == 359 then -- If Hydra
            mob:setMobLevel(math.random(80,82))
        elseif mob:getFamily() == 358 then -- If Kindred
            mob:setMobLevel(math.random(77,80))
        else
            mob:setMobLevel(math.random(77.78))
        end

        if     job == xi.job.WAR then
            local params = {  }
            params.specials = {  }
            params.specials.skill = {  }
            params.specials.skill.id = xi.jsa.MIGHTY_STRIKES
            params.specials.skill.hpp = math.random(55,80)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.MNK then
            local params = {  }
            params.specials = {  }
            params.specials.skill = {  }
            params.specials.skill.id = xi.jsa.HUNDRED_FISTS
            params.specials.skill.hpp = math.random(55,70)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.WHM then
            local params = {  }
            params.specials = {  }
            params.specials.skill = {  }
            params.specials.skill.id = xi.jsa.BENEDICTION
            params.specials.skill.hpp = math.random(40,60)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.BLM then
            local params = {  }
            params.specials = {  }
            params.specials.skill = {  }
            params.specials.skill.id = xi.jsa.MANAFONT
            params.specials.skill.hpp = math.random(55,80)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.RDM then
            local params = {  }
            params.specials = {  }
            params.specials.skill = {  }
            params.specials.skill.id = xi.jsa.CHAINSPELL
            params.specials.skill.hpp = math.random(55,80)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.THF then
            local params = {  }
            params.specials = {  }
            params.specials.skill = {  }
            params.specials.skill.id = xi.jsa.PERFECT_DODGE
            params.specials.skill.hpp = math.random(55,75)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.PLD then
            local params = {  }
            params.specials = {  }
            params.specials.skill = {  }
            params.specials.skill.id = xi.jsa.INVINCIBLE
            params.specials.skill.hpp = math.random(55,75)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.DRK then
            local params = {  }
            params.specials = {  }
            params.specials.skill = {  }
            params.specials.skill.id = xi.jsa.BLOOD_WEAPON
            params.specials.skill.hpp = math.random(55,75)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.BST then
        elseif job == xi.job.BRD then
            local params = {  }
            params.specials = {  }
            params.specials.skill = {  }
            params.specials.skill.id = xi.jsa.SOUL_VOICE
            params.specials.skill.hpp = math.random(55,80)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.RNG then
            local params = {  }
            params.specials = {  }
            params.specials.skill = {  }
            params.specials.skill.id = familyEES[mob:getFamily()]
            params.specials.skill.hpp = math.random(55,75)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.SAM then
            local params = {  }
            params.specials = {  }
            params.specials.skill = {  }
            params.specials.skill.id = xi.jsa.MEIKYO_SHISUI
            params.specials.skill.hpp = math.random(55,80)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.NIN then
            local params = {  }
            params.specials = {  }
            params.specials.skill = {  }
            params.specials.skill.id = xi.jsa.MIJIN_GAKURE
            params.specials.skill.hpp = math.random(25,35)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.DRG then
            local params = {  }
            params.specials = {  }
            params.specials.skill = {  }
            params.specials.skill.id = xi.jsa.CALL_WYVERN
            params.specials.skill.hpp = 100
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.SMN then
        end

        xi.dynamis.addParentListeners(mob)

        -- Add Check After Calcs
        mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
    end
end

xi.dynamis.setNightmareStats = function(mob)
    if mob then
        mob:setMobType(xi.mobskills.mobType.BATTLEFIELD)
        mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0, true)
        xi.dynamis.setSpecialSkill(mob)
        mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
        local job = mob:getMainJob()
        mob:setMobLevel(math.random(78,80))
        mob:setTrueDetection(true)

        xi.dynamis.addParentListeners(mob)

        -- Add Check After Calcs
        mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
    end
end

local mdbValues =
{
    [93] = 162, -- Orc Statue
    [193] = 100, -- Wyvern
    [229] = 100, -- Hecteyes
    [334] = 100, -- Orc
}

xi.dynamis.setMDB = function(mob)
    for family, mdb in ipairs(mdbValues) do
        if mob:getFamily() == family then
            mob:setMod(xi.mod.MDEF, mdb)
        end
    end
end

xi.dynamis.setNMStats = function(mob)
    local job = mob:getMainJob()
    mob:setMobType(xi.mobskills.mobType.BATTLEFIELD)
    mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0, true)
    xi.dynamis.setSpecialSkill(mob)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
    mob:setMobLevel(math.random(80,82))
    mob:setTrueDetection(true)
    xi.dynamis.setMDB(mob)

    xi.dynamis.addParentListeners(mob)

    if job == xi.job.NIN then
        local params = {  }
        params.specials = {  }
        params.specials.skill = {  }
        params.specials.skill.id = xi.jsa.MIJIN_GAKURE
        params.specials.skill.hpp = math.random(15,25)
        xi.mix.jobSpecial.config(mob, params)
    end
end

xi.dynamis.setStatueStats = function(mob, mobIndex)
    local zoneID = mob:getZoneID()
    local eyes = xi.dynamis.mobList[zoneID][mobIndex].eyes
    mob:setRoamFlags(xi.roamFlag.SCRIPTED)
    mob:setMobType(xi.mobskills.mobType.BATTLEFIELD)
    mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0, true)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
    mob:setMobLevel(math.random(82,84))
    mob:setMod(xi.mod.DMG, -5000)
    mob:setTrueDetection(true)
    -- Disabling WHM job trait mods because their job is set to WHM in the DB.
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.MPHEAL, 0)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
    mob:setSpeed(20)

    xi.dynamis.setMDB(mob)
    xi.dynamis.addParentListeners(mob)

    if mob:getFamily() >= 92 and mob:getFamily() <= 95 then -- If statue
        if eyes ~= nil then
            mob:setLocalVar("eyeColor", eyes) -- Set Eyes if need be
            if eyes >= 2 then -- If HP or MP restore statue
                mob:setUnkillable(true) -- Set Unkillable as we will use skills then kill.
            end
        else
            mob:setLocalVar("eyeColor", xi.dynamis.eye.RED) -- Set Eyes if need be
        end
    end
end

xi.dynamis.setMegaBossStats = function(mob)
    mob:setMobType(xi.mobskills.mobType.BATTLEFIELD)
    mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0, true)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
    mob:setMobLevel(88)
    mob:setMod(xi.mod.STR, -10)
    mob:setTrueDetection(true)
    xi.dynamis.setMDB(mob)

    xi.dynamis.addParentListeners(mob)
end

xi.dynamis.setPetStats = function(mob)
    if mob:getFamily() == 34 then
        mob:setModelId(math.random(793, 798)) -- Ifrit -> Ramuh
    end
    mob:setMobType(xi.mobskills.mobType.BATTLEFIELD)
    mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0, true)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
    mob:setMobMod(xi.mobMod.CHARMABLE, 0)
    mob:setMobLevel(79)
    mob:setTrueDetection(true)
    xi.dynamis.setMDB(mob)
end

xi.dynamis.setAnimatedWeaponStats = function(mob)
    mob:setMobType(xi.mobskills.mobType.BATTLEFIELD)
    mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0, true)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.HP_HEAL_CHANCE, 90)
    mob:setMod(xi.mod.STUNRES, 75)
    mob:setMod(xi.mod.PARALYZERES, 100)
    mob:setMod(xi.mod.SLOWRES, 100)
    mob:setMod(xi.mod.SILENCERES, 100)
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)

    xi.dynamis.addParentListeners(mob)
end

xi.dynamis.teleport = function(mob, hideDuration)
    if mob:isDead() then
        return
    end

    mob:hideName(true)
    mob:setUntargetable(true)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:entityAnimationPacket("kesu")

    hideDuration = hideDuration or 5000

    if hideDuration < 1500 then
        hideDuration = 1500
    end

    mob:timer(hideDuration, function(mob)
        mob:hideName(false)
        mob:setUntargetable(false)
        mob:setAutoAttackEnabled(true)
        mob:setMagicCastingEnabled(true)
        mob:setMobAbilityEnabled(true)

        if mob:isDead() then
            return
        end

        mob:entityAnimationPacket("deru")
        mob:setLocalVar("teleTime", os.time())
    end)
end

xi.dynamis.addParentListeners = function(mob)
        mob:addListener('TAKE_DAMAGE', 'DYNA_DMG_TAKE', function(mobArg, amount, attacker, attackType, damageType)
            xi.dynamis.parentOnEngaged(mobArg, attacker)
        end)

        mob:addListener('ENGAGE', 'DYNA_ENGAGE', function(mobArg, target)
            xi.dynamis.parentOnEngaged(mobArg, target)
        end)
end

--------------------------------------------
--            Dynamis Mob Death           --
--------------------------------------------

xi.dynamis.mobOnDeath = function(mob, player, optParams)
    local zoneID = mob:getZoneID()
    local zone = mob:getZone()
    local mobIndex = zone:getLocalVar(string.format("MobIndex_%s", mob:getID()))
    if mob:getLocalVar("dynamisMobOnDeathTriggered") == 1 then return -- Don't trigger more than once.
    else -- Stops execution of code below if the above is true.
        if mob:getLocalVar("hasMobVar") == 1 then
            zone:setLocalVar(xi.dynamis.mobList[zoneID][mobIndex].info[5], 1) -- Set Death Requirements Variable
            if zoneID == xi.zone.DYNAMIS_VALKURM then
                local flies = {21, 22, 23}
                if mobIndex == flies[1] or mobIndex == flies[2] or mobIndex == flies[3] then
                    xi.dynamis.nightmareFlyCheck(mob, zone, zoneID)
                end
            end
        end

        if mobIndex ~= 0 and mobIndex ~= nil then
            xi.dynamis.addTimeToDynamis(zone, mobIndex) -- Add Time
        end

        mob:setLocalVar("dynamisMobOnDeathTriggered", 1) -- onDeath lua happens once per party member that killed the mob, but we want this to only run once per mob
    end

    zone:setLocalVar(string.format("MobIndex_%s", mob:getID()), 0)
    zone:setLocalVar(string.format("%s", mobIndex), 0)
end

xi.dynamis.mobOnDespawn = function(mob)
    local zone = mob:getZone()
    zone:setLocalVar(string.format("MobIndex_%s", mob:getID()), 0)
    zone:setLocalVar(string.format("%s", mob:getID()), 0)
end

m:addOverride("xi.dynamis.megaBossOnDeath", function(mob, player)
    local zoneID = mob:getZoneID()
    local mobIndex = mob:getZone():getLocalVar(string.format("MobIndex_%s", mob:getID()))
    local mobVar = xi.dynamis.mobList[mob:getZoneID()][mobIndex].info[5]
    if mob:getLocalVar("GaveTimeExtension") ~= 1 then -- Ensure we don't give more than 1 time extension.
        xi.dynamis.mobOnDeath(mob, player, mobVar) -- Process time extension and wave spawning
        local winQM = GetNPCByID(xi.dynamis.dynaInfoEra[zoneID].winQM) -- Set winQM
        local pos = mob:getPos()
        winQM:setPos(pos.x,pos.y,pos.z,pos.rot) -- Set winQM to death pos
        winQM:setStatus(xi.status.NORMAL) -- Make visible
        mob:setLocalVar("GaveTimeExtension", 1)
    end

    local zone = mob:getZone()
    if zone:getLocalVar('TitleGranted') < 1 then
        for _, p in pairs(zone:getPlayers()) do
            p:addTitle(xi.dynamis.dynaInfoEra[zoneID].winTitle) -- Give player the title
        end
        zone:setLocalVar('TitleGranted', 1)
    end
end)

--------------------------------------------
--        Dynamis Statue Functions        --
--------------------------------------------

xi.dynamis.statueOnFight = function(mob, target)
    if mob:getHP() == 1 then -- If my HP = 1
        if mob:getAnimationSub() > 1 then -- I am an HP statue
            if mob:hasStatusEffect(xi.effect.REGEN) then
                mob:delStatusEffect(xi.effect.REGEN)
                mob:setHP(1)
            end
            if mob:getLocalVar("reset") ~= 1 then
                mob:setLocalVar("reset", 1)
                mob:addStatusEffect(xi.effect.STUN, 1, 0, 10)
                mob:setUntargetable(true)
                mob:setMagicCastingEnabled(false)
                mob:setAutoAttackEnabled(false)
                mob:setMobAbilityEnabled(false)

                mob:timer(1000, function(mobArg) -- Allows stun to tick
                    mobArg:setTP(0)
                    mobArg:setMobAbilityEnabled(true)
                    mobArg:delStatusEffectSilent(xi.effect.STUN) -- Remove stun so we can do skill.
                    if mobArg:getAnimationSub() == 2 then
                        mobArg:useMobAbility(1124) -- Use Recover HP
                    elseif mobArg:getAnimationSub() == 3 then
                        mobArg:useMobAbility(1125) -- Use Recover MP
                    end
                end)

                mob:timer(5000, function(mobArg)
                    if mobArg:isAlive() then
                        mobArg:setUnkillable(false)
                        mobArg:setHP(0)
                    end
                end)
            end
        end
    end
end

--------------------------------------------
--          Dynamis Pet Spawning          --
--------------------------------------------
xi.dynamis.mobOnEngaged = function(mob, target)
    if  mob:getLocalVar("SpawnedPets") == 0 then
        mob:setLocalVar("SpawnedPets", 1)
        if  mob:getMainJob() == xi.job.BST or mob:getMainJob() == xi.job.SMN then
            mob:entityAnimationPacket("casm")
            mob:setAutoAttackEnabled(false)
            mob:setMagicCastingEnabled(false)
            mob:setMobAbilityEnabled(false)

            mob:addStatusEffectEx(xi.effect.BIND, xi.effect.BIND, 1, 3, 6, 0, 0, 0, xi.effectFlag.NO_LOSS_MESSAGE)
            mob:timer(3000, function(mobArg)
                if mob:isAlive() then
                    xi.dynamis.spawnDynamicPet(target, mob, mobArg:getMainJob())
                    mobArg:entityAnimationPacket("shsm")
                    mobArg:setAutoAttackEnabled(true)
                    mobArg:setMagicCastingEnabled(true)
                    mobArg:setMobAbilityEnabled(true)

                    if mobArg:hasStatusEffect(xi.effect.BIND) then
                        mobArg:delStatusEffectSilent(xi.effect.BIND)
                    end
                end
            end)
        -- elseif mob:getMainJob() == xi.job.DRG then
            -- mob:useMobAbility(xi.jsa.CALL_WYVERN)
        end
    end
end

return m
