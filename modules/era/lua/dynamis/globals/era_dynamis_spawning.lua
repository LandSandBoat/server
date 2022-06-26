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
--------------------------------------------
--       Module Extended Scripts          --
--------------------------------------------
require("modules/era/lua/dynamis/mobs/era_beaucedine_mobs")
require("modules/era/lua/dynamis/mobs/era_buburimu_mobs")
require("modules/era/lua/dynamis/mobs/era_qufim_mobs")
require("modules/era/lua/dynamis/mobs/era_valkurm_mobs")
require("modules/era/lua/dynamis/mobs/era_xarcabard_mobs")
require("modules/era/lua/dynamis/mob_spawning_files/dynamis_bastok_mobs")
require("modules/era/lua/dynamis/mob_spawning_files/dynamis_beaucedine_mobs")
require("modules/era/lua/dynamis/mob_spawning_files/dynamis_buburimu_mobs")
require("modules/era/lua/dynamis/mob_spawning_files/dynamis_jeuno_mobs")
require("modules/era/lua/dynamis/mob_spawning_files/dynamis_qufim_mobs")
require("modules/era/lua/dynamis/mob_spawning_files/dynamis_san_d_oria_mobs")
require("modules/era/lua/dynamis/mob_spawning_files/dynamis_valkurm_mobs")
require("modules/era/lua/dynamis/mob_spawning_files/dynamis_windurst_mobs")
require("modules/era/lua/dynamis/mob_spawning_files/dynamis_xarcabard_mobs")
require("scripts/zones/Dynamis-Xarcabard/IDs")
--------------------------------------------

local m = Module:new("era_dynamis_spawning")

xi = xi or {}
xi.dynamis = xi.dynamis or {}

--------------------------------------------
--          Dynamis Mob Spawning          --
--------------------------------------------

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
end

