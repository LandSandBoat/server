--------------------------------------------
--          Dynamis 75 Era Module         --
--------------------------------------------
--------------------------------------------
--       Module Required Scripts          --
--------------------------------------------
require("scripts/mixins/job_special")
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
require("scripts/zones/Dynamis-Bastok/dynamis_mobs")
mixins = {require("scripts/mixins/job_special")}
require("modules/module_utils")

local m = Module:new("era_dynamis_spawning")

xi = xi or {}
xi.dynamis = xi.dynamis or {}

--------------------------------------------
--          Dynamis Mob Spawning          --
--------------------------------------------

xi.dynamis.spawnWave = function(zone, waveNumber)
    local zoneID = zone:getID()
    for _, index in pairs(xi.dynamis.mobList[zoneID][waveNumber].wave) do
        local mobIndex = xi.dynamis.mobList[zoneID][waveNumber].wave[index]
        if mobIndex ~= nil then
            local mobType = xi.dynamis.mobList[zoneID][mobIndex].info[1]
            if mobType == "NM" then -- NMs
                xi.dynamis.nmDynamicSpawn(mobIndex, nil, true, zoneID)
            elseif mobType ~= nil then -- Nightmare Mobs and Statues
                xi.dynamis.nonStandardDynamicSpawn(mobIndex, nil, true, zoneID)
            end
        end
    end
    zone:setLocalVar(string.format("Wave_%i_Spawned", waveNumber), 1)
end

xi.dynamis.parentOnEngaged = function(mob, target)
    local zoneID = mob:getZoneID()
    local oMobIndex = mob:getLocalVar("MobIndex")
    local oMob = GetMobByID(mob:getID())
    if not xi.dynamis.mobList[zoneID][oMobIndex].nmchildren == nil then
        for key, index in pairs(xi.dynamis.mobList[zoneID][oMobIndex].nmchildren) do
            if xi.dynamis.mobList[zoneID][oMobIndex].nmchildren[index] == true or xi.dynamis.mobList[zoneID][oMobIndex].nmchildren[index] == false then
                index = index + 1
            else
                local forceLink = xi.dynamis.mobList[zoneID][oMobIndex].nmchildren[1]
                local mobIndex = xi.dynamis.mobList[zoneID][oMobIndex].nmchildren[index]
                local mobType = xi.dynamis.mobList[zoneID][mobIndex].info[1]
                if mobType == "NM" then -- NMs
                    xi.dynamis.nmDynamicSpawn(mobIndex, oMobIndex, forceLink, zoneID, target, oMob)
                    index = index + 1
                elseif mobType ~= nil then -- Nightmare Mobs and Statues
                    xi.dynamis.nonStandardDynamicSpawn(mobIndex, oMob, forceLink, zoneID, target, oMobIndex)
                    index = index + 1
                end
            end
        end
    end
    xi.dynamis.normalDynamicSpawn(mob, oMobIndex) -- Normies have their own loop, so they don't need one here.
end