xi.dynamis.parentOnEngaged = function(mob, target)
    local zoneID = mob:getZoneID()
    local oMobIndex = mob:getZone():getLocalVar(string.format("MobIndex_%s", mob:getID()))
    local oMob = mob
    local eyes = mob:getLocalVar("eyeColor")
    if eyes ~= nil then
        mob:setAnimationSub(eyes)
    end
    if xi.dynamis.mobList[zoneID][oMobIndex].nmchildren then
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
    if xi.dynamis.mobList[zoneID][oMobIndex].mobchildren then
        xi.dynamis.normalDynamicSpawn(mob, oMobIndex, target) -- Normies have their own loop, so they don't need one here.
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
                -- [JobID] = {Name, groupId, groupZoneId, SpellList, SkillList},
            --},
            -- [ZoneID] -- If applicable
            --{
                -- [FloorVar]
                -- {
                    -- [JobID] = {Name, groupId, groupZoneId, SpellList, SkillList},
                -- },
            --},
            -- [JobID] = {Name, groupId, groupZoneId, SpellList, SkillList},
        --},
        [4] = -- Vanguard Eye
        {
            [xi.zone.DYNAMIS_BEAUCEDINE] = -- Spawn Hydras (Done)
            {
                [1]  = {"48574152", 159, 134, 0, 359}, -- HWAR
                [2]  = {"484d4e4b", 163, 134, 0, 359}, -- HMNK
                [3]  = {"4857484d", 161, 134, 1, 359}, -- HWHM
                [4]  = {"48424c4d", 164, 134, 497, 359}, -- HBLM
                [5]  = {"4852444d", 162, 134, 3, 359}, -- HRDM
                [6]  = {"48544846", 160, 134, 0, 359}, -- HTHF
                [7]  = {"48504c44", 166, 134, 4, 359}, -- HPLD
                [8]  = {"4844524b", 167, 134, 5, 359}, -- HDRK
                [9]  = {"48425354", 168, 134, 0, 359}, -- HBST
                [10] = {"48425244", 170, 134, 6, 359}, -- HBRD
                [11] = {"48524e47", 171, 134, 0, 359}, -- HRNG
                [12] = {"4853414d", 172, 134, 0, 359}, -- HSAM
                [13] = {"484e494e", 173, 134, 7, 359}, -- HNIN
                [14] = {"48445247", 174, 134, 0, 359}, -- HDRG
                [15] = {"48534d4e", 176, 134, 0, 359}, -- HSMN
            },
            [xi.zone.DYNAMIS_XARCABARD] = -- Spawn Kindred (Done)
            {
                [1]  = {"4b574152", 32, 135, 0, 358}, -- KWAR
                [2]  = {"4b4d4e4b", 33, 135, 0, 358}, -- KMNK
                [3]  = {"4b57484d", 29, 135, 1, 358}, -- KWHM
                [4]  = {"4b424c4d", 30, 135, 497, 358}, -- KBLM
                [5]  = {"4b52444d", 31, 135, 3, 358}, -- KRDM
                [6]  = {"4b544846", 34, 135, 0, 358}, -- KTHF
                [7]  = {"4b504c44", 15, 135, 4, 358}, -- KPLD
                [8]  = {"4b44524b", 16, 135, 5, 358}, -- KDRK
                [9]  = {"4b425354", 17, 135, 0, 358}, -- KBST
                [10] = {"4b425244", 20, 135, 6, 358}, -- KBRD
                [11] = {"4b524e47", 19, 135, 0, 358}, -- KRNG
                [12] = {"4b53414d", 22, 135, 0, 358}, -- KSAM
                [13] = {"4b4e494e", 23, 135, 7, 358}, -- KNIN
                [14] = {"4b445247", 27, 135, 0, 358}, -- KDRG
                [15] = {"4b534d4e", 24, 135, 0, 358}, -- KSMN
            },
            [xi.zone.DYNAMIS_TAVNAZIA] = -- Spawn Kindred and Hydra
            {
                [2] = -- Floor 2 Spawn Hydras (Done)
                {
                    [1]  = {"48574152", 159, 134, 0, 359}, -- HWAR
                    [2]  = {"484d4e4b", 163, 134, 0, 359}, -- HMNK
                    [3]  = {"4857484d", 161, 134, 1, 359}, -- HWHM
                    [4]  = {"48424c4d", 164, 134, 497, 359}, -- HBLM
                    [5]  = {"4852444d", 162, 134, 3, 359}, -- HRDM
                    [6]  = {"48544846", 160, 134, 0, 359}, -- HTHF
                    [7]  = {"48504c44", 166, 134, 4, 359}, -- HPLD
                    [8]  = {"4844524b", 167, 134, 5, 359}, -- HDRK
                    [9]  = {"48425354", 168, 134, 0, 359}, -- HBST
                    [10] = {"48425244", 170, 134, 6, 359}, -- HBRD
                    [11] = {"48524e47", 171, 134, 0, 359}, -- HRNG
                    [12] = {"4853414d", 172, 134, 0, 359}, -- HSAM
                    [13] = {"484e494e", 173, 134, 7, 359}, -- HNIN
                    [14] = {"48445247", 174, 134, 0, 359}, -- HDRG
                    [15] = {"48534d4e", 176, 134, 0, 359}, -- HSMN
                },
                [3] = -- Floor 3 Spawn Kindred (Done)
                {
                    [1]  = {"4b574152", 32, 135, 0, 358}, -- KWAR
                    [2]  = {"4b4d4e4b", 33, 135, 0, 358}, -- KMNK
                    [3]  = {"4b57484d", 29, 135, 1, 358}, -- KWHM
                    [4]  = {"4b424c4d", 30, 135, 497, 358}, -- KBLM
                    [5]  = {"4b52444d", 31, 135, 3, 358}, -- KRDM
                    [6]  = {"4b544846", 34, 135, 0, 358}, -- KTHF
                    [7]  = {"4b504c44", 15, 135, 4, 358}, -- KPLD
                    [8]  = {"4b44524b", 16, 135, 5, 358}, -- KDRK
                    [9]  = {"4b425354", 17, 135, 0, 358}, -- KBST
                    [10] = {"4b425244", 20, 135, 6, 358}, -- KBRD
                    [11] = {"4b524e47", 19, 135, 0, 358}, -- KRNG
                    [12] = {"4b53414d", 22, 135, 0, 358}, -- KSAM
                    [13] = {"4b4e494e", 23, 135, 7, 358}, -- KNIN
                    [14] = {"4b445247", 27, 135, 0, 358}, -- KDRG
                    [15] = {"4b534d4e", 24, 135, 0, 358}, -- KSMN
                },
            },
        },
        [92] = -- Goblin Replica (Done)
        {
            [1]  = {"47574152", 159, 134, 0, 327}, -- GWAR
            [2]  = {"474d4e4b", 163, 134, 0, 327}, -- GMNK
            [3]  = {"4757484d", 161, 134, 1, 327}, -- GWHM
            [4]  = {"47424c4d", 164, 134, 497, 327}, -- GBLM
            [5]  = {"4752444d", 162, 134, 3, 327}, -- GRDM
            [6]  = {"47544846", 160, 134, 0, 327}, -- GTHF
            [7]  = {"47504c44", 166, 134, 4, 327}, -- GPLD
            [8]  = {"4744524b", 167, 134, 5, 327}, -- GDRK
            [9]  = {"47425354", 168, 134, 0, 327}, -- GBST
            [10] = {"47425244", 170, 134, 6, 327}, -- GBRD
            [11] = {"47524e47", 171, 134, 0, 327}, -- GRNG
            [12] = {"4753414d", 172, 134, 0, 327}, -- GSAM
            [13] = {"474e494e", 173, 134, 7, 327}, -- GNIN
            [14] = {"47445247", 174, 134, 0, 327}, -- GDRG
            [15] = {"47534d4e", 176, 134, 0, 327}, -- GSMN
        },
        [93] = -- Orc Statue (Done)
        {
            [1]  = {"4f574152", 159, 134, 0, 334}, -- OWAR
            [2]  = {"4f4d4e4b", 163, 134, 0, 334}, -- OMNK
            [3]  = {"4f57484d", 161, 134, 1, 334}, -- OWHM
            [4]  = {"4f424c4d", 164, 134, 497, 334}, -- OBLM
            [5]  = {"4f52444d", 162, 134, 3, 334}, -- ORDM
            [6]  = {"4f544846", 160, 134, 0, 334}, -- OTHF
            [7]  = {"4f504c44", 166, 134, 4, 334}, -- OPLD
            [8]  = {"4f44524b", 167, 134, 5, 334}, -- ODRK
            [9]  = {"4f425354", 168, 134, 0, 334}, -- OBST
            [10] = {"4f425244", 170, 134, 6, 334}, -- OBRD
            [11] = {"4f524e47", 171, 134, 0, 334}, -- ORNG
            [12] = {"4f53414d", 172, 134, 0, 334}, -- OSAM
            [13] = {"4f4e494e", 173, 134, 7, 334}, -- ONIN
            [14] = {"4f445247", 174, 134, 0, 334}, -- ODRG
            [15] = {"4f534d4e", 176, 134, 0, 334}, -- OSMN
        },
        [94] = -- Quadav Statue (Done)
        {
            [1]  = {"51574152", 19, 134, 0, 337}, -- QWAR
            [2]  = {"514d4e4b", 25, 134, 0, 337}, -- QMNK
            [3]  = {"5157484d", 29, 134, 1, 337}, -- QWHM
            [4]  = {"51424c4d", 42, 134, 497, 337}, -- QBLM
            [5]  = {"5152444d", 20, 134, 3, 337}, -- QRDM
            [6]  = {"51544846", 33, 134, 0, 337}, -- QTHF
            [7]  = {"51504c44", 30, 134, 4, 337}, -- QPLD
            [8]  = {"5144524b", 38, 134, 5, 337}, -- QDRK
            [9]  = {"51425354", 21, 134, 0, 337}, -- QBST
            [10] = {"51425244", 23, 134, 6, 337}, -- QBRD
            [11] = {"51524e47", 34, 134, 0, 337}, -- QRNG
            [12] = {"5153414d", 31, 134, 0, 337}, -- QSAM
            [13] = {"514e494e", 32, 134, 7, 337}, -- QNIN
            [14] = {"51445247", 26, 134, 0, 337}, -- QDRG
            [15] = {"51534d4e", 35, 134, 0, 337}, -- QSMN
        },
        [95] = -- Yagudo Statue
        {
            [1]  = {"59574152", 159, 134, 0, 360}, -- YWAR
            [2]  = {"594d4e4b", 163, 134, 0, 360}, -- YMNK
            [3]  = {"5957484d", 161, 134, 1, 360}, -- YWHM
            [4]  = {"59424c4d", 164, 134, 497, 360}, -- YBLM
            [5]  = {"5952444d", 162, 134, 3, 360}, -- YRDM
            [6]  = {"59544846", 160, 134, 0, 360}, -- YTHF
            [7]  = {"59504c44", 166, 134, 4, 360}, -- YPLD
            [8]  = {"5944524b", 167, 134, 5, 360}, -- YDRK
            [9]  = {"59425354", 168, 134, 0, 360}, -- YBST
            [10] = {"59425244", 170, 134, 6, 360}, -- YBRD
            [11] = {"59524e47", 171, 134, 0, 360}, -- YRNG
            [12] = {"5953414d", 172, 134, 0, 360}, -- YSAM
            [13] = {"594e494e", 173, 134, 7, 360}, -- YNIN
            [14] = {"59445247", 174, 134, 0, 360}, -- YDRG
            [15] = {"59534d4e", 176, 134, 0, 360}, -- YSMN
        },
        [359] = -- Hydra NM
        {
            [1]  = {"48574152", 159, 134, 0, 359}, -- HWAR
            [2]  = {"484d4e4b", 163, 134, 0, 359}, -- HMNK
            [3]  = {"4857484d", 161, 134, 1, 359}, -- HWHM
            [4]  = {"48424c4d", 164, 134, 497, 359}, -- HBLM
            [5]  = {"4852444d", 162, 134, 3, 359}, -- HRDM
            [6]  = {"48544846", 160, 134, 0, 359}, -- HTHF
            [7]  = {"48504c44", 166, 134, 4, 359}, -- HPLD
            [8]  = {"4844524b", 167, 134, 5, 359}, -- HDRK
            [9]  = {"48425354", 168, 134, 0, 359}, -- HBST
            [10] = {"48425244", 170, 134, 6, 359}, -- HBRD
            [11] = {"48524e47", 171, 134, 0, 359}, -- HRNG
            [12] = {"4853414d", 172, 134, 0, 359}, -- HSAM
            [13] = {"484e494e", 173, 134, 7, 359}, -- HNIN
            [14] = {"48445247", 174, 134, 0, 359}, -- HDRG
            [15] = {"48534d4e", 176, 134, 0, 359}, -- HSMN
        },
        ["Drops"] =
        {
            [xi.zone.DYNAMIS_BASTOK] =
            {
                [337] = {2558}, -- Quadav,
            },
            [xi.zone.DYNAMIS_BEAUCEDINE] =
            {
                [337] = {2557}, -- Quadav
                [334] = {2547}, -- Orc
                [327] = {2542}, -- Goblin
                [360] = {2552}, -- Yagudo
                [359] = {3220}, -- Hydra
            },
            [xi.zone.DYNAMIS_BUBURIMU] =
            {
                [337] = {2555}, -- Quadav
                [334] = {2545}, -- Orc
                [327] = {2540}, -- Goblin
                [360] = {2550}, -- Yagudo
            },
            [xi.zone.DYNAMIS_JEUNO] =
            {
                [327] = {2543}, -- Goblin
            },
            [xi.zone.DYNAMIS_QUFIM] =
            {
                [337] = {2556}, -- Quadav
                [334] = {2546}, -- Orc
                [327] = {2541}, -- Goblin
                [360] = {2551}, -- Yagudo
            },
            [xi.zone.DYNAMIS_SAN_DORIA] =
            {
                [334] = {2548}, -- Orc
            },
            [xi.zone.DYNAMIS_TAVNAZIA] =
            {
                [359] = {0}, -- Hydra
                [358] = {0}, -- Kindred
            },
            [xi.zone.DYNAMIS_VALKURM] =
            {
                [337] = {3131}, -- Quadav
                [334] = {2544}, -- Orc
                [327] = {2539}, -- Goblin
                [360] = {2549}, -- Yagudo
            },
            [xi.zone.DYNAMIS_WINDURST] =
            {
                [360] = {2553}, -- Yagudo
            },
            [xi.zone.DYNAMIS_XARCABARD] =
            {
                [358] = {1442}, -- Kindred
            }
        }
    }

    for job, number in pairs(xi.dynamis.mobList[mobZoneID][oMobIndex].mobchildren) do
        local indexJob = 1
        local indexEndJob = number
        local nameObj = nil
        if oMob:getFamily() == 4 then
            if oMob:getLocalVar("Floor") == 2 or oMob:getLocalVar("Floor") == 3 then
                nameObj = normalMobLookup[mobFamily][mobZoneID][oMob:getLocalVar("Floor")]
            else
                nameObj = normalMobLookup[mobFamily][mobZoneID]
            end
        else
            nameObj = normalMobLookup[mobFamily]
        end
        while (indexJob <= indexEndJob) do
            local mob = zone:insertDynamicEntity({
                objtype = xi.objType.MOB,
                name = nameObj[job][1],
                x = oMob:getXPos()+math.random()*6-3,
                y = oMob:getYPos()-0.3,
                z = oMob:getXPos()+math.random()*6-3,
                rotation = oMob:getRotPos(),
                groupId = nameObj[job][2],
                groupZoneId = nameObj[job][3],
                onMobSpawn = function(mob) xi.dynamis.setMobStats(mob) end,
                onMobEngaged = function(mob, target) xi.dynamis.mobOnEngaged(mob, target) end,
                onMobRoam = function(mob) end,
                onMobDeath = function(mob, playerArg, isKiller)
                    xi.dynamis.mobOnDeath(mob)
                end,
                releaseIdOnDeath = true,
                mixins =
                {
                    require("scripts/mixins/job_special"),
                },
            })
            mob:setSpawn(oMob:getXPos()+math.random()*6-3, oMob:getYPos()-0.3, oMob:getZPos()+math.random()*6-3, oMob:getRotPos())
            mob:spawn()
            mob:setDropID(normalMobLookup["Drops"][mob:getZoneID()][mob:getFamily()][1])
            if nameObj[job][4] ~= nil then -- If SpellList ~= nil set SpellList
                mob:setSpellList(nameObj[job][4])
            end
            if nameObj[job][5] ~= nil then -- If SkillList ~= nil set SkillList
                mob:setMobMod(xi.mobMod.SKILL_LIST, nameObj[job][5])
            end
            if oMob ~= nil and oMob ~= 0 then
                mob:setLocalVar("Parent", oMob:getID())
                mob:updateEnmity(target)
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
            ["Vanguard Eye"] = {"56457965" , 163, 134, 2561, 497, 11}, -- Vanguard Eye (VEye)
            ["Prototype Eye"] = {"50457965" , 61, 42, 2561, 497, 11}, -- Prototype Eye (PEye)
            ["Goblin Statue"] = {"4753746174" , 158, 134, 1144, 1, 92}, -- Goblin Statue (GStat)
            ["Goblin Replica"] = {"475253746174" , 157, 134, 1144, 1, 92}, -- Goblin Statue (GRStat)
            ["Statue Prototype"] = {"475053746174" , 36, 42, 1144, 1, 92}, -- Goblin Statue (GPStat)
            ["Serjeant Tombstone"] = {"4f53746174" , 89, 134, 2201, 497, 93}, -- Orc Statue (OStat)
            ["Warchief Tombstone"] = {"4f5753746174" , 90, 134, 2201, 50, 93}, -- Orc Statue (OWStat)
            ["Tombstone Prototype"] = {"545053746174" , 20, 42, 2201, 497, 93}, -- Orc Statue (TPStat)
            ["Adamantking Effigy"] = {"5153746174" , 55, 134, 20, 0, 94}, -- Quadav Statue (QStat)
            ["Adamantking Image"] = {"514953746174" , 56, 134, 20, 0, 94}, -- Quadav Statue (QIStat)
            ["Effigy Prototype"] = {"515053746174" , 9, 42, 20, 0, 94}, -- Quadav Statue (QPStat)
            ["Avatar Idol"] = {"5953746174" , 124, 134, 195, 497, 95}, -- Yagudo Statue (YStat)
            ["Manifest Icon"] = {"594d53746174" , 68, 39, 195, 497, 95}, -- Yagudo Statue (YMStat)
            ["Avatar Icon"] = {"414953746174" , 123, 134, 195, 497, 95}, -- Yagudo Statue (AIStat)
            ["Icon Prototype"] = {"595053746174" , 32, 42, 195, 497, 95}, -- Yagudo Statue (YPStat)
        },
        ["Nightmare"] =
        {
            ["Nightmare Bunny"] = {"4e42756e" , 97, 40, 1789, 0, 206}, -- NBun
            ["Nightmare Cockatrice"] = {"4e436f63" , 19, 174, 1805, 0, 70}, -- NCoc
            ["Nightmare Crab"] = {"4e437261" , 93, 40, 1791, 0, 77}, -- NCra
            ["Nightmare Crawler"] = {"4e637261" , 99, 40, 1798, 0, 79}, -- Ncra
            ["Nightmare Dhalmel"] = {"4e446861" , 94, 40, 2796, 0, 80}, -- NDha
            ["Nightmare Eft"] = {"4e446861" , 101, 40, 2795, 0, 98}, -- NEft
            ["Nightmare Mandragora"] = {"4e4d616e" , 98, 40, 1789, 0, 178}, -- NMan
            ["Nightmare Raven"] = {"4e526176" , 100, 40, 1788, 0, 55}, -- NRav
            ["Nightmare Scorpion"] = {"4e53636f" , 96, 40, 1787, 0, 217}, -- NSco
            ["Nightmare Urganite"] = {"4e557267" , 95, 40, 1785, 0, 251}, -- NUrg
            ["Nightmare Cluster"] = {"4e436c75" , 130, 134, 0, 0, 68}, -- NClu
            ["Nightmare Hornet"] = {"4e486f72" , 130, 134, 0, 0, 48}, -- NHor
            ["Nightmare Leech"] = {"4e4c6565" , 130, 134, 0, 0, 172}, -- NLee
            ["Nightmare Makara"] = {"4e4d616b" , 130, 134, 0, 0, 197}, -- NMak
            ["Nightmare Taurus"] = {"4e546175" , 130, 134, 0, 0, 240}, -- NTau
            ["Nightmare Antlion"] = {"4e416e74" , 130, 134, 0, 0, 26}, -- NAnt
            ["Nightmare Bugard"] = {"4e427567" , 130, 134, 0, 0, 58}, -- NBug
            ["Nightmare Worm"] = {"4e576f72" , 130, 134, 0, 0, 258}, -- NWor
            ["Nightmare Hippogryph"] = {"4e486970" , 2, 39, 1792, 0, 141}, -- NHip
            ["Nightmare Manticore"] = {"4e4d6174" , 3, 39, 1799, 0, 179}, -- NMat
            ["Nightmare Sabotender"] = {"4e536162" , 11, 39, 1792, 0, 212}, -- NSab
            ["Nightmare Sheep"] = {"4e536865" , 13, 39, 1794, 0, 226}, -- NShe
            ["Nightmare Fly"] = {"4e466c79" , 4, 39, 1794, 0, 113}, -- NFly
            ["Nightmare Gaylas"] = {"4e476179" , 80, 41, 1793, 0, 47}, -- NGay
            ["Nightmare Kraken"] = {"4e4b7261" , 75, 41, 1793, 0, 218}, -- NKra
            ["Nightmare Raptor"] = {"4e526170" , 84,41, 1793, 0, 210}, -- NRap
            ["Nightmare Roc"] = {"4e526f63" , 83, 41, 1793, 0, 125}, -- NRoc
            ["Nightmare Snoll"] = {"4e536e6f" , 86, 41, 1803, 0, 232}, -- NSno
            ["Nightmare Diremite"] = {"4e446972" , 82, 41, 1790, 0, 81}, -- NDir
            ["Nightmare Stirge"] = {"4e537469" , 78, 41, 1804, 0, 46}, -- NSti
            ["Nightmare Tiger"] = {"4e546967" , 81, 41, 1804, 0, 242}, -- NTig
            ["Nightmare Weapon"] = {"4e576561" , 77, 41, 1804, 0, 110}, -- NWea
        },
        ["Elemental"] =
        {
            ["Fire Elemental"] = {"46456c65", 14, 38, 0, 17, 0}, -- FEle
            ["Water Elemental"] = {"57456c65", 17, 38, 0, 15, 0}, -- WEle
            ["Thunder Elemental"] = {"54456c65", 18, 38, 0, 16, 0}, -- TEle
            ["Earth Elemental"] = {"45456c65", 13, 38, 0, 13, 0}, -- EEle
            ["Air Elemental"] = {"41456c65", 11, 38, 0, 12, 0}, -- AEle
            ["Ice Elemental"] = {"49456c65", 15, 38, 0, 14, 0}, -- IEle
            ["Light Elemental"] = {"4c456c65", 16, 38, 0, 19, 0}, -- LEle
            ["Dark Elemental"] = {"44456c65", 12, 38, 0, 18, 0}, -- DEle
        },
        ["Beastmen"] = 
        {
            ["Vanguard Vindicator"] = {"51574152", 19, 134, 2558, 0, 337}, -- QWAR (Bastok)
            ["Vanguard Constable"] = {"5157484d", 29, 134, 2558,1, 337}, -- QWHM (Bastok)
            ["Vanguard Militant"] = {"514d4e4b", 25, 134, 2558, 0, 337}, -- QMNK (Bastok)
            
        },
        ["Other"] =
        {
            ["Vanguard Dragon"] = {"56447261", 70, 135, 2559, 0, 87}, -- VDra
        },
    }
    local mobFunctions =
    {
        ["Statue"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.setStatueStats(mob, mobIndex) end},
            ["onMobEngaged"] = {function(mob, target) xi.dynamis.parentOnEngaged(mob, target) end},
            ["onMobFight"] = {function(mob) xi.dynamis.statueOnFight(mob) end},
            ["onMobRoam"] = {function(mob) xi.dynamis.mobOnRoam(mob) end},
            ["mixins"] = { }
        },
        ["Nightmare"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.setMobStats(mob) mob:setRoamFlags(xi.roamFlag.NONE) end},
            ["onMobEngaged"] = {function(mob, target) xi.dynamis.parentOnEngaged(mob, target) end},
            ["onMobFight"] = {function(mob) xi.dynamis.statueOnFight(mob) end},
            ["onMobRoam"] = {function(mob) end},
            ["mixins"] = { }
        },
        ["Beastmen"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.setMobStats(mob) end},
            ["onMobEngaged"] = {function(mob, target) xi.dynamis.mobOnEngaged(mob, target) end},
            ["onMobFight"] = {function(mob) end},
            ["onMobRoam"] = {function(mob) end},
            ["mixins"] = { require("scripts/mixins/job_special"), }
        },
        ["Other"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.setMobStats(mob) end},
            ["onMobEngaged"] = {function(mob, target) xi.dynamis.mobOnEngaged(mob, target) end},
            ["onMobFight"] = {function(mob) end},
            ["onMobRoam"] = {function(mob) end},
            ["mixins"] = { }
        },
    }
    local mob = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
        name = nonStandardLookup[mobMobType][mobName][1],
        x = xPos,
        y = yPos,
        z = zPos,
        rotation = rPos,
        groupId = nonStandardLookup[mobMobType][mobName][2],
        groupZoneId = nonStandardLookup[mobMobType][mobName][3],
        onMobSpawn = mobFunctions[mobMobType]["onMobSpawn"][1],
        onMobEngaged = mobFunctions[mobMobType]["onMobEngaged"][1],
        onMobFight = mobFunctions[mobMobType]["onMobFight"][1],
        onMobRoam =  mobFunctions[mobMobType]["onMobRoam"][1],
        onMobDeath = function(mob, playerArg, isKiller)
            xi.dynamis.mobOnDeath(mob)
        end,
        releaseIdOnDeath = true,
        mixins = mobFunctions[mobMobType]["mixins"],
    })
    mob:setSpawn(xPos, yPos, zPos, rPos)
    mob:spawn()
    mob:getZone():setLocalVar(string.format("MobIndex_%s", mob:getID()), mobIndex)
    mob:setLocalVar(string.format("MobIndex_%s", mob:getID()), mobIndex)
    mob:setDropID(nonStandardLookup[mobMobType][mobName][4])
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
        if forceLink == 1 then mob:updateEnmity(oMob:getTarget()) end
    end
end

xi.dynamis.nmDynamicSpawn = function(mobIndex, oMobIndex, forceLink, zoneID, target, oMob, mainDynaLord)
    local zone = GetZone(zoneID)
    local xPos = 0
    local yPos = 0
    local zPos = 0
    local rPos = 0
    if mobIndex == nil then
        return
    end
    if oMob ~= nil then
        local oMobID = oMob:getID()
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
        -- Dynamis - Beaucedine
        ["Ascetox Ratgums"] = {"41736365", 143, 134, 176, 497, 1213, "Beastmen"}, -- Asce (BLM)
        ["Bordox Kittyback"] = {"426f7264", 146, 134, 176, 0, 1213, "Beastmen"}, -- Bord (THF)
        ["Brewnix Bittypupils"] = {"42726577", 142, 134, 176, 1, 1213, "Beastmen"}, -- Brew (WHM)
        ["Draklix Scalecrust"] = {"4472616b", 149, 134, 176, 0, 1213, "Beastmen"}, -- Drak (DRG)
        ["Droprix Granitepalms"] = {"44726f70", 139, 134, 176, 0, 1213, "Beastmen"}, -- Drop (MNK)
        ["Gibberox Pimplebeak"] = {"47696262", 144, 134, 176, 3, 1213, "Beastmen"}, -- Gibb (RDM)
        ["Moltenox Stubthumbs"] = {"4d6f6c74", 136, 134, 176, 0, 1213, "Beastmen"}, -- Molt (WAR)
        ["Morblox Chubbychin"] = {"4d6f7262", 153, 134, 176, 0, 1213, "Beastmen"}, -- Morb (SMN)
        ["Routsix Rubbertendon"] = {"526f7574", 151, 134, 176, 0, 1213, "Beastmen"}, -- Rout (BST)
        ["Ruffbix Jumbolobes"] = {"52756666", 148, 134, 176, 4, 1213, "Beastmen"}, -- Ruff (PLD)
        ["Shisox Widebrow"] = {"53686973", 156, 134, 176, 0, 1213, "Beastmen"}, -- Shis (SAM)
        ["Slinkix Trufflesniff"] = {"536c696e", 155, 134, 176, 0, 1213, "Beastmen"}, -- Slin (RNG)
        ["Swypestix Tigershins"] = {"53777970", 145, 134, 176, 7, 1213, "Beastmen"}, -- Swyp (NIN)
        ["Tocktix Thinlids"] = {"546f636b", 150, 134, 176, 5, 1213, "Beastmen"}, -- Tock (DRK)
        ["Whistix Toadthroat"] = {"57686973", 34, 188, 176, 6, 1213, "Beastmen"}, -- Whis (BRD)
        -- Dynamis - Buburimu
        ["Gosspix Blabberlips"] = {"476f7373", 144, 134,2667, 1213, "Beastmen"}, -- Goss (RDM)
        ["Shamblix Rottenheart"] = {"5368616d", 150, 134,2667, 5, 1213, "Beastmen"}, -- Sham (DRK)
        ["Woodnix Shrillwhistle"] = {"576f6f64", 151, 134, 2667, 0, 1213, "Beastmen"}, -- Wood (BST)
        -- Dynamis - Jeuno
        ["Bandrix Rockjaw"] = {"42616e64", 146, 134, 143, 0, 1213, "Beastmen"}, -- Band (THF)
        ["Buffrix Eargone"] = {"42756666", 148, 134, 143, 4, 1213, "Beastmen"}, -- Buff (PLD)
        ["Clocktix Longnail"] = {"436c6f63", 150, 134, 143, 5, 1213, "Beastmen"}, -- Cloc (DRK)
        ["Elixmix Hooknose"] = {"456c6978", 142, 134, 143, 1, 1213, "Beastmen"}, -- Elix (WHM)
        ["Gabblox Magpietongue"] = {"47616262", 144, 134, 143, 3, 1213, "Beastmen"}, -- Gabb (RDM)
        ["Hermitrix Toothrot"] = {"4865726d", 143, 134, 143, 497, 1213, "Beastmen"}, -- Herm (BLM)
        ["Humnox Dumbelly"] = {"48756d6e", 34, 188, 143, 6, 1213, "Beastmen"}, -- Humn (BRD)
        ["Lurklox Dhalmelneck"] = {"4c75726b", 155, 134, 143, 0, 1213, "Beastmen"}, -- Lurk (RNG)
        ["Morgmox Moldnoggin"] = {"4d6f7267", 153, 134, 143, 0, 1213, "Beastmen"}, -- Morg (SMN)
        ["Sparkspox Sweatbrow"] = {"53706172", 136, 134, 143, 0, 1213, "Beastmen"}, -- Spar (WAR)
        ["Ticktox Beadeyes"] = {"5469636b", 150, 134, 143, 5, 1213, "Beastmen"}, -- Tick (DRK)
        ["Trailblix Goatmug"] = {"54726169", 151, 134, 143, 0, 1213, "Beastmen"}, -- Trai (BST)
        ["Tufflix Loglimbs"] = {"54756666", 148, 134, 143, 4, 1213, "Beastmen"}, -- Tuff (PLD)
        ["Wyrmwix Snakespecs"] = {"536e616b", 149, 134, 143, 0, 1213, "Beastmen"}, -- Snak (DRG)
        ["Karashix Swollenskull"] = {"4b617261", 156, 134, 143, 0, 1213, "Beastmen"}, -- Kara (SAM)
        ["Kikklix Longlegs"] = {"4b696b6b", 139, 134, 143, 0, 1213, "Beastmen"}, -- Kikk (MNK)
        ["Rutrix Hamgams"] = {"52757472", 151, 134, 143, 0, 1213, "Beastmen"}, -- Rutr (BST)
        ["Snypestix Eaglebeak"] = {"536e7970", 145, 134, 143, 7, 1213, "Beastmen"}, -- Snyp (NIN)
        ["Mortilox Wartpaws"] = {"4d6f7274", 153, 134, 143, 0, 1213, "Beastmen"}, -- Mort (SMN)
        ["Jabkix Pigeonpecs"] = {"4a61626b", 139, 134, 143, 0, 1213, "Beastmen"}, -- Jabk (MNK)
        ["Smeltix Thickhide"] = {"536d656c", 136, 134, 143, 0, 1213, "Beastmen"}, -- Smel (WAR)
        ["Wasabix Callusdigit"] = {"57617361", 156, 134, 143, 0, 1213, "Beastmen"}, -- Wasa (SAM)
        ["Anvilix Sootwrists"] = {"416e7669", 136, 134, 143, 0, 1213, "Beastmen"}, -- Anvi (WAR)
        ["Blazox Boneybod"] = {"426c617a", 151, 134, 143, 0, 1213, "Beastmen"}, -- Blaz (BST)
        ["Bootrix Jaggedelbow"] = {"426f6f74", 139, 134, 143, 0, 1213, "Beastmen"}, -- Boot (MNK)
        ["Distilix Stickytoes"] = {"44697374", 142, 134, 143, 1, 1213, "Beastmen"}, -- Dist (WHM)
        ["Eremix Snottynostril"] = {"4572656d", 143, 134, 143, 497, 1213, "Beastmen"}, -- Erem (BLM)
        ["Jabbrox Grannyguise"] = {"4a616262", 144, 134, 143, 3, 1213, "Beastmen"}, -- Jabb (RDM)
        ["Mobpix Mucousmouth"] = {"4d6f6270", 146, 134, 143, 0, 1213, "Beastmen"}, -- Mobp (THF)
        ["Prowlox Barrelbelly"] = {"50726f77", 155, 134, 143, 0, 1213, "Beastmen"}, -- Prow (RNG)
        ["Scruffix Shaggychest"] = {"53637275", 148, 134, 143, 4, 1213, "Beastmen"}, -- Scru (PLD)
        ["Slystix Megapeepers"] = {"536c7973", 145, 134, 143, 7, 1213, "Beastmen"}, -- Slys (NIN)
        ["Tymexox Ninefingers"] = {"54796d65", 150, 134, 143, 5, 1213, "Beastmen"}, -- Tyme (DRK)
        -- Orc
        -- Dynamis - Beaucedine
        ["Cobraclaw Buchzvotch"] = {"43427563", 65, 134, 493, 0, 1200, "Beastmen"}, -- CBuc (MNK)
        ["Deathcaller Bidfbid"] = {"44426964", 73, 134, 493, 0, 1200, "Beastmen"}, -- DBid (SMN)
        ["Drakefeast Wubmfub"] = {"44577562", 88, 134, 493, 0, 1200, "Beastmen"}, -- DWub (DRG)
        ["Elvaanlopper Grokdok"] = {"4547726f", 82, 134, 493, 0, 1200, "Beastmen"}, -- EGro (RNG)
        ["Galkarider Retzpratz"] = {"47526574", 71, 134, 493, 0, 1200, "Beastmen"}, -- GRet (RNG)
        ["Heavymail Djidzbad"] = {"48446a69", 80, 134, 493, 4, 1200, "Beastmen"}, -- HDji (PLD)
        ["Humegutter Adzjbadj"] = {"4841627a", 60, 134, 493, 0, 1200, "Beastmen"}, -- HAbz (WAR)
        ["Jeunoraider Gepkzip"] = {"4a476570", 63, 134, 493, 7, 1200, "Beastmen"}, -- JGep (NIN)
        ["Lockbuster Zapdjipp"] = {"4c5a6170", 79, 134, 493, 0, 1200, "Beastmen"}, -- LZap (THF)
        ["Mithraslaver Debhabob"] = {"4d446562", 85, 134, 493, 0, 1200, "Beastmen"}, -- MDeb (BST)
        ["Skinmask Ugghfogg"] = {"53556767", 83, 134, 493, 5, 1200, "Beastmen"}, -- SUgg (DRK)
        ["Spinalsucker Galflmall"] = {"5347616c", 73, 134, 493, 3, 1200, "Beastmen"}, -- SGal (RDM)
        ["Taruroaster Biggsjig"] = {"54426967", 84, 134, 493, 497, 1200, "Beastmen"}, -- TBig (BLM)
        ["Ultrasonic Zeknajak"] = {"555a656b", 87, 134, 493, 6, 1200, "Beastmen"}, -- UZek (BRD)
        ["Wraithdancer Gidbnod"] = {"57476964", 63, 134, 493, 1, 1200, "Beastmen"}, -- WGid (WHM)
        -- Dynamis Buburimu
        ["Elvaansticker Bxafraff"] = {"456c7661", 88, 134, 760, 0, 1200, "Beastmen"}, -- Elva (DRG)
        ["Flamecaller Zoeqdoq"] = {"466c616d", 84, 134, 760, 497, 1200, "Beastmen"}, -- Flam (BLM)
        ["Hamfist Gukhbuk"] = {"48616d66", 65, 134, 760, 0, 1200, "Beastmen"}, -- Hamf (MNK)
        ["Lyncean Juvgneg"] = {"4c796e63", 82, 134, 760, 0, 1200, "Beastmen"}, -- Lync (RNG)
        -- Dynamis - San d'Oria
        ["Wyrmgnasher Bjakdek"] = {"57797242", 88, 134, 237, 0, 1200, "Beastmen"}, -- WyrB (DRG)
        ["Reapertongue Gadgquok"] = {"52656147", 73, 134, 237, 0, 1200, "Beastmen"}, -- ReaG (SMN)
        ["Voidstreaker Butchnotch"] = {"566f6942", 63, 134, 237, 7, 1200, "Beastmen"}, -- VoiB (NIN)
        ["Battlechoir Gitchfotch"] = {"42617447", 87, 134, 237, 6, 1200, "Beastmen"}, -- BatG (BRD)
        ["Soulsender Fugbrag"] = {"536f7546", 87, 134, 237, 6, 1200, "Beastmen"}, -- SouF (BRD)
        -- Quadav
        -- Dynamis - Beaucedine
        ["Be'Zhe Keeprazer"] = {"42655a68", 53, 134, 261, 0, 1212, "Beastmen"}, -- BeZh (SMN)
        ["De'Bho Pyrohand"] = {"44654268", 43, 134, 261, 497, 1212, "Beastmen"}, --DeBh (BLM)
        ["Ga'Fho Venomtouch"] = {"47614668", 39, 134, 261, 3, 1212, "Beastmen"}, -- GaFh (WHM)
        ["Go'Tyo Magenapper"] = {"476f5479", 44, 134, 261, 0, 1212, "Beastmen"}, -- GoTy (DRG)
        ["Gu'Khu Dukesniper"] = {"47754b68", 50, 134, 261, 0, 1212, "Beastmen"}, -- GuKh (RNG)
        ["Gu'Nha Wallstormer"] = {"47756861", 24, 134, 261, 0, 1212, "Beastmen"}, -- Guha (WAR)
        ["Ji'Fhu Infiltrator"] = {"4a694668", 37, 134, 261, 0, 1212, "Beastmen"}, -- JiFh (THF)
        ["Ji'Khu Towercleaver"] = {"4a694b68", 51, 134, 261, 0, 1212, "Beastmen"}, -- JiKh (SAM)
        ["Mi'Rhe Whisperblade"] = {"4d695268", 52, 134, 261, 7, 1212, "Beastmen"}, -- MiRh (NIN)
        ["Mu'Gha Legionkiller"] = {"4d754768", 47, 134, 261, 4, 1212, "Beastmen"}, -- MuGh (PLD)
        ["Na'Hya Floodmaker"] = {"4e614879", 28, 134, 261, 3, 1212, "Beastmen"}, -- NaHy (RDM)
        ["Nu'Bhi Spiraleye"] = {"4e754268", 41, 134, 261, 6, 1212, "Beastmen"}, -- NuBh (BRD)
        ["So'Gho Adderhandler"] = {"536f4768", 48, 134, 261, 0, 1212, "Beastmen"}, -- SoGh (BST)
        ["So'Zho Metalbender"] = {"536f5a68", 46, 134, 261, 0, 1212, "Beastmen"}, -- SoZh (MNK)
        ["Ta'Hyu Gallanthunter"] = {"54614879", 40, 134, 261, 5, 1212, "Beastmen"}, -- TaHy (DRK)
        -- Dynamis Buburimu
        ["Gi'Bhe Flesheater"] = {"47694268", 39, 134, 2901, 1, 1212, "Beastmen"}, -- GiBh (WHM)
        ["Qu'Pho Bloodspiller"] = {"51755068", 24, 134, 2901, 0, 1212, "Beastmen"}, -- QuPh (WAR)
        ["Te'Zha Ironclad"] = {"54655a68", 47, 134, 2901, 4, 1212, "Beastmen"}, -- TeZh (PLD)
        ["Va'Rhu Bodysnatcher"] = {"56615268", 37, 134, 2901, 0, 1212, "Beastmen"}, -- VaRh (THF)
        -- Dynamis - Bastok (Done)
        ["Aa'Nyu Dismantler"] = {"41614e79", 40, 134, 2907, 5, 1212, "Beastmen"}, -- AaNy (DRK)
        ["Gu'Nhi Noondozer"] = {"47754e68", 53, 134, 2907, 0, 1212, "Beastmen"}, -- GuNh (SMN)
        ["Be'Ebo Tortoisedriver"] = {"42654562", 48, 134, 2907, 0, 1212, "Beastmen"}, -- BeEb (BST)
        ["Gi'Pha Manameister"] = {"47695068", 43, 134, 2907, 497, 1212, "Beastmen"}, -- GiPh (BLM)
        ["Ko'Dho Cannonball"] = {"4b6f4468", 46, 134, 2907, 0, 1212, "Beastmen"}, -- KoDh (MNK)
        ["Ze'Vho Fallsplitter"] = {"5a655668", 40, 134, 2907, 5, 1212, "Beastmen"}, -- ZeVh (DRK)
        ["Effigy Shield PLD"] = {"45504c44", 30, 134, 2907, 4, 1212, "Beastmen"}, -- EPLD (PLD)
        ["Effigy Shield NIN"] = {"45504c44", 32, 134, 2907, 7, 1212, "Beastmen"}, -- ENIN (NIN)
        ["Effigy Shield BRD"] = {"45504c44", 23, 134, 2907, 6, 1212, "Beastmen"}, -- EBRD (BRD)
        ["Effigy Shield DRK"] = {"45504c44", 38, 134, 2907, 5, 1212, "Beastmen"}, -- EDRK (DRK)
        ["Effigy Shield SAM"] = {"45504c44", 31, 134, 2907, 0, 1212, "Beastmen"}, -- ESAM (SAM)
        -- Yagudo
        -- Dynamis - Beaucedine
        ["Bhuu Wjato the Firepool"] = {"42687575", 106, 134, 265, 497, 1201, "Beastmen"}, -- Bhuu (BLM)
        ["Caa Xaza the Madpiercer"] = {"43616158", 107, 134, 265, 3, 1201, "Beastmen"}, -- CaaX (RDM)
        ["Foo Peku the Bloodcloak"] = {"466f6f50", 94, 134, 265, 0, 1201, "Beastmen"}, -- FooP (WAR)
        ["Guu Waji the Preacher"] = {"47757557", 113, 134, 265, 4, 1201, "Beastmen"}, -- GuuW (PLD)
        ["Hee Mida the Meticulous"] = {"4865654d", 120, 134, 265, 0, 1201, "Beastmen"}, -- HeeM (RNG)
        ["Knii Hoqo the Bisector"] = {"4b6e6969", 121, 134, 265, 0, 1201, "Beastmen"}, -- Knii (SAM)
        ["Koo Saxu the Everfast"] = {"4b6f6f53", 102, 134, 265, 1, 1201, "Beastmen"}, -- KooS (WHM)
        ["Kuu Xuka the Nimble"] = {"4b757558", 115, 134, 265, 7, 1201, "Beastmen"}, -- KuuX (NIN)
        ["Maa Zaua the Wyrmkeeper"] = {"4d61615a", 109, 134, 265, 0, 1201, "Beastmen"}, -- MaaZ (DRG)
        ["Nee Huxa the Judgemental"] = {"4e656548", 114, 134, 265, 5, 1201, "Beastmen"}, -- NeeH (DRK)
        ["Puu Timu the Phantasmal"] = {"50757554", 122, 134, 265, 0, 1201, "Beastmen"}, -- PuuT (SMN)
        ["Ryy Qihi the Idolrobber"] = {"52797951", 110, 134, 265, 0, 1201, "Beastmen"}, -- RyyQ (THF)
        ["Soo Jopo the Fiendking"] = {"536f6f4a", 116, 134, 265, 0, 1201, "Beastmen"}, -- SooJ (BST)
        ["Xaa Chau the Roctalon"] = {"58616143", 97, 134, 265, 0, 1201, "Beastmen"}, -- XaaC (MNK)
        ["Xhoo Fuza the Sublime"] = {"58686f6f", 119, 134, 265, 6, 1201, "Beastmen"}, -- Xhoo (BRD)
        -- Dynamis - Buburimu
        ["Baa Dava the Bibliopage"] = {"42616144", 91, 317, 2085, 0, 1201, "Beastmen"}, -- BaaD (SMN)
        ["Doo Peku the Fleetfoot"] = {"446f6f50", 115, 134, 2085, 7, 1201, "Beastmen"}, -- DooP (NIN)
        ["Koo Rahi the Levinblade"] = {"4b6f6f52", 121, 134, 2085, 0, 1201, "Beastmen"}, -- KooR (SAM)
        ["Ree Nata the Melomanic"] = {"5265654e", 119, 134, 2085, 6, 1201, "Beastmen"}, -- ReeN (BRD)
        -- Dynamis - Windurst
        ["Xoo Kaza the Solemn"] = {"586f6f4b", 106, 134, 1560, 497, 1201, "Beastmen"}, -- XooK (BLM)
        ["Haa Pevi the Stentorian"] = {"48616150", 91, 317, 1560, 0, 1201, "Beastmen"}, -- HaaP (SMN)
        ["Wuu Qoho the Razorclaw"] = {"57757551", 97, 134, 1560, 0, 1201, "Beastmen"}, -- WuuQ (MNK)
        ["Loo Hepe the Eyepiercer"] = {"4c6f6f48", 107, 134, 1560, 3, 1201, "Beastmen"}, -- LooH (RDM)
        ["Muu Febi the Steadfast"] = {"4d757546", 113, 134, 1560, 4, 1201, "Beastmen"}, -- MuuF (PLD)
        ["Maa Febi the Steadfast"] = {"4d616146", 113, 134, 1560, 4, 1201, "Beastmen"}, -- MaaF (PLD)
        -- Kindred
        -- Dynamis - Xarcabard
        ["Count Zaebos"] = {"5a616562", 51, 135, 521, 0, 358, "Beastmen"}, -- Zaeb (WAR)
        ["Duke Berith"] = {"42657269", 47, 135, 714, 3, 358, "Beastmen"}, -- Beri (RDM)
        ["Marquis Decarabia"] = {"44656361", 21, 135, 1626, 6, 358, "Beastmen"}, -- Deca (BRD)
        ["Duke Gomory"] = {"476f6d6f", 39, 135, 715, 0, 358, "Beastmen"}, -- Gomo (MNK)
        ["Marquis Andras"] = {"416e6472", 54, 135, 1624, 0, 358, "Beastmen"}, -- Andr (BST)
        ["Prince Seere"] = {"53656572", 43, 135, 2021, 1, 358, "Beastmen"}, -- Seer (WHM)
        ["Duke Scox"] = {"53636f78", 57, 135, 717, 5, 358, "Beastmen"}, -- Scox (DRK)
        ["Marquis Gamygyn"] = {"47616d79", 65, 135, 1628, 7, 358, "Beastmen"}, -- Gamy (NIN)
        ["Marquis Orias"] = {"4f726961", 46, 135, 1630, 497, 358, "Beastmen"}, -- Oria (BLM)
        ["Count Raum"] = {"5261756d", 42, 135, 519, 0, 358, "Beastmen"}, --  Raum (THF)
        ["Marquis Nebiros"] = {"4e656269", 67, 135, 1629, 0, 358, "Beastmen"}, -- Nebi (SMN)
        ["Marquis Sabnak"] = {"5361626e", 49, 135, 1631, 4, 358, "Beastmen"}, -- Sabn (PLD)
        ["Count Vine"] = {"56696e65", 62, 135, 528, 0, 358, "Beastmen"}, -- Vine (SAM)
        ["King Zagan"] = {"5a616761", 60, 135, 1452, 0, 358, "Beastmen"}, -- Zaga (DRG)
        ["Marquis Cimeries"] = {"43696d65", 56, 135, 1625, 0, 358, "Beastmen"}, -- Cime (RNG)
        -- Hydra
        -- Dynamis - Beaucedine
        ["Dagourmarche"] = {"4461676f", 10, 134, 559, 0, 359, "Dagourmarche"}, -- Dago (DRG/BST/SMN)
        ["Goublefaupe"] = {"476f7562", 6, 134, 1211, 499, 359, "Goublefaupe"}, -- Goub (WAR/PLD/RDM)
        ["Mildaunegeux"] = {"4d696c64", 8, 134, 1672, 7, 359, "Mildaunegeux"}, -- Mild (MNK/THF/NIN)
        ["Quiebitiel"] = {"51756965", 7, 134, 2066, 498, 359, "Quiebitiel"}, -- Quie (WHM/BLM/BRD)
        ["Velosareon"] = {"56656c6f", 9, 134, 2574, 5, 359, "Velosareon"}, -- Velo (RNG/SAM/DRK)
        -- Below is used to lookup non-beastmen NMs.
        -- Dynamis - Bastok
        ["Gu'Dha Effigy"] = {"424d62", 1, 186, 2906, 0, 143, "Statue Megaboss"}, -- BMb (Bastok Megaboss)
        -- Dynamis - Jeuno
        ["Goblin Golem"] = {"4a4d62", 1, 188, 1085, 47, 92, "Statue Megaboss"}, -- JMb
        -- Dynamis - San d'Oria
        ["Overlord's Tombstone"] = {"534d62", 1, 185, 1967, 49, 93, "Statue Megaboss"}, -- SMb
        -- Dynamis - Windurst
        ["Tzee Xicu Idol"] = {"574d62", 1, 187, 2510, 50, 95, "Statue Megaboss"}, -- WMb
        -- Dynamis - Xarcabard Non-Beastmen
        ["Animated Hammer"] = {"AHam", 81, 135, 99, 0, 9, "Animated Weapon"}, -- AHam
        ["Animated Staff"] = {"ASta", 87, 135, 108, 0, 23, "Animated Weapon"}, -- ASta
        ["Animated Longsword"] = {"ALon", 84, 135, 104, 0, 24, "Animated Weapon"}, -- ALon
        ["Animated Tabar"] = {"ATab", 88, 135, 109, 0, 8, "Animated Weapon"}, -- ATab
        ["Animated Great Axe"] = {"AGre", 80, 135, 97, 0, 12, "Animated Weapon"}, -- AGre
        ["Animated Claymore"] = {"ACla", 78, 135, 95, 0, 14, "Animated Weapon"}, -- ACla
        ["Animated Spear"] = {"ASpe", 86, 135, 107, 0, 19, "Animated Weapon"}, -- ASpe
        ["Animated Scythe"] = {"AScy", 85, 135, 105, 0, 20, "Animated Weapon"}, -- AScy
        ["Animated Kunai"] = {"AKun", 83, 135, 102, 0, 17, "Animated Weapon"}, -- AKun
        ["Animated Tachi"] = {"ATac", 89, 135, 110, 0, 13, "Animated Weapon"}, -- ATac
        ["Animated Dagger"] = {"ADag", 79, 135, 96, 0, 11, "Animated Weapon"}, -- ADag
        ["Animated Knuckles"] = {"AKnu", 82, 135, 101, 0,15, "Animated Weapon"}, -- AKnu
        ["Animated Longbow"] = {"Alon", 11, 135, 103, 0, 7, "Animated Weapon"}, -- Alon
        ["Animated Gun"] = {"AGun", 12, 135, 98, 0, 18, "Animated Weapon"}, -- AGun
        ["Animated Horn"] = {"AHor", 13, 135, 100, 0, 16, "Animated Weapon"}, -- AHor
        ["Animated Shield"] = {"AShi", 14, 135, 106, 0, 21, "Animated Weapon"}, -- AShi
        ["Satellite Hammer"] = {"5348616d", 81, 135, 0, 0, 9, "Satellite Weapon"}, -- SHam
        ["Satellite Staff"] = {"53537461", 87, 135, 0, 0, 23, "Satellite Weapon"}, -- SSta
        ["Satellite Longsword"] = {"534c6f6e", 84, 135, 0, 0, 24, "Satellite Weapon"}, -- SLon
        ["Satellite Tabar"] = {"53546162", 88, 135, 0, 0, 8, "Satellite Weapon"}, -- STab
        ["Satellite Great Axe"] = {"53477265", 80, 135, 0, 0, 12, "Satellite Weapon"}, -- SGre
        ["Satellite Claymore"] = {"53436c61", 78, 135, 0, 0, 14, "Satellite Weapon"}, -- SCla
        ["Satellite Spear"] = {"53537065", 86, 135, 0, 0, 19, "Satellite Weapon"}, -- SSpe
        ["Satellite Scythe"] = {"53536379", 85, 135, 0, 0, 20, "Satellite Weapon"}, -- SScy
        ["Satellite Kunai"] = {"534b756e", 83, 135, 0, 0, 17, "Satellite Weapon"}, -- SKun
        ["Satellite Tachi"] = {"53546163", 89, 135, 0, 0, 13, "Satellite Weapon"}, -- STac
        ["Satellite Dagger"] = {"53446167", 79, 135, 0, 0, 11, "Satellite Weapon"}, -- SDag
        ["Satellite Knuckles"] = {"534b6e75", 82, 135, 0, 0, 15, "Satellite Weapon"}, -- SKnu
        ["Satellite Longbow"] = {"536c6f6e", 11, 135, 0, 0, 7, "Satellite Weapon"}, -- Slon
        ["Satellite Gun"] = {"5347756e", 12, 135, 0, 0, 18, "Satellite Weapon"}, -- SGun
        ["Satellite Horn"] = {"53486f72", 13, 135, 0, 0, 16, "Satellite Weapon"}, -- SHor
        ["Satellite Shield"] = {"53536869", 14, 135, 0, 0, 21, "Satellite Weapon"}, -- SShi
        ["Ying"] = {"59696e67", 2, 135, 0, 0, 87, "Ying"}, -- Ying
        ["Yang"] = {"59616e67", 3, 135, 0, 0, 87, "Yang"}, -- Yang
        ["Dynamis Lord"] = {"444c", 1, 135, 730, 86, 361, "Dynamis Lord"}, -- DL
        -- Dynamis - Beaucedine Non-Beastmen
        ["Angra Mainyu"] = {"416e6772", 1, 134, 0, 497, 4, "Angra Mainyu"}, -- Angr
        ["Fire Pukis"] = {"4650756b", 2, 135, 0, 0, 87, "Enabled Auto Attack"}, -- FPuk
        ["Wind Pukis"] = {"5750756b", 2, 135, 0, 0, 87, "Enabled Auto Attack"}, -- WPuk
        ["Petro Pukis"] = {"5050756b", 2, 135, 0, 0, 87, "Enabled Auto Attack"}, -- PPuk
        ["Poison Pukis"] = {"7050756b", 2, 135, 0, 0, 87, "Enabled Auto Attack"}, -- pPuk
        ["Dynamis Statue"] = {"44796e53" , 36, 42, 1144, 1, 92, "Enabled Auto Attack"}, -- Dynamis Statue (DynS)
        ["Dynamis Tombstone"] = {"44796e54" , 20, 42, 2201, 497, 93, "Enabled Auto Attack"}, -- Dynamis Tombstone (DynT)
        ["Dynamis Effigy"] = {"44796e45" , 9, 42, 20, 0, 94, "Enabled Auto Attack"}, -- Dynamis Effigy (DynE)
        ["Dynamis Icon"] = {"44796e49" , 32, 42, 195, 497, 95, "Enabled Auto Attack"}, -- Dynamis Icon (DynI)
        -- Dynamis - Buburimu Non-Beastmen
        ["Aitvaras"] = {"41697476", 105, 40, 230, 0, 1209, "Buburimu Dwagon"}, -- Aitv
        ["Alklha"] = {"416c6b6c", 105, 40, 230, 0, 1207, "Buburimu Dwagon"}, -- Alkl
        ["Barong"] = {"4261726f", 105, 40, 230, 0, 1205, "Buburimu Dwagon"}, -- Baro
        ["Basilic"] = {"42617369", 105, 40, 230, 0, 1208, "Buburimu Dwagon"}, -- Basi
        ["Jurik"] = {"4a757269", 105, 40, 230, 0, 1204, "Buburimu Dwagon"}, -- Juri
        ["Koschei"] = {"4b6f7363", 105, 40, 230, 0, 1210, "Buburimu Dwagon"}, -- Kosc
        ["Stihi"] = {"53746968", 105, 40, 230, 0, 11212, "Buburimu Dwagon"}, -- Stih
        ["Stollenwurm"] = {"53746f6c", 105, 40, 230, 0, 1211, "Buburimu Dwagon"}, -- Stol
        ["Tarasca"] = {"54617261", 105, 40, 230, 0, 1206, "Buburimu Dwagon"}, -- Tara
        ["Vishap"] = {"56697368", 105, 40, 230, 0, 1203, "Buburimu Dwagon"}, -- Vish
        ["Apocalyptic Beast"] = {"41706f63", 1, 40, 146, 0, 0, "Apocalyptic Beast"}, -- Apoc
        -- Dynamis - Valkurm
        ["Dragontrap"] = {"44726174", 63, 77, 2910, 0, 114, "No Auto Attack"}, -- Drat
        ["Fairy Ring"] = {"46616952", 10, 39, 2910, 0, 116, "Fairy Ring"}, -- FaiR
        ["Nant'ina"] = {"4e616e74", 8, 39, 2910, 0, 0, "Nant'ina"}, -- Nant
        ["Stcemqestcint"] = {"53746365", 6, 39, 2910, 0, 245, "No Auto Attack"}, -- Stce
        ["Nightmare Morbol"] = {"4e4d6f72", 33, 85, 0, 0, 186, "Nightmare Morbol"}, -- NMor
        ["Cirrate Christelle"] = {"43697272", 1, 39, 472, 0, 0, "Cirrate Christelle"}, -- Cirr
        -- Dynamis - Qufim Non-Beastmen
        ["Scolopendra"] = {"53636f6c", 76, 41, 3131, 0, 218, "Enabled Auto Attack"}, -- Scol
        ["Suttung"] = {"53757474", 85, 41, 3131, 0, 135, "Enabled Auto Attack"}, -- Sutt
        ["Stringes"] = {"53747269", 79, 41, 3131, 0, 46, "Enabled Auto Attack"}, -- Stri
        ["Antaeus"] = {"416e7461", 1, 41, 112, 0, 126, "Antaeus"}, -- Anta
        -- Dynamis - Tavnazia Non-Beastmen
        ["Diabolos Club"] = {"44696143", 4, 42, 0, nil, nil, "Diabolos Club"}, -- DiaC
        ["Diabolos Diamond"] = {"44696144", 3, 42, 0, nil, nil, "Diabolos Diamond"}, -- DiaD
        ["Diabolos Heart"] = {"44696148", 2, 42, 0, nil, nil, "Diabolos Heart"}, -- DiaH
        ["Diabolos Spade"] = {"44696153", 1, 42, 0, nil, nil, "Diabolos Spade"}, -- DiaS
    }
    xi.dynamis.nmFunctions =
    {
        ["Beastmen"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.setMobStats(mob) end},
            ["onMobEngaged"] = {function(mob, target) xi.dynamis.parentOnEngaged(mob, target) xi.dynamis.mobOnEngaged(mob, target) end},
            ["onMobFight"] = {function(mob) end},
            ["onMobRoam"] = {function(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.mobOnDeath(mob, player, isKiller) end},
            ["mixins"] = { require("scripts/mixins/job_special"), require("scripts/mixins/remove_doom") },
        },
        ["Statue Megaboss"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.setMegaBossStats(mob) end},
            ["onMobEngaged"] = {function(mob, target)  xi.dynamis.parentOnEngaged(mob, target) end},
            ["onMobFight"] = {function(mob) end},
            ["onMobRoam"] = {function(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player) end},
            ["mixins"] = { },
        },
        ["Angra Mainyu"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnAngra(mob) end},
            ["onMobEngaged"] = {function(mob, target)  xi.dynamis.parentOnEngaged(mob, target) end},
            ["onMobFight"] = {function(mob, target) xi.dynamis.onFightAngra(mob, target) end},
            ["onMobRoam"] = {function(mob) xi.dynamis.onRoamAngra(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) xi.dynamis.onMagicPrepAngra(mob) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player) end},
            ["mixins"] = { },
        },
        ["Dagourmarche"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnDagour(mob) end},
            ["onMobEngaged"] = {function(mob, target)  xi.dynamis.onEngagedDagour(mob, target) end},
            ["onMobFight"] = {function(mob, target) end},
            ["onMobRoam"] = {function(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) xi.dynamis.onWeaponskillPrepDagour(mob) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.mobOnDeath(mob, player, isKiller) end},
            ["mixins"] = { require("scripts/mixins/job_special"), },
        },
        ["Goublefaupe"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnGouble(mob) end},
            ["onMobEngaged"] = {function(mob, target)  xi.dynamis.parentOnEngaged(mob, target) end},
            ["onMobFight"] = {function(mob, target) end},
            ["onMobRoam"] = {function(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.mobOnDeath(mob, player, isKiller) end},
            ["mixins"] = { require("scripts/mixins/job_special"), },
        },
        ["Mildaunegeux"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnMildaun(mob) end},
            ["onMobEngaged"] = {function(mob, target)  xi.dynamis.parentOnEngaged(mob, target) end},
            ["onMobFight"] = {function(mob, target) end},
            ["onMobRoam"] = {function(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.mobOnDeath(mob, player, isKiller) end},
            ["mixins"] = { require("scripts/mixins/job_special"), },
        },
        ["Quiebitiel"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnQuieb(mob) end},
            ["onMobEngaged"] = {function(mob, target)  xi.dynamis.parentOnEngaged(mob, target) end},
            ["onMobFight"] = {function(mob, target) end},
            ["onMobRoam"] = {function(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.mobOnDeath(mob, player, isKiller) end},
            ["mixins"] = { require("scripts/mixins/job_special"), },
        },
        ["Velosareon"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnVelosar(mob) end},
            ["onMobEngaged"] = {function(mob, target)  xi.dynamis.parentOnEngaged(mob, target) end},
            ["onMobFight"] = {function(mob, target) end},
            ["onMobRoam"] = {function(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.mobOnDeath(mob, player, isKiller) end},
            ["mixins"] = { require("scripts/mixins/job_special"), },
        },

        ["Apocalyptic Beast"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnApoc(mob) end},
            ["onMobEngaged"] = {function(mob, target)  xi.dynamis.onEngagedApoc(mob, target) end},
            ["onMobFight"] = {function(mob, target) xi.dynamis.onFightApoc(mob, target) end},
            ["onMobRoam"] = {function(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob, target) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, isKiller) end},
            ["mixins"] = { },
        },
        ["Antaeus"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnAntaeus(mob) end},
            ["onMobEngaged"] = {function(mob, target)  xi.dynamis.onEngagedAntaeus(mob, target) end},
            ["onMobFight"] = {function(mob, target) xi.dynamis.onFightAntaeus(mob, target) end},
            ["onMobRoam"] = {function(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player) end},
            ["mixins"] = { },
        },
        ["Cirrate Christelle"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnCirrate(mob) end},
            ["onMobEngaged"] = {function(mob, target) xi.dynamis.onEngagedCirrate(mob, target) end},
            ["onMobFight"] = {function(mob, target) xi.dynamis.onFightCirrate(mob, target) end},
            ["onMobRoam"] = {function(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) xi.dynamis.onWeaponskillPrepCirrate(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player) end},
            ["mixins"] = { },
        },
        ["Fairy Ring"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnFairy(mob) end},
            ["onMobEngaged"] = {function(mob, target) end},
            ["onMobFight"] = {function(mob, target) end},
            ["onMobRoam"] = {function(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.mobOnDeath(mob, player, isKiller) end},
            ["mixins"] = { },
        },
        ["Nant'ina"] =
        {
          ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnNoAuto(mob) end},
          ["onMobEngaged"] = {function(mob, target) end},
          ["onMobFight"] = {function(mob, target) end},
          ["onMobRoam"] = {function(mob) end},
          ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
          ["onMobWeaponSkillPrepare"] = {function(mob) xi.dynamis.onWeaponskillPrepNantina(mob) end},
          ["onMobWeaponSkill"] = {function(mob) end},
          ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.mobOnDeath(mob, player, isKiller) end},
          ["mixins"] = { },
        },
        ["Nightmare Morbol"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.setNMStats(mob) end},
            ["onMobEngaged"] = {function(mob, target) end},
            ["onMobFight"] = {function(mob, target) xi.dynamis.onFightMorbol(mob, target) end},
            ["onMobRoam"] = {function(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.mobOnDeath(mob, player, isKiller) end},
            ["mixins"] = { },
        },
        ["Dynamis Lord"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnDynaLord(mob) end},
            ["onMobEngaged"] = {function(mob, target)  xi.dynamis.onEngagedDynaLord(mob, target) end},
            ["onMobFight"] = {function(mob, target) xi.dynamis.onFightDynaLord(mob, target) end},
            ["onMobRoam"] = {function(mob) xi.dynamis.onMobRoamXarc(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target) xi.dynamis.onMagicPrepDynaLord(mob, target) end},
            ["onMobWeaponSkillPrepare"] = {function(mob, target) xi.dynamis.onWeaponskillPrepDynaLord(mob, target) end},
            ["onMobWeaponSkill"] = {function(mob, skill) xi.dynamis.onWeaponskillDynaLord(mob, skill) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.onDeathDynaLord(mob, player, isKiller) end},
            ["mixins"] = { },
        },
        ["Ying"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnYing(mob) end},
            ["onMobEngaged"] = {function(mob, target) end},
            ["onMobFight"] = {function(mob) xi.dynamis.onFightYing(mob, target) end},
            ["onMobRoam"] = {function(mob) xi.dynamis.onMobRoamXarc(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob, target) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.onDeathYing(mob, player, isKiller) end},
            ["mixins"] = { },
        },
        ["Yang"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnYang(mob) end},
            ["onMobEngaged"] = {function(mob, target) end},
            ["onMobFight"] = {function(mob) xi.dynamis.onFightYang(mob, target) end},
            ["onMobRoam"] = {function(mob) xi.dynamis.onMobRoamXarc(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob, target) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.onDeathYang(mob, player, isKiller) end},
            ["mixins"] = { },
        },
        ["Animated Weapon"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnAnimated(mob) end},
            ["onMobEngaged"] = {function(mob, target)  xi.dynamis.onEngagedAnimated(mob, target) end},
            ["onMobFight"] = {function(mob, target) xi.dynamis.onFightAnimated(mob, target) end},
            ["onMobRoam"] = {function(mob) xi.dynamis.onMobRoamXarc(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target) end},
            ["onMobWeaponSkillPrepare"] = {function(mob, target) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.mobOnDeath(mob, player, isKiller) end},
            ["mixins"] = { require("scripts/mixins/families/animated_weapons"), },
        },
        ["Satellite Weapon"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnSatellite(mob) end},
            ["onMobEngaged"] = {function(mob, target) end},
            ["onMobFight"] = {function(mob, target) xi.dynamis.onFightSatellite(mob, target) end},
            ["onMobRoam"] = {function(mob) xi.dynamis.onMobRoamXarc(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob, target) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob) end},
            ["mixins"] = { },
        },
        ["Buburimu Dwagon"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnNoAuto(mob) end},
            ["onMobEngaged"] = {function(mob, target) end},
            ["onMobFight"] = {function(mob, target) xi.dynamis.onFightDwagon(mob, target) end},
            ["onMobRoam"] = {function(mob) xi.dynamis.onRoamDwagon(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.mobOnDeath(mob, player, isKiller) end},
            ["mixins"] = { },
        },
        ["No Auto Attack"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnNoAuto(mob) end},
            ["onMobEngaged"] = {function(mob, target) end},
            ["onMobFight"] = {function(mob, target) end},
            ["onMobRoam"] = {function(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.mobOnDeath(mob, player, isKiller) end},
            ["mixins"] = { },
        },
        ["Enabled Auto Attack"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.setNMStats(mob) end},
            ["onMobEngaged"] = {function(mob, target) end},
            ["onMobFight"] = {function(mob, target) end},
            ["onMobRoam"] = {function(mob) end},
            ["onMobMagicPrepare"] = {function(mob, target, spellId) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.mobOnDeath(mob, player, isKiller) end},
            ["mixins"] = { },
        },
    }
    local mob = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
        name = xi.dynamis.nmInfoLookup[mobName][1],
        x = xPos,
        y = yPos,
        z = zPos,
        rotation = rPos,
        groupId = xi.dynamis.nmInfoLookup[mobName][2],
        groupZoneId = xi.dynamis.nmInfoLookup[mobName][3],
        onMobSpawn = xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobSpawn"][1],
        onMobEngaged= xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobEngaged"][1],
        onMobFight= xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobFight"][1],
        onMobRoam= xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobRoam"][1],
        onMobMagicPrepare= xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobMagicPrepare"][1],
        onMobWeaponSkillPrepare= xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobWeaponSkillPrepare"][1],
        onMobWeaponSkill= xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobWeaponSkill"][1],
        onMobDeath= xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["onMobDeath"][1],
        releaseIdOnDeath = true,
        mixins = xi.dynamis.nmFunctions[xi.dynamis.nmInfoLookup[mobName][7]]["mixins"],
    })
    if oMob ~= nil then
        if mainDynaLord == oMob:getID() and mobName == "Dynamis Lord" then
            mob:setSpawn(target:getXPos(), target:getYPos(), target:getZPos(), target:getRotPos())
            mob:spawn()
            mob:setSpawn(xPos, yPos, zPos, rPos)
            mob:setLocalVar("Clone", 1)
        elseif mainDynaLord == oMob:getID() and mobName == "Ying" or mobName == "Yang" then
            mob:setSpawn(oMob:getXPos(), oMob:getYPos(), oMob:getZPos(), oMob:getRotPos())
            mob:spawn()
            mob:setSpawn(xPos, yPos, zPos, rPos)
        end
    else
        mob:setSpawn(xPos, yPos, zPos, rPos)
        mob:spawn()
    end
    zone:setLocalVar(string.format("MobIndex_%s", mob:getID()), mobIndex)
    mob:setLocalVar(string.format("MobIndex_%s", mob:getID()), mobIndex)
    mob:setLocalVar("MobIndex", mobIndex)
    zone:setLocalVar(string.format("%s", mobIndex), mob:getID())
    mob:setDropID(xi.dynamis.nmInfoLookup[mobName][4])
    if xi.dynamis.nmInfoLookup[mobName][5] ~= nil then -- If SpellList ~= nil set SpellList
        mob:setSpellList(xi.dynamis.nmInfoLookup[mobName][5])
    end
    if xi.dynamis.nmInfoLookup[mobName][6] ~= nil then -- If SkillList ~= nil set SkillList
        mob:setMobMod(xi.mobMod.SKILL_LIST, xi.dynamis.nmInfoLookup[mobName][6])
    end
    if oMobIndex ~= nil then
        mob:setLocalVar("Parent", oMobIndex)
        mob:setLocalVar("ParentID", mob:getID())
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
            --     [false] = {Name, groupId, groupZoneId, Droplist, SpellList, SkillList}, -- Non-NM Pet
            --     [true] -- Is an NM
            --     {
            --          [ParentName] = {Name, groupId, groupZoneId, Droplist, SpellList, SkillList}, -- NM Pet
            --     },
            --   },
        -- },
        -- [Mob's Name (Used for Non-Beastmen NMs)] = {Name, groupId, groupZoneId, Droplist, SpellList, SkillList}, -- NM Pet
        [xi.job.BST] = 
        {
            [327] = -- Goblin Family
            {
                [false] = {"56536c696d65" , 130, 134, 0, 54, 229}, -- Normal Goblin BST (VSlime)
                [true] = -- Goblin NM
                {
                    ["Trailblix Goatmug"] = {"56536c696d65" , 130, 134, 0, 54, 229}, -- NM Goblin BST (VSlime)
                    ["Rutrix Hamgams"] = {"56536c696d65" , 130, 134, 0, 54, 229}, -- NM Goblin BST (VSlime)
                    ["Blazox Boneybod"] = {"56536c696d65", 130, 134, 0, 54, 229}, -- NM Goblin BST (VSlime)
                    ["Routsix Rubbertendon"] = {"56536c696d65" , 130, 134, 0, 54, 229}, -- NM Goblin BST (VSlime)
                    ["Blazax Boneybad"] = {"56536c696d65" , 130, 134, 0, 54, 229}, -- NM Goblin BST (VSlime)
                    ["Woodnix Shrillwistle"] = {"5753536c696d65" , 7, 40, 0, 54, 229}, -- NM Goblin BST (WSSlime)
                },
            },
            [334] = -- Orc Family
            {
                [false] = {"56486563", 77, 134, 0, 51, 139}, -- Normal Orc BST (VHec)
                [true] = -- Orc NM
                {
                    ["Mithraslaver Debhabob"] = {"56486563", 77, 134, 0, 51, 139}, -- NM Orc BST (VHec)
                },
            },
            [337] = -- Quadav Family
            {
                [false] = {"5653636f", 22, 134, 0, 53, 217}, -- Normal Quadav BST (VSco)
                [true] = -- Quadav NM
                {
                    ["So'Gho Adderhandler"] = {"5653636f", 22, 134, 0, 53, 217}, -- NM Quadav BST (VSco)
                    ["Be'Ebo Tortoisedriver"] = {"5653636f", 22, 134, 0, 53, 217}, -- NM Quadav BST (VSco)
                },
            },
            [358] = -- Kindred Family
            {
                [false] = {"4b566f75", 100, 135, 0, 0, 267}, -- Normal Kindred BST (KVou)
                [true] = -- NM Kindred
                {
                    ["Marquis Andras"] = {"41566f75", 55, 135, 0, 0, 267}, -- NM Kindred BST (AVou)
                },
            },
            [359] = -- Hydra Family
            {
                [false] = {"48486f75", 169, 134, 0, 0, 143}, -- Normal Hydra BST (HHou)
                [true] = -- Hydra NM
                {
                    ["Dagourmarche"] = {"44486f75", 169, 134, 0, 0, 143}, -- NM Hydra BST (DHou)
                },
            },
            [360] = -- Yagudo Family
            {
                [false] = {"5643726f", 100, 135, 0, 52, 55}, -- Normal Yagudo BST (VCro)
                [true] = -- Yagudo NM
                {
                    ["Soo Jopo the Fiendking"] = {"5643726f", 100, 135, 0, 52, 55}, -- NM Yagudo BST (VCro)
                },
            },
        },
        [xi.job.DRG] =
        {
            [false] = {"56777976", 27, 134, 0, 0, 714}, -- Normal Vanguard's Wyvern (Vwyv)
            [true] = 
            {
                ["Maa Zaua the Wyrmkeeper"] = {"56777976", 27, 134, 0, 0, 714}, -- Normal Vanguard's Wyvern (Vwyv)
                ["Draklix Scalecrust"] = {"56777976", 27, 134, 0, 0, 714}, -- Normal Vanguard's Wyvern (Vwyv)
                ["Drakefeast Wubmfub"] = {"56777976", 27, 134, 0, 0, 714}, -- Normal Vanguard's Wyvern (Vwyv)
                ["Go'Tyo Magenapper"] = {"56777976", 27, 134, 0, 0, 714}, -- Normal Vanguard's Wyvern (Vwyv)
                ["Elvaansticker Bxafraff"] = {"56777976", 27, 134, 0, 0, 714}, -- Normal Vanguard's Wyvern (Vwyv)
                ["Wyrmgnasher Bjakdek"] = {"56777976", 27, 134, 0, 0, 714}, -- Normal Vanguard's Wyvern (Vwyv)
                ["King Zagan"] = {"5a777976", 61, 135, 0, 0, 714}, -- Zagan's Wyvern (Zwyv)
                ["Dagourmarche"] = {"44577976", 27, 134, 0, 0, 714}, -- Dagourmache's Wyvern (DWyv)
                ["Apocalyptic Beast"] = {"44777976", 27, 134, 0, 0, 714}, -- Dragon's Wyvern (Dwyv)
            },
        },
        [xi.job.SMN] =
        {
            [327] = -- Goblin Family
            {
                [false] = {"56417661" , 36, 134, 0, 0, 34}, -- Vanguard's Avatar (VAva)
                [true] = -- Goblin NM
                {
                    ["Morblox Chubbychin"] = {"56417661" , 36, 134, 0, 0, 34}, -- Vanguard's Avatar (VAva)
                    ["Morgmox Moldnoggin"] = {"56417661" , 36, 134, 0, 0, 34}, -- Vanguard's Avatar (VAva)
                    ["Mortilox Wartpaws"] = {"56417661" , 36, 134, 0, 0, 34}, -- Vanguard's Avatar (VAva)
                },
            },
            [334] = -- Orc Family
            {
                [false] = {"56417661" , 36, 134, 0, 0, 34}, -- Vanguard's Avatar (VAva)
                [true] = -- Orc NM
                {
                    ["Deathcaller Bidfbid"] = {"56417661" , 36, 134, 0, 0, 34}, -- Vanguard's Avatar (VAva)
                    ["Reapertongue Gadgquok"] = {"56417661" , 36, 134, 0, 0, 34}, -- Vanguard's Avatar (VAva)
                },
            },
            [337] = -- Quadav Family
            {
                [false] = {"56417661" , 36, 134, 0, 0, 34}, -- Vanguard's Avatar (VAva)
                [true] = -- Quadav NM
                {
                    ["Be'Zhe Keeprazer"] = {"56417661" , 36, 134, 0, 0, 34}, -- Vanguard's Avatar (VAva)
                    ["Gu'Nhi Noondozer"] = {"56417661" , 36, 134, 0, 0, 34}, -- Vanguard's Avatar (VAva)
                },
            },
            [358] = -- Kindred Family
            {
                [false] = {"4b417661" , 25, 135, 0, 0, 34}, -- Kindred's Avatar (KAva)
                [true] = -- NM Kindred
                {
                    ["Marquis Nebiros"] = {"4e417661", 68, 135, 0, 0, 34}, -- Nebrios's Avatar (NAva)
                },
            },
            [359] = -- Hydra Family
            {
                [false] = {"48417661", 177, 134, 0, 0, 34}, -- Hydra's Avatar (HAva)
                [true] = -- Hydra NM
                {
                    ["Dagourmarche"] = {"44417661", 177, 134, 0, 0, 34}, -- Dagourmache's Avatar (DAva)
                },
            },
            [360] = -- Yagudo Family
            {
                [false] = {"56417661" , 36, 134, 0, 0, 34}, -- Vanguard's Avatar (VAva)
                [true] = -- Yagudo NM
                {
                    ["Baa Dava the Bibliophage"] = {"56417661" , 36, 134, 0, 0, 34}, -- Vanguard's Avatar (VAva)
                    ["Puu Timu the Phantasmal"] = {"56417661" , 36, 134, 0, 0, 34}, -- Vanguard's Avatar (VAva)
                    ["Haa Pevi the Stentorian"] = {"56417661" , 36, 134, 0, 0, 34}, -- Vanguard's Avatar (VAva)
                },
            },
            [87] = -- Dwagon Family
            {
                ["Apocalyptic Beast"] = {"44617661" , 36, 134, 0, 0, 34}, -- Dragon's Avatar (Dava)
            },
        },
    }
    local petFunctions = 
    {
        [xi.job.SMN] =
        {
            ["Apocalyptic Beast"] =
            {
                ["onMobFight"] = {function(mob, target) end},
                ["mixins"] = { require("scripts/mixins/families/avatar"), },
            },
            ["Dagourmarche"] =
            {
                ["onMobFight"] = {function(mob, target) end},
                ["mixins"] = { require("scripts/mixins/families/avatar"), },
            },
            ["Normal"] =
            {
                ["onMobFight"] = {function(mob, target) end},
                ["mixins"] = { },
            },
        },
        [xi.job.BST] =
        {
            ["Dagourmarche"] =
            {
                ["onMobFight"] = {function(mob, target) end},
                ["mixins"] = { },
            },
            ["Normal"] =
            {
                ["onMobFight"] = {function(mob, target) end},
                ["mixins"] = { },
            },
        },
        [xi.job.DRG] =
        {
            ["Apocalyptic Beast"] =
            {
                ["onMobFight"] = {function(mob, target) xi.dynamis.onFightApocDRG(mob, target) end},
                ["mixins"] = { },
            },
            ["Dagourmarche"] =
            {
                ["onMobFight"] = {function(mob, target) end},
                ["mixins"] = { },
            },
            ["Normal"] =
            {
                ["onMobFight"] = {function(mob, target) end},
                ["mixins"] = { },
            },
        },
    }
    local nameFunction = {"Apocalyptic Beast", "Dagourmarche"}
    if mobJob == xi.job.DRG then
        if isNM == true then
            nameObj = petList[mobJob][true][mobName]
        else
            nameObj = petList[mobJob][false]
        end
    else
        if isNM == true then
            nameObj = petList[mobJob][mobFamily][true][mobName]
        else
            nameObj = petList[mobJob][mobFamily][false]
        end
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
        onMobSpawn = function(mob) xi.dynamis.setPetStats(mob) end,
        onMobFight = petFunctions[mobJob][functionLookup]["onMobFight"],
        onMobDeath = function(mob, playerArg, isKiller) xi.dynamis.onPetDeath(mob) end,
        releaseIdOnDeath = true,
        mixins = petFunctions[mobJob][functionLookup]["mixins"],
    })
    mob:setSpawn(oMob:getXPos()+math.random()*6-3, oMob:getYPos()-0.3, oMob:getZPos()+math.random()*6-3, oMob:getRotPos())
    mob:setDropID(nameObj[4])
    if nameObj[5] ~= nil then -- If SpellList ~= nil set SpellList
        mob:setSpellList(nameObj[5])
    end
    if nameObj[6] ~= nil then -- If SkillList ~= nil set SkillList
        mob:setMobMod(xi.mobMod.SKILL_LIST, nameObj[6])
    end
    oMob:setPet(mob)
    mob:spawn()
    mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0, true)
    mob:updateEnmity(target)