xi.dynamis.normalDynamicSpawn = function(mob, oMobIndex)
    local mobFamily = mob:getFamily()
    local mobID = mob:getID()
    local mobZoneID = mob:getZoneID()
    local oMob = GetMobByID(mobID)
    local zone = GetZone(mobZoneID)
    local nameObj = nil
    local mobSpec =
    {
        -- NOTE: To use default SpellList and SkillList set to nil.
        -- [Parent's Family]
        --{
            -- [ZoneID] -- If applicable
            --{
                -- [JobID] = {Name, groupId, groupZoneId, Droplist, SpellList, SkillList},
            --},
            -- [ZoneID] -- If applicable
            --{
                -- [FloorVar]
                -- {
                    -- [JobID] = {Name, groupId, groupZoneId, Droplist, SpellList, SkillList},
                -- },
            --},
            -- [JobID] = {Name, groupId, groupZoneId, Droplist, SpellList, SkillList},
        --},
        [4] = -- Vanguard Eye
        {
            [xi.zone.DYNAMIS_BEAUCEDINE] = -- Spawn Hydras (Done)
            {
                [1]  = {"48574152", 159, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HWAR
                [2]  = {"484d4e4b", 163, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HMNK
                [3]  = {"4857484d", 161, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HWHM
                [4]  = {"48424c4d", 164, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HBLM
                [5]  = {"4852444d", 162, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HRDM
                [6]  = {"48544846", 160, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HTHF
                [7]  = {"48504c44", 166, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HPLD
                [8]  = {"4844524b", 167, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HDRK
                [9]  = {"48425354", 168, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HBST
                [10] = {"48425244", 170, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HBRD
                [11] = {"48524e47", 171, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HRNG
                [12] = {"4853414d", 172, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HSAM
                [13] = {"484e494e", 173, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HNIN
                [14] = {"48445247", 174, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HDRG
                [15] = {"48534d4e", 176, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HSMN
            },
            [xi.zone.DYNAMIS_XARCABARD] = -- Spawn Kindred (Done)
            {
                [1]  = {"4b574152", 32, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KWAR
                [2]  = {"4b4d4e4b", 33, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KMNK
                [3]  = {"4b57484d", 29, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KWHM
                [4]  = {"4b424c4d", 30, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KBLM
                [5]  = {"4b52444d", 31, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KRDM
                [6]  = {"4b544846", 34, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KTHF
                [7]  = {"4b504c44", 15, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KPLD
                [8]  = {"4b44524b", 16, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KDRK
                [9]  = {"4b425354", 17, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KBST
                [10] = {"4b425244", 20, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KBRD
                [11] = {"4b524e47", 19, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KRNG
                [12] = {"4b53414d", 22, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KSAM
                [13] = {"4b4e494e", 23, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KNIN
                [14] = {"4b445247", 27, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KDRG
                [15] = {"4b534d4e", 24, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KSMN
            },
            [xi.zone.DYNAMIS_TAVNAZIA] = -- Spawn Kindred and Hydra
            {
                [2] = -- Floor 2 Spawn Hydras (Done)
                {
                    [1]  = {"48574152", 159, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HWAR
                    [2]  = {"484d4e4b", 163, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HMNK
                    [3]  = {"4857484d", 161, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HWHM
                    [4]  = {"48424c4d", 164, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HBLM
                    [5]  = {"4852444d", 162, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HRDM
                    [6]  = {"48544846", 160, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HTHF
                    [7]  = {"48504c44", 166, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HPLD
                    [8]  = {"4844524b", 167, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HDRK
                    [9]  = {"48425354", 168, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HBST
                    [10] = {"48425244", 170, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HBRD
                    [11] = {"48524e47", 171, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HRNG
                    [12] = {"4853414d", 172, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HSAM
                    [13] = {"484e494e", 173, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HNIN
                    [14] = {"48445247", 174, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HDRG
                    [15] = {"48534d4e", 176, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- HSMN
                },
                [3] = -- Floor 3 Spawn Kindred (Done)
                {
                    [1]  = {"4b574152", 32, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KWAR
                    [2]  = {"4b4d4e4b", 33, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KMNK
                    [3]  = {"4b57484d", 29, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KWHM
                    [4]  = {"4b424c4d", 30, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KBLM
                    [5]  = {"4b52444d", 31, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KRDM
                    [6]  = {"4b544846", 34, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KTHF
                    [7]  = {"4b504c44", 15, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KPLD
                    [8]  = {"4b44524b", 16, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KDRK
                    [9]  = {"4b425354", 17, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KBST
                    [10] = {"4b425244", 20, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KBRD
                    [11] = {"4b524e47", 19, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KRNG
                    [12] = {"4b53414d", 22, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KSAM
                    [13] = {"4b4e494e", 23, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KNIN
                    [14] = {"4b445247", 27, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KDRG
                    [15] = {"4b534d4e", 24, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- KSMN
                },
            },
        },
        [92] = -- Goblin Replica
        {
            [1]  = {"48574152", 159, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- GWAR
            [2]  = {"484d4e4b", 163, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- GMNK
            [3]  = {"4857484d", 161, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- GWHM
            [4]  = {"48424c4d", 164, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- GBLM
            [5]  = {"4852444d", 162, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- GRDM
            [6]  = {"48544846", 160, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- GTHF
            [7]  = {"48504c44", 166, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- GPLD
            [8]  = {"4844524b", 167, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- GDRK
            [9]  = {"48425354", 168, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- GBST
            [10] = {"48425244", 170, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- GBRD
            [11] = {"48524e47", 171, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- GRNG
            [12] = {"4853414d", 172, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- GSAM
            [13] = {"484e494e", 173, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- GNIN
            [14] = {"48445247", 174, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- GDRG
            [15] = {"48534d4e", 176, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- GSMN
        },
        [93] = -- Orc Statue
        {
            [1]  = {"48574152", 159, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- OWAR
            [2]  = {"484d4e4b", 163, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- OMNK
            [3]  = {"4857484d", 161, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- OWHM
            [4]  = {"48424c4d", 164, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- OBLM
            [5]  = {"4852444d", 162, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- ORDM
            [6]  = {"48544846", 160, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- OTHF
            [7]  = {"48504c44", 166, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- OPLD
            [8]  = {"4844524b", 167, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- ODRK
            [9]  = {"48425354", 168, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- OBST
            [10] = {"48425244", 170, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- OBRD
            [11] = {"48524e47", 171, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- ORNG
            [12] = {"4853414d", 172, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- OSAM
            [13] = {"484e494e", 173, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- ONIN
            [14] = {"48445247", 174, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- ODRG
            [15] = {"48534d4e", 176, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- OSMN
        },
        [94] = -- Quadav Statue (Done)
        {
            [1]  = {"51574152", 19, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- QWAR
            [2]  = {"514d4e4b", 25, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- QMNK
            [3]  = {"5157484d", 29, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- QWHM
            [4]  = {"51424c4d", 42, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- QBLM
            [5]  = {"5152444d", 20, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- QRDM
            [6]  = {"51544846", 33, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- QTHF
            [7]  = {"51504c44", 30, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- QPLD
            [8]  = {"5144524b", 38, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- QDRK
            [9]  = {"51425354", 21, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- QBST
            [10] = {"51425244", 23, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- QBRD
            [11] = {"51524e47", 34, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- QRNG
            [12] = {"5153414d", 31, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- QSAM
            [13] = {"514e494e", 32, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- QNIN
            [14] = {"51445247", 26, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- QDRG
            [15] = {"51534d4e", 35, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- QSMN
        },
        [95] = -- Yagudo Statue
        {
            [1]  = {"48574152", 159, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- YWAR
            [2]  = {"484d4e4b", 163, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- YMNK
            [3]  = {"4857484d", 161, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- YWHM
            [4]  = {"48424c4d", 164, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- YBLM
            [5]  = {"4852444d", 162, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- YRDM
            [6]  = {"48544846", 160, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- YTHF
            [7]  = {"48504c44", 166, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- YPLD
            [8]  = {"4844524b", 167, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- YDRK
            [9]  = {"48425354", 168, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- YBST
            [10] = {"48425244", 170, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- YBRD
            [11] = {"48524e47", 171, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- YRNG
            [12] = {"4853414d", 172, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- YSAM
            [13] = {"484e494e", 173, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- YNIN
            [14] = {"48445247", 174, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- YDRG
            [15] = {"48534d4e", 176, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- YSMN
        }
    }

    for key, job in pairs(xi.dynamis.mobList[mobZoneID][oMobIndex].mobchildren) do
        local indexJob = 1
        local indexEndJob = mobList[mobZoneID][oMobIndex].mobchildren[job]
        while (indexEndJob ~= nil and indexJob <= indexEndJob) do
            if oMob:getFamily() == 4 then
                if oMob:getLocalVar("Floor") == 2 or oMob:getLocalVar("Floor") == 3 then
                    nameObj = mobSpec[mobFamily][mobZoneID][oMob:getLocalVar("Floor")]
                else
                    nameObj = mobSpec[mobFamily][mobZoneID]
                end
            else
                nameObj = mobSpec[mobFamily]
            end
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
                onMobFight = function(mob) xi.dynamis.mobOnFight(mob) end,
                onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end,
                onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end,
                onMobDeath = function(mob, playerArg, isKiller)
                    xi.dynamis.mobOnDeath(mob, mobList[mob:getZoneID()], zones[mob:getZoneID()].text.DYNAMIS_TIME_EXTEND)
                end,
            })
            mob:setSpawn(oMob:getXPos()+math.random()*6-3, oMob:getYPos()-0.3, oMob:getzPos()+math.random()*6-3, oMob:getRotPos())
            mob:setDropID(nameObj[job][4])
            if nameObj[5] ~= nil then -- If SpellList ~= nil set SpellList
                mob:setSpellList(nameObj[5])
            end
            if nameObj[6] ~= nil then -- If SkillList ~= nil set SkillList
                mob:setMobMod(xi.mobMod.SKILL_LIST, nameObj[6])
            end
            mob:setLocalVar("Parent", oMob)
            mob:spawn()
            indexJob = indexJob + 1 -- Increment to the next mob of the same job.
        end
        job = job + 1 -- Increment to the next job.
    end
end

xi.dynamis.nonStandardDynamicSpawn = function(mobIndex, oMob, forceLink, zoneID, target, oMobIndex)
    local mobMobType = xi.dynamis.mobList[zoneID][mobIndex].info[1]
    local mobName = xi.dynamis.mobList[zoneID][mobIndex].info[2]
    local xPos = xi.dynamis.mobList[zoneID][mobIndex].pos[1]
    local yPos = xi.dynamis.mobList[zoneID][mobIndex].pos[2]
    local zPos = xi.dynamis.mobList[zoneID][mobIndex].pos[3]
    local rPos = xi.dynamis.mobList[zoneID][mobIndex].pos[4]
    local zone = GetZone(zoneID)
    local spawnLookUp =
    {
        ["Statue"] =
        {
            ["Vanguard Eye"] = {"56457965" , 163, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Vanguard Eye (VEye)
            ["Prototype Eye"] = {"50457965" , 61, 42, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Prototype Eye (PEye)
            ["Goblin Statue"] = {"4753746174" , 158, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Goblin Statue (GStat)
            ["Goblin Replica"] = {"475253746174" , 157, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Goblin Statue (GRStat)
            ["Statue Prototype"] = {"475053746174" , 36, 42, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Goblin Statue (GPStat)
            ["Serjeant Tombstone"] = {"4f53746174" , 89, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Orc Statue (OStat)
            ["Warchief Tombstone"] = {"4f5753746174" , 90, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Orc Statue (OWStat)
            ["Tombstone Prototype"] = {"545053746174" , 20, 42, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Orc Statue (TPStat)
            ["Adamantking Effigy"] = {"5153746174" , 55, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Quadav Statue (QStat)
            ["Adamantking Image"] = {"514953746174" , 56, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Quadav Statue (QIStat)
            ["Effigy Prototype"] = {"515053746174" , 9, 42, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Quadav Statue (QPStat)
            ["Avatar Idol"] = {"5953746174" , 124, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Yagudo Statue (YStat)
            ["Manifest Icon"] = {"594d53746174" , 68, 39, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Yagudo Statue (YMStat)
            ["Avatar Icon"] = {"414953746174" , 123, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Yagudo Statue (AIStat)
            ["Icon Prototype"] = {"595053746174" , 32, 42, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Yagudo Statue (YPStat)
        },
        ["Nightmare"] =
        {
            ["Nightmare Bunny"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Cockatrice"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Crab"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Dhalmel"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Eft"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Mandragora"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Raven"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Scorpion"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Urganite"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Cluster"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Hornet"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Leech"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Makara"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Taurus"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Antlion"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Bugard"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Worm"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Hippogryph"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Manticore"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Sabotender"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Sheep"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
            ["Nightmare Fly"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Yagudo Statue (YMStat)
        },
    }
    -- if mobMobType == "Statue" then
    --     onMobSpawn = function(mob) xi.dynamis.setStatueStats(mob, mobIndex) end
    -- elseif mobMobType == "Nightmare" then
    --     onMobSpawn = function(mob) xi.dynamis.setMobStats(mob) end
    -- end
    if mobMobType == "Statue" then
        local mob = zone:insertDynamicEntity({
            objtype = xi.objType.MOB,
            name = spawnLookUp[mobMobType][mobName][1],
            x = xPos,
            y = yPos,
            z = zPos,
            rotation = rPos,
            groupId = spawnLookUp[mobMobType][mobName][2],
            groupZoneId = spawnLookUp[mobMobType][mobName][3],
            onMobSpawn = function(mob) xi.dynamis.setStatueStats(mob, mobIndex) end,
            onMobEngaged = function(mob) xi.dynamis.parentOnEngaged(mob, target) end,
            onMobFight = function(mob) xi.dynamis.statueOnFight(mob) end,
            onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end,
            onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end,
            onMobDeath = function(mob, playerArg, isKiller)
                xi.dynamis.mobOnDeath(mob, xi.dynamis.mobList[zoneID], zones[zoneID].text.DYNAMIS_TIME_EXTEND)
            end,
        })
        mob:setSpawn(xPos, yPos, zPos, rPos)
        mob:setDropID(spawnLookUp[mobMobType][mobName][4])
        if spawnLookUp[mobMobType][mobName][5] ~= nil then -- If SpellList ~= nil set SpellList
            mob:setSpellList(spawnLookUp[mobMobType][mobName][5])
        end
        if spawnLookUp[mobMobType][mobName][6] ~= nil then -- If SkillList ~= nil set SkillList
            mob:setMobMod(xi.mobMod.SKILL_LIST, spawnLookUp[mobMobType][mobName][6])
        end
        if oMobIndex ~= nil then
            mob:setLocalVar("Parent", oMobIndex)
        end
        mob:setLocalVar("MobIndex", mobIndex)
        mob:setRoamFlags(xi.roamFlag.EVENT)
        mob:spawn()
        if forceLink == true then
            mob:updateEnmity(target)
        end
    else
        local mob = zone:insertDynamicEntity({
            objtype = xi.objType.MOB,
            name = spawnLookUp[mobMobType][mobName][1],
            x = xPos,
            y = yPos,
            z = zPos,
            rotation = rPos,
            groupId = spawnLookUp[mobMobType][mobName][2],
            groupZoneId = spawnLookUp[mobMobType][mobName][3],
            onMobSpawn = function(mob) xi.dynamis.setMobStats(mob) end,
            onMobEngaged = function(mob) xi.dynamis.parentOnEngaged(mob, target) end,
            onMobFight = function(mob) xi.dynamis.statueOnFight(mob) end,
            onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end,
            onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end,
            onMobDeath = function(mob, playerArg, isKiller)
                xi.dynamis.mobOnDeath(mob, xi.dynamis.mobList[zoneID], zones[zoneID].text.DYNAMIS_TIME_EXTEND)
            end,
        })
        mob:setSpawn(xPos, yPos, zPos, rPos)
        mob:setDropID(spawnLookUp[mobMobType][mobName][4])
        if spawnLookUp[mobMobType][mobName][5] ~= nil then -- If SpellList ~= nil set SpellList
            mob:setSpellList(spawnLookUp[mobMobType][mobName][5])
        end
        if spawnLookUp[mobMobType][mobName][6] ~= nil then -- If SkillList ~= nil set SkillList
            mob:setMobMod(xi.mobMod.SKILL_LIST, spawnLookUp[mobMobType][mobName][6])
        end
        if oMobIndex ~= nil then
            mob:setLocalVar("Parent", oMobIndex)
        end
        mob:setLocalVar("MobIndex", mobIndex)
        mob:spawn()
        if forceLink == true then
            mob:updateEnmity(target)
        end
    end
end

xi.dynamis.nmDynamicSpawn = function(mobIndex, oMobIndex, forceLink, zoneID, target, oMob) 
    local xPos = nil
    local yPos = nil
    local zPos = nil
    local rPos = nil
    if xi.dynamis.mobList[zoneID][mobIndex].pos[1] == nil then
        xPos = oMob:getXPos()
        yPos = oMob:getYPos()
        zPos = oMob:getZPos()
        rPos = oMob:getRotPos()
    else
        xPos = xi.dynamis.mobList[zoneID][mobIndex].pos[1]
        yPos = xi.dynamis.mobList[zoneID][mobIndex].pos[2]
        zPos = xi.dynamis.mobList[zoneID][mobIndex].pos[3]
        rPos = xi.dynamis.mobList[zoneID][mobIndex].pos[4]
    end
    local mobName = xi.dynamis.mobList[zoneID][mobIndex].info[2]
    local mobFamily = xi.dynamis.mobList[zoneID][mobIndex].info[3]
    local mainJob = xi.dynamis.mobList[zoneID][mobIndex].info[4]
    local nmInfoLookup = 
    {
        -- Below use used to lookup Beastmen NMs
        ["Goblin"] =
        {

        },
        ["Orc"] =
        {
            -- Dynamis - Beaucedine
            ["Cobraclaw Buchzvotch"] = {}, -- SouF
            ["Deathcaller Bidfbid"] = {}, -- SouF
            ["Drakefeast Wubmfub"] = {}, -- SouF
            ["Elvaanlopper Grokdok"] = {}, -- SouF
            ["Galkarider Retzpratz"] = {}, -- SouF
            ["Heavymail Djidzbad"] = {}, -- SouF
            ["Humegutter Adzjbadj"] = {}, -- SouF
            ["Jeunoraider Gepkzip"] = {}, -- SouF
            ["Lockbuster Zapdjipp"] = {}, -- SouF
            ["Mithraslaver Debhabob"] = {}, -- SouF
            ["Skinmask Ugghfogg"] = {}, -- SouF
            ["Spinalsucker Galflmall"] = {}, -- SouF
            ["Taruroaster Biggsjig"] = {}, -- SouF
            ["Ultrasonic Zeknajak"] = {}, -- SouF
            ["Wraithdancer Gidbnod"] = {}, -- SouF
            -- Dynamis Buburimu
            ["Elvaansticker Bxafraff"] = {}, -- SouF
            ["Flamecaller Zoeqdoq"] = {}, -- SouF
            ["Hamfist Gukhbuk"] = {}, -- SouF
            ["Lyncean Juwgneg"] = {}, -- SouF
            -- Dynamis - San d'Oria
            ["Wyrmgnasher Bjakdek"] = {}, -- WyrB
            ["Reapertongue Gadgquok"] = {}, -- ReaG
            ["Voidstreaker Butchnotch"] = {}, -- VoiB
            ["Battlechoir Gitchfotch"] = {}, -- BatG
            ["Soulsender Fugbrag"] = {}, -- SouF
        },
        ["Quadav"] =
        {
            -- Dynamis - Beaucedine
            ["Cobraclaw Buchzvotch"] = {}, -- SouF
            ["Deathcaller Bidfbid"] = {}, -- SouF
            ["Drakefeast Wubmfub"] = {}, -- SouF
            ["Elvaanlopper Grokdok"] = {}, -- SouF
            ["Galkarider Retzpratz"] = {}, -- SouF
            ["Heavymail Djidzbad"] = {}, -- SouF
            ["Humegutter Adzjbadj"] = {}, -- SouF
            ["Jeunoraider Gepkzip"] = {}, -- SouF
            ["Lockbuster Zapdjipp"] = {}, -- SouF
            ["Mithraslaver Debhabob"] = {}, -- SouF
            ["Skinmask Ugghfogg"] = {}, -- SouF
            ["Spinalsucker Galflmall"] = {}, -- SouF
            ["Taruroaster Biggsjig"] = {}, -- SouF
            ["Ultrasonic Zeknajak"] = {}, -- SouF
            ["Wraithdancer Gidbnod"] = {}, -- SouF
            -- Dynamis Buburimu
            ["Elvaansticker Bxafraff"] = {}, -- SouF
            ["Flamecaller Zoeqdoq"] = {}, -- SouF
            ["Hamfist Gukhbuk"] = {}, -- SouF
            ["Lyncean Juwgneg"] = {}, -- SouF
            -- Dynamis - San d'Oria
            ["Wyrmgnasher Bjakdek"] = {}, -- WyrB
            ["Reapertongue Gadgquok"] = {}, -- ReaG
            ["Voidstreaker Butchnotch"] = {}, -- VoiB
            ["Battlechoir Gitchfotch"] = {}, -- BatG
            ["Soulsender Fugbrag"] = {}, -- SouF
        },
        ['Yagudo'] =
        {

        },
        ["Kindred"] =
        {

        },
        ["Hydra"] =
        {

        },
        -- Below is used to lookup non-beastmen NMs.
        ["Gu'Dha Effigy"] = {}, -- Bastok Megaboss (BMb)
        ["Goblin Golem"] = {}, -- Jeuno Megaboss (JMb)
        ["Overlord's Tombstone"] = {}, -- Sandy Megaboss (SMb)
        ["Tzee Xicu Idol"] = {}, -- Windy Megaboss (WMb)
    }
    if mobFamily == "Goblin" or mobFamily == "Orc" or mobFamily == "Quadav" or mobFamily == "Yagudo" or mobFamily == "Kindred" or mobFamily == "Hydra" then -- Used for Beastmen NMs to Spawn in Parallel to Non-Standards
        mobVar =  nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = nmInfoLookup[mobFamily][mobName][1]
        groupIdFound = nmInfoLookup[mobFamily][mobName][2]
        groupZoneFound = nmInfoLookup[mobFamily][mobName][3]
        onMobSpawn = function(mob) xi.dynamis.setNMStats(mob) end
        onMobEngaged = function(mob) xi.dynamis.parentOnEngaged(mob, target) end
        onMobFight = function(mob) xi.dynamis.mobOnFight(mob) end
        onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end
        onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end
        onMobMagicPrepare = function(mob, target) end
        onMobWeaponSkillPrepare = function(mob, target) end
        onMobWeaponSkill = function( target, mob, skill) end
        onMobDeath = function(mob, player, isKiller) xi.dynamis.mobOnDeath(mob, xi.dynamis.mobList[zoneID], zones[zoneID].text.DYNAMIS_TIME_EXTEND, mobVar) end
    elseif mobName == "Gu'Dha Effigy" or mobName == "Goblin Golem" or mobName == "Overlord's Tombstone" or mobName == "Tzee Xicu Idol" then -- City Dynamis Megabosses (Bastok, Jeuno, Sandy, Windy)
        mobVar =  nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = nmInfoLookup[mobName][1]
        groupIdFound = nmInfoLookup[mobName][2]
        groupZoneFound = nmInfoLookup[mobName][3]
        onMobSpawn = function(mob) xi.dynamis.setMegaBossStats(mob) end
        onMobEngaged = function(mob) xi.dynamis.parentOnEngaged(mob, target) end
        onMobFight = function(mob) xi.dynamis.mobOnFight(mob) end
        onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end
        onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end
        onMobMagicPrepare = function(mob, target) end
        onMobWeaponSkillPrepare = function(mob, target) end
        onMobWeaponSkill = function( target, mob, skill) end
        onMobDeath = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end
    elseif mobName == "Angra Mainyu" then -- Dynamis Beaucedine Megaboss
        mobVar =  nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = nmInfoLookup[mobName][1]
        groupIdFound = nmInfoLookup[mobName][2]
        groupZoneFound = nmInfoLookup[mobName][3]
        onMobDeath = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end
    elseif mobName == "Apocalyptic Beast" then -- Dynamis Buburimu Megaboss
        mobVar =  nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = nmInfoLookup[mobName][1]
        groupIdFound = nmInfoLookup[mobName][2]
        groupZoneFound = nmInfoLookup[mobName][3]
        onMobDeath = function(mob, player, isKiller)
            xi.dynamis.megaBossOnDeath(mob, player, isKiller)
            if GetMobByID(zone:getLocalVar("Aitvaras")):isAlive() then
                DespawnMob(zone:getLocalVar("Aitvaras"))
            end
            if GetMobByID(zone:getLocalVar("Alklha")):isAlive() then
                DespawnMob(zone:getLocalVar("Alklha"))
            end
            if GetMobByID(zone:getLocalVar("Barong")):isAlive() then
                DespawnMob(zone:getLocalVar("Barong"))
            end
            if GetMobByID(zone:getLocalVar("Basillic")):isAlive() then
                DespawnMob(zone:getLocalVar("Basillic"))
            end
            if GetMobByID(zone:getLocalVar("Jurik")):isAlive() then
                DespawnMob(zone:getLocalVar("Jurik"))
            end
            if GetMobByID(zone:getLocalVar("Koschei")):isAlive() then
                DespawnMob(zone:getLocalVar("Koschei"))
            end
            if GetMobByID(zone:getLocalVar("Stihi")):isAlive() then
                DespawnMob(zone:getLocalVar("Stihi"))
            end
            if GetMobByID(zone:getLocalVar("Stollenwurm")):isAlive() then
                DespawnMob(zone:getLocalVar("Stollenwurm"))
            end
            if GetMobByID(zone:getLocalVar("Tarasca")):isAlive() then
                DespawnMob(zone:getLocalVar("Tarasca"))
            end
            if GetMobByID(zone:getLocalVar("Vishap")):isAlive() then
                DespawnMob(zone:getLocalVar("Vishap"))
            end
        end
    elseif mobName == "Antaeus" then -- Dynamis - Qufim Megaboss
        mobVar =  nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = nmInfoLookup[mobName][1]
        groupIdFound = nmInfoLookup[mobName][2]
        groupZoneFound = nmInfoLookup[mobName][3]
        onMobDeath = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end
    elseif mobName == "Cirrate Christelle" then
        mobVar =  nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = nmInfoLookup[mobName][1]
        groupIdFound = nmInfoLookup[mobName][2]
        groupZoneFound = nmInfoLookup[mobName][3]
        onMobDeath = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end
    elseif mobName == "Dynamis Lord" then
        mobVar =  nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = nmInfoLookup[mobName][1]
        groupIdFound = nmInfoLookup[mobName][2]
        groupZoneFound = nmInfoLookup[mobName][3]
        onMobDeath = function(mob, player, isKiller)
            local zone = mob:getZone()
            local dialogDL = 7272
            xi.dynamis.megaBossOnDeath(mob, player, mobVar)
            if isKiller then
                mob:showText(mob, dialogDL + 2)
                DespawnMob(zone:getLocalVar("Ying"))
                DespawnMob(zone:getLocalVar("Yang"))
            end
            zone:setLocalVar("MainDynaLord", mob:getID())
        end
    elseif mobName == ("Fairy Ring" or "Nantina" or "Dragontrap" or "Alklha" or "Stihi" or "Basilic" or "Jurik" or "Barong" or 
                       "Tarasca" or "Stollenwurm" or "Koschei" or "Aitvaras" or "Vishap") then -- Dynamis Zone NMs No Auto Attack
        mobVar =  nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = nmInfoLookup[mobName][1]
        groupIdFound = nmInfoLookup[mobName][2]
        groupZoneFound = nmInfoLookup[mobName][3]
        onMobSpawn = function(mob) xi.dynamis.setMegaBossStats(mob) 
            local zone = mob:getZone()
            zone:setLocalVar(mobVar, mob:getID())
            xi.dynamis.setNMStats(mob)
            mob:addMod(xi.mod.REGAIN, 1250)
            mob:SetAutoAttackEnabled(false)
        end
        onMobEngaged = function(mob) xi.dynamis.parentOnEngaged(mob, target) end
        onMobFight = function(mob) xi.dynamis.mobOnFight(mob) end
        onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end
        onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end
        onMobMagicPrepare = function(mob, target) end
        onMobWeaponSkillPrepare = function(mob, target) end
        onMobWeaponSkill = function( target, mob, skill) end
        onMobDeath = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end
    elseif mobName == ("Scolopendra" or "Suttung" or "Stringes" or "Fire Elemental" or "Water Elemental" or "Ice Elemental" or "Lightning Elemental" or 
                       "Earth Elemental" or "Air Elemental" or "Light Elemental" or "Dark Elemental" or "Vanguard Dragon") then -- Dynamis Zone NMs with Auto Attack
        mobVar =  nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = nmInfoLookup[mobName][1]
        groupIdFound = nmInfoLookup[mobName][2]
        groupZoneFound = nmInfoLookup[mobName][3]
        onMobSpawn = function(mob) 
            local zone = mob:getZone()
            zone:setLocalVar(mobVar, mob:getID())
            xi.dynamis.setNMStats(mob)
        end
        onMobEngaged = function(mob) xi.dynamis.parentOnEngaged(mob, target) end
        onMobFight = function(mob) xi.dynamis.mobOnFight(mob) end
        onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end
        onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end
        onMobMagicPrepare = function(mob, target) end
        onMobWeaponSkillPrepare = function(mob, target) end
        onMobWeaponSkill = function( target, mob, skill) end
        onMobDeath = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end
    elseif mobName == "Ying" then
        mobVar =  nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = nmInfoLookup[mobName][1]
        groupIdFound = nmInfoLookup[mobName][2]
        groupZoneFound = nmInfoLookup[mobName][3]
        onMobDeath = function(mob, player, isKiller) 
            local zone = mob:getZone()
            local yang = GetMobByID(zone:getLocalVar("Yang"))
            local dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
            local dialogYing = 7289
            if isKiller then
                if yang:isAlive() == true then
                    mob:showText(mob, dialogYing)
                else
                    mob:showText(mob, dialogYing + 2)
                end
            end

            yang:setLocalVar("yingToD", os.time())
            if dynaLord:getLocalVar("magImmune") == 0 then
                dynaLord:setMod(xi.mod.UDMGMAGIC, 0)
                dynaLord:setMod(xi.mod.UDMGBREATH, 0)
                if dynaLord:getLocalVar("physImmune") == 1 then -- other dragon is also dead
                    dynaLord:setLocalVar("physImmune", 2)
                    dynaLord:setLocalVar("magImmune", 2)
                else
                    dynaLord:setLocalVar("magImmune", 1)
                end
            end
        end
    elseif mobName == "Yang" then
        mobVar =  nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = nmInfoLookup[mobName][1]
        groupIdFound = nmInfoLookup[mobName][2]
        groupZoneFound = nmInfoLookup[mobName][3]
        onMobDeath = function(mob, player, isKiller) 
            local zone = mob:getZone()
            local ying = GetMobByID(zone:getLocalVar("Ying"))
            local dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
            local dialogYing = 7290
            if isKiller then
                if ying:isAlive() == true then
                    mob:showText(mob, dialogYing)
                else
                    mob:showText(mob, dialogYing + 2)
                end
            end

            ying:setLocalVar("yingToD", os.time())
            if dynaLord:getLocalVar("physImmune") == 0 then
                dynaLord:setMod(xi.mod.UDMGMAGIC, 0)
                dynaLord:setMod(xi.mod.UDMGBREATH, 0)
                if dynaLord:getLocalVar("magImmune") == 1 then -- other dragon is also dead
                    dynaLord:setLocalVar("physImmune", 2)
                    dynaLord:setLocalVar("magImmune", 2)
                else
                    dynaLord:setLocalVar("physImmune", 1)
                end
            end
        end
    elseif string.sub(mobName, 1, 9) == "Animated " then -- Animated Weapons
        mobVar =  nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = nmInfoLookup[mobName][1]
        groupIdFound = nmInfoLookup[mobName][2]
        groupZoneFound = nmInfoLookup[mobName][3]
        onMobSpawn = function(mob) xi.dynamis.setMegaBossStats(mob) end
        onMobEngaged = function(mob) xi.dynamis.parentOnEngaged(mob, target) end
        onMobFight = function(mob) xi.dynamis.mobOnFight(mob) end
        onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end
        onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end
        onMobMagicPrepare = function(mob, target) end
        onMobWeaponSkillPrepare = function(mob, target) end
        onMobWeaponSkill = function( target, mob, skill) end
        onMobDeath = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end
    end
    if nmInfoLookup[mobFamily] == "Goblin" or nmInfoLookup[mobFamily] == "Orc" or nmInfoLookup[mobFamily] == "Yagudo" or nmInfoLookup[mobFamily] == "Kindred" or nmInfoLookup[mobFamily] == "Hydra" then
        local mob = zone:insertDynamicEntity({
            objtype = xi.objType.MOB,
            name = mobNameFound,
            x = xPos,
            y = yPos,
            z = zPos,
            rotation = rPos,
            groupId = groupIdFound,
            groupZoneId = groupZoneFound,
            onMobSpawn,
            onMobEngaged,
            onMobFight,
            onMobRoam,
            onMobRoamAction,
            onMobMagicPrepare,
            onMobWeaponSkillPrepare,
            onMobWeaponSkill,
            onMobDeath,
        })
        mob:setSpawn(xPos, yPos, zPos, rPos)
        if mobFamily == nil then
            mob:setDropID(nmInfoLookup[mobName][4])
            if nmInfoLookup[mobName][5] ~= nil then -- If SpellList ~= nil set SpellList
                mob:setSpellList(nmInfoLookup[mobName][5])
            end
            if nmInfoLookup[mobName][6] ~= nil then -- If SkillList ~= nil set SkillList
                mob:setMobMod(xi.mobMod.SKILL_LIST, nmInfoLookup[mobName][6])
            end
        else
            mob:setDropID(nmInfoLookup[mobFamily][mobName][4])
            if nmInfoLookup[mobFamily][mobName][5] ~= nil then -- If SpellList ~= nil set SpellList
                mob:setSpellList(nmInfoLookup[mobFamily][mobName][5])
            end
            if nmInfoLookup[mobFamily][mobName][6] ~= nil then -- If SkillList ~= nil set SkillList
                mob:setMobMod(xi.mobMod.SKILL_LIST, nmInfoLookup[mobFamily][mobName][6])
            end
        end
        if oMobIndex ~= nil then
            mob:setLocalVar("Parent", oMobIndex)
        end
        mob:setLocalVar("MobIndex", mobIndex)
        mob:spawn()
        if forceLink == true then
            mob:updateEnmity(target)
        end
    else
        local mob = zone:insertDynamicEntity({
            objtype = xi.objType.MOB,
            name = mobNameFound,
            x = xPos,
            y = yPos,
            z = zPos,
            rotation = rPos,
            groupId = groupIdFound,
            groupZoneId = groupZoneFound,
            onMobDeath,
        })
        mob:setSpawn(xPos, yPos, zPos, rPos)
        if mobFamily == nil then
            mob:setDropID(nmInfoLookup[mobName][4])
            if nmInfoLookup[mobName][5] ~= nil then -- If SpellList ~= nil set SpellList
                mob:setSpellList(nmInfoLookup[mobName][5])
            end
            if nmInfoLookup[mobName][6] ~= nil then -- If SkillList ~= nil set SkillList
                mob:setMobMod(xi.mobMod.SKILL_LIST, nmInfoLookup[mobName][6])
            end
        else
            mob:setDropID(nmInfoLookup[mobFamily][mobName][4])
            if nmInfoLookup[mobFamily][mobName][5] ~= nil then -- If SpellList ~= nil set SpellList
                mob:setSpellList(nmInfoLookup[mobFamily][mobName][5])
            end
            if nmInfoLookup[mobFamily][mobName][6] ~= nil then -- If SkillList ~= nil set SkillList
                mob:setMobMod(xi.mobMod.SKILL_LIST, nmInfoLookup[mobFamily][mobName][6])
            end
        end
        if oMobIndex ~= nil then
            mob:setLocalVar("Parent", oMobIndex)
        end
        mob:setLocalVar("MobIndex", mobIndex)
        mob:spawn()
        if forceLink == true then
            mob:updateEnmity(target)
        end
    end
end

xi.dynamis.spawnDynamicPet =function(target, mob) 
    local mobFamily = mob:getFamily()
    local isNM = mob:isMobType(MOBTYPE_NOTORIOUS)
    local mobJob = mob:getJob()
    local oMob = GetMobByID(mob:getID())
    local oMobIndex = oMob:getLocalVar("MobIndex")
    local mobName = mob:getName()
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
        [327] = -- Goblin Family
        {
            [xi.job.BST] =
            {
                [false] = {"56536c696d65" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Normal Goblin BST (VSlime)
                [true] = -- Goblin NM
                {
                    ["Routsix_Rubbertendon"] = {"56536c696d65" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- NM Goblin BST (VSlime)
                    ["Blazax_Boneybad"] = {"56536c696d65" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- NM Goblin BST (VSlime)
                    ["Rutrix_Hamgams"] = {"56536c696d65" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- NM Goblin BST (VSlime)
                    ["Trailblix_Goatmug"] = {"56536c696d65" , 130, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- NM Goblin BST (VSlime)
                    ["Woodnix_Shrillwistle"] = {"5753536c696d65" , 7, 40, 0, nil, nil, MOBTYPE_NORMAL}, -- NM Goblin BST (WSSlime)
                }
            },
            [xi.job.DRG] =
            {

            }
        },
        [334] = -- Orc Family
        {
            [xi.job.BST] =
                {
                [false] = {"56486563", 77, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Normal Orc BST (VHec)
                [true] = -- Orc NM
                {
                    ["Mithraslaver_Debhabob"] = {"56486563", 77, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- NM Orc BST (VHec)
                },
            },
            [xi.job.DRG] =
            {
                
            }
        },
        [337] = -- Quadav Family
        {
            [xi.job.BST] =
            {
                [false] = {"5653636f", 22, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Normal Quadav BST (VSco)
                [true] = -- Quadav NM
                {
                    ["SoGho_Adderhandler"] = {"5653636f", 22, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- NM Quadav BST (VSco)
                    ["BeEbo_Tortoisedriver"] = {"5653636f", 22, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- NM Quadav BST (VSco)
                },
            },
            [xi.job.DRG] =
            {
                
            }
        },

        [358] = -- Kindred Family
        {
            [xi.job.BST] =
            {
                [false] = {"4b566f75", 100, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- Normal Kindred BST (KVou)
                [true] = -- NM Kindred
                {
                    ["Marquis_Andras"] = {"41566f75", 55, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- NM Kindred BST (AVou)
                }
            },
            [xi.job.DRG] =
            {
                
            }
        },
        [359] = -- Hydra Family
        {
            [xi.job.BST] =
            {
                [false] = {"48486f75", 169, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- Normal Hydra BST (HHou)
                [true] = -- Hydra NM
                {
                    ["Dagourmarche"] = {"44486f75", 169, 134, 0, nil, nil, MOBTYPE_NORMAL}, -- NM Hydra BST (DHou)
                }
            },
            [xi.job.DRG] =
            {
                
            }
        },
        [360] = -- Yagudo Family
        {
            [xi.job.BST] =
            {
                [false] = {"5643726f", 100, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- Normal Yagudo BST (VCro)
                [true] = -- Yagudo NM
                {
                    ["Soo_Jopo_the_Fiendking"] = {"5643726f", 100, 135, 0, nil, nil, MOBTYPE_NORMAL}, -- NM Yagudo BST (VCro)
                }
            },
            [xi.job.DRG] =
            {
                
            }
        },
    }
    if isNM == true then
        if mobFamily ~= 327 and mobFamily ~= 334 and mobFamily ~= 337 and mobFamily ~= 358 and mobFamily ~= 359 and mobFamily ~= 360 then
            nameObj = petList[mobName]
        else
        nameObj = petList[mobFamily][mobJob][true][mobName]
        end
    else
        nameObj = petList[mobFamily][mobJob][false]
    end
    local mob = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
        name = nameObj[1],
        x = oMob:getXPos()+math.random()*6-3,
        y = oMob:getYPos()-0.3,
        z = oMob:getXPos()+math.random()*6-3,
        rotation = oMob:getRotPos(),
        groupId = nameObj[2],
        groupZoneId = nameObj[3],
        onMobSpawn = function(mob) xi.dynamis.setMobStats(mob) end,
        onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end,
        onMobFight = function(mob) xi.dynamis.mobOnFight(mob) end,
        onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end,
        onMobDeath = function(mob, playerArg, isKiller)
            xi.dynamis.mobOnDeath(mob, mobList[mob:getZoneID()], zones[mob:getZoneID()].text.DYNAMIS_TIME_EXTEND)
        end,
    })
    mob:setSpawn(oMob:getXPos()+math.random()*6-3, oMob:getYPos()-0.3, oMob:getZPos()+math.random()*6-3, oMob:getRotPos())
    mob:setDropID(nameObj[4])
    if nameObj[5] ~= nil then -- If SpellList ~= nil set SpellList
        mob:setSpellList(nameObj[5])
    end
    if nameObj[6] ~= nil then -- If SkillList ~= nil set SkillList
        mob:setMobMod(xi.mobMod.SKILL_LIST, nameObj[6])
    end
    oMob:setLocalVar("PetID", mob:getID())
    mob:setLocalVar("PetMaster", oMobIndex)
    mob:spawn()
    mob:updateEnmity(target)
end

return m