end

--------------------------------------------
--        Dynamis Mob Pathing/Roam        --
--------------------------------------------

xi.dynamis.mobOnRoam = function(mob) -- Handle pathing.
    if mob:getRoamFlags() == xi.roamFlag.EVENT then
        local zoneID = mob:getZoneID()
        local mobIndex = mob:getLocalVar(string.format("MobIndex_%s", mob:getID()))
        for _, index in pairs(xi.dynamis.mobList[zoneID].patrolPaths) do
            local table = xi.dynamis.mobList[zoneID][index].patrolPath
            if mobIndex == index then
                local home = {table[1], table[2], table[3]}
                local dest = {table[4], table[5], table[6]}
                local spawn = mob:getSpawnPos()
                local current = mob:getPos()
                if current.x == home[1] and current.z == home[3] then
                    mob:pathTo(dest[1], dest[2], dest[3])
                elseif current.x == dest[1] and current.z == dest[3] then
                    mob:pathTo(home[1], home[2], home[3])
                elseif current.x == spawn.x and current.z == spawn.z then
                    mob:pathTo(home[1], home[2], home[3])
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
        [358] = 1146-- Kindred
    }
    for family, skill in pairs(specialSkills) do
        if mob:getMainJob() == xi.job.NIN or mob:getMainJob() == xi.job.RNG then
            mob:setMobMod(xi.mobMod.SPECIAL_SKILL, skill)
        end
    end
end

xi.dynamis.setMobStats = function(mob)
    if mob ~= nil then
        mob:setMobType(xi.mobskills.mobType.BATTLEFIELD)
        mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0, true)
        xi.dynamis.setSpecialSkill(mob)
        mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
        local job = mob:getMainJob()

        mob:setMobMod(xi.mobMod.HP_SCALE, 132)
        mob:setHP(mob:getMaxHP())
        mob:setMobLevel(math.random(78,80))
        mob:setTrueDetection(true)

        if job == xi.job.WAR then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.hpp = math.random(55,80)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.MNK then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.hpp = math.random(55,70)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.WHM then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.hpp = math.random(40,60)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.BLM then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.hpp = math.random(55,80)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.RDM then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.hpp = math.random(55,80)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.THF then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.hpp = math.random(55,75)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.PLD then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.hpp = math.random(55,75)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.DRK then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.hpp = math.random(55,75)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.BST then
        elseif job == xi.job.BRD then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.hpp = math.random(55,80)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.RNG then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.hpp = math.random(55,75)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.SAM then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.hpp = math.random(55,80)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.NIN then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.hpp = math.random(25,35)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.DRG then
        elseif job == xi.job.SMN then
        end

        -- Add Check After Calcs
        mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
    end
end

xi.dynamis.setNMStats = function(mob)
    local job = mob:getMainJob()
    mob:setMobType(xi.mobskills.mobType.BATTLEFIELD)
    mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0, true)
    xi.dynamis.setSpecialSkill(mob)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
    mob:setMobMod(xi.mobMod.HP_SCALE, 132)
    mob:setHP(mob:getMaxHP())
    mob:setMobLevel(math.random(80,82))
    mob:setTrueDetection(true)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)

    if job == xi.job.NIN then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.hpp = math.random(15,25)
        xi.mix.jobSpecial.config(mob, params)
    end
end

xi.dynamis.setStatueStats = function(mob, mobIndex)
    local zoneID = mob:getZoneID()
    local eyes = xi.dynamis.mobList[zoneID][mobIndex].eyes
    mob:setRoamFlags(xi.roamFlag.EVENT)
    mob:setMobType(xi.mobskills.mobType.BATTLEFIELD)
    mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0, true)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
    mob:setMobLevel(math.random(82,84))
    mob:setMod(xi.mod.DMGMAGIC, -50)
    mob:setMod(xi.mod.DMGPHYS, -50)
    mob:setTrueDetection(true)
    -- Disabling WHM job trait mods because their job is set to WHM in the DB.
    mob:setMod(xi.mod.MDEF, 0)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.MPHEAL, 0)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
    mob:setSpeed(20)
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
    mob:setMobMod(xi.mobMod.HP_SCALE, 132)
    mob:setHP(mob:getMaxHP())
    mob:setMobLevel(88)
    mob:setMod(xi.mod.STR, -10)
    mob:setTrueDetection(true)
end

xi.dynamis.setPetStats = function(mob)
    mob:setMobType(xi.mobskills.mobType.BATTLEFIELD)
    mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0, true)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
    mob:setMobLevel(78)
    mob:setTrueDetection(true)
end

xi.dynamis.setAnimatedWeaponStats = function(mob)
    mob:setMobMod(xi.mobMod.HP_SCALE, 132)
    mob:setHP(mob:getMaxHP())
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
end

xi.dynamis.teleport = function(mob, hideDuration)
    if mob:isDead() then
        return
    end

    mob:hideName(true)
    mob:setUntargetable(true)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:entityAnimationPacket("kesu")

    hideDuration = hideDuration or 5000

    if hideDuration < 1500 then
        hideDuration = 1500
    end

    mob:timer(hideDuration, function(mob)
        mob:hideName(false)
        mob:setUntargetable(false)
        mob:SetAutoAttackEnabled(true)
        mob:SetMagicCastingEnabled(true)
        mob:SetMobAbilityEnabled(true)

        if mob:isDead() then
            return
        end

        mob:entityAnimationPacket("deru")
    end)
end

--------------------------------------------
--            Dynamis Mob Death           --
--------------------------------------------

xi.dynamis.mobOnDeath = function(mob, player, isKiller)
    local zoneID = mob:getZoneID()
    local zone = mob:getZone()
    local mobIndex = zone:getLocalVar(string.format("MobIndex_%s", mob:getID()))
    if mob:getLocalVar("dynamisMobOnDeathTriggered") == 1 then return -- Don't trigger more than once.
    else -- Stops execution of code below if the above is true.
        if mob:getLocalVar("hasMobVar") == 1 then
            zone:setLocalVar(xi.dynamis.mobList[zoneID][mobIndex].info[5], 1) -- Set Death Requirements Variable
        end
        if mobIndex ~= 0 and mobIndex ~= nil then
            xi.dynamis.addTimeToDynamis(zone, mobIndex) -- Add Time
        end
        mob:setLocalVar("dynamisMobOnDeathTriggered", 1) -- onDeath lua happens once per party member that killed the mob, but we want this to only run once per mob
        if mob:getZoneID() == (xi.zone.DYNAMIS_BEAUCEDINE or xi.zone.DYNAMIS_XARCABARD) then
            if mob:getFamily() == (4 or 92 or 93 or 94 or 95) then
                player:addTreasure(4248, mob, 100) -- Adds Ginurva's Battle Theory to Statues and Eyes in Dynamis Beaucedine and Xarcabard
            elseif mob:getFamily() == (358 or 359) and mob:getMobMod(xi.mobMod.CHECK_AS_NM) == 2 then
                player:addTreasure(4249, mob, 500) -- Adds Shultz's Strategems to Kindred and Hydra NMs in Dynamis Beaucedine and Xarcabard
            end
        end
    end
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
    player:addTitle(xi.dynamis.dynaInfoEra[zoneID].winTitle) -- Give player the title
end)

--------------------------------------------
--        Dynamis Statue Functions        --
--------------------------------------------

xi.dynamis.statueOnFight = function(mob, target)
    if mob:getHP() == 1 then -- If my HP = 1
        if mob:getAnimationSub() == 2 then -- I am an HP statue
            if mob:hasStatusEffect(xi.effect.REGEN) then
                mob:delStatusEffect(xi.effect.REGEN)
                mob:setHP(1)
            end
            mob:addStatusEffect(xi.effect.STUN, 1, 0, 5)
            mob:setUntargetable(true)
            mob:SetAutoAttackEnabled(false)
            if mob:hasStatusEffect(xi.effect.STUN) then
                mob:delStatusEffectSilent(xi.effect.STUN)
            end
            mob:useMobAbility(1124) -- Use Recover HP
        elseif mob:getAnimationSub() == 3 then -- I am an MP statue
            if mob:hasStatusEffect(xi.effect.REGEN) then
                mob:delStatusEffect(xi.effect.REGEN)
                mob:setHP(1)
            end
            mob:addStatusEffect(xi.effect.STUN, 1, 0, 5)
            mob:setUntargetable(true)
            mob:SetAutoAttackEnabled(false)
            if mob:hasStatusEffect(xi.effect.STUN) then
                mob:delStatusEffectSilent(xi.effect.STUN)
            end
            mob:useMobAbility(1125) -- Use Recover MP
        end
    end
end

--------------------------------------------
--          Dynamis Pet Spawning          --
--------------------------------------------
xi.dynamis.mobOnEngaged = function(mob, target)
    if  mob:getMainJob() == xi.job.BST or mob:getMainJob() == xi.job.SMN then
        mob:entityAnimationPacket("casm")
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)

        mob:timer(3000, function(mob)
            if mob:isAlive() then
                xi.dynamis.spawnDynamicPet(target, mob, mob:getMainJob())
                mob:entityAnimationPacket("shsm")
                mob:SetAutoAttackEnabled(true)
                mob:SetMagicCastingEnabled(true)
                mob:SetMobAbilityEnabled(true)
            end
        end)
    elseif mob:getMainJob() == xi.job.DRG then
        mob:useMobAbility(xi.jsa.CALL_WYVERN)
    end
end

return m
