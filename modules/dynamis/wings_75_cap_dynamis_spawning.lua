--------------------------------------------
--      Dynamis Wings 75 Era Module       --
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
require("scripts/zones/Dynamis-Bastok/dynamis_mobs")
require("scripts/zones/Dynamis-Beaucedine/dynamis_mobs")
require("scripts/zones/Dynamis-Buburimu/dynamis_mobs")
require("scripts/zones/Dynamis-Jeuno/dynamis_mobs")
require("scripts/zones/Dynamis-Qufim/dynamis_mobs")
require("scripts/zones/Dynamis-San_dOria/dynamis_mobs")
require("scripts/zones/Dynamis-Tavnazia/dynamis_mobs")
require("scripts/zones/Dynamis-Valkurm/dynamis_mobs")
require("scripts/zones/Dynamis-Windurst/dynamis_mobs")
require("scripts/zones/Dynamis-Xarcabard/dynamis_mobs")
require("modules/dynamis/wings_75_cap_dynamis")
mixins = {require("scripts/mixins/job_special")}
require("modules/module_utils")
--------------------------------------------
--       Module Affected Scripts          --
--------------------------------------------
require("scripts/globals/dynamis")
--------------------------------------------

local m = Module:new("wings_75_cap_dynamis_spawning")
m:setEnabled(false)

xi = xi or {}
xi.dynamis = xi.dynamis or {}

--------------------------------------------
--          Dynamis Mob Spawning          --
--------------------------------------------

xi.dynamis.spawnWave = function(zone, waveNumber)
    zoneID = zone:getID()
    tableLookup = string.format(".wave%i", waveNumber)
    for _, index in pairs(mobList[zoneID].tableLookup) do
        mobIndex = mobList[zoneID].tableLookup[index]
        mobType = mobList[zoneID][mobIndex].info[1]
        if mobType == "NM" then -- NMs
            xi.dynamis.nmDynamicSpawn(mobIndex, nil, true, zoneID)
        elseif mobType ~= nil then -- Nightmare Mobs and Statues
            xi.dynamis.nonStandardDynamicSpawn(mobIndex, nil, true, zoneID)
        end
        index = index + 1
    end
    zone:setLocalVar(string.format("Wave_%i_Spawned", waveNumber), 1)
end

xi.dynamis.parentOnEngaged = function(mob, target, mobList)
    local zoneID = mob:getZoneID()
    local oMobIndex = mob:getLocalVar("MobIndex")
    local oMob = GetMobByID(mob:getID())
    local forceLink = mobList[zoneID][oMobIndex].NMChildren[1]
    for _, index in pairs(mobList[zoneID][oMobIndex].NMChildren) do
        if mobList[zoneID][oMobIndex].NMChildren[index] == true or mobList[zoneID][oMobIndex].NMChildren[index] == false then
            index = index + 1
        else
            local mobIndex = mobList[zoneID][oMobIndex].NMChildren[index]
            local mobType = mobList[zoneID][mobIndex].info[1]
            if mobType == "NM" then -- NMs
                xi.dynamis.nmDynamicSpawn(mobIndex, oMobIndex, forceLink, zoneID, target, oMob)
                index = index + 1
            elseif mobType ~= nil then -- Nightmare Mobs and Statues
                xi.dynamis.nonStandardDynamicSpawn(mobIndex, oMobIndex, forceLink, zoneID, target, oMob)
                index = index + 1
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

    for _, job in pairs(mobList[mobZoneID][oMobIndex].mobchildren) do
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
    local mobMobType = mobList[zoneID][mobIndex].info[1]
    local mobName = mobList[zoneID][mobIndex].info[2]
    local xPos = mobList[zoneID][mobIndex].pos[1]
    local yPos = mobList[zoneID][mobIndex].pos[2]
    local zPos = mobList[zoneID][mobIndex].pos[3]
    local rPos = mobList[zoneID][mobIndex].pos[4]
    local spawnLookUp =
    {
        ["Statue"] =
        {
            ["Vanguard Eye"] = {"56457965" , 130, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Vanguard Eye (VEye)
            ["Goblin Statue"] = {"4753746174" , 130, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Goblin Statue (GStat)
            ["Goblin Replica"] = {"475253746174" , 130, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Goblin Statue (GRStat)
            ["Serjeant Tombstone"] = {"4f53746174" , 130, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Orc Statue (OStat)
            ["Warchief Tombstone"] = {"4f5753746174" , 130, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Orc Statue (OWStat)
            ["Adamantking Effigy"] = {"5153746174" , 130, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Quadav Statue (QStat)
            ["Avatar Idol"] = {"5953746174" , 130, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Yagudo Statue (YStat)
            ["Manifest Icon"] = {"594d53746174" , 130, 134, 0, nil, nil, MOBTYPE_NOTORIOUS}, -- Yagudo Statue (YMStat)
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
    if spawnLookUp[mobMobType][mobName][7] == MOBTYPE_NOTORIOUS then
        onMobSpawn = function(mob) xi.dynamis.setNMStats(mob) end
    else
        onMobSpawn = function(mob) xi.dynamis.setMobStats(mob) end
    end
    local mob = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
        name = spawnLookUp[mobMobType][mobName][1],
        x = xPos,
        y = yPos,
        z = zPos,
        rotation = rPos,
        groupId = spawnLookUp[mobMobType][mobName][2],
        groupZoneId = spawnLookUp[mobMobType][mobName][3],
        onMobSpawn,
        onMobEngaged = function(mob) xi.dynamis.parentOnEngaged(mob, target) end,
        onMobFight = function(mob) xi.dynamis.mobOnFight(mob) end,
        onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end,
        onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end,
        onMobDeath = function(mob, playerArg, isKiller)
            xi.dynamis.mobOnDeath(mob, mobList[zoneID], zones[zoneID].text.DYNAMIS_TIME_EXTEND)
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

xi.dynamis.nmDynamicSpawn = function(mobIndex, oMobIndex, forceLink, zoneID, target, oMob) 
    local xPos = nil
    local yPos = nil
    local zPos = nil
    local rPos = nil
    if mobList[zoneID][mobIndex].pos[1] == nil then
        xPos = oMob:getXPos()
        yPos = oMob:getYPos()
        zPos = oMob:getZPos()
        rPos = oMob:getRotPos()
    else
        xPos = mobList[zoneID][mobIndex].pos[1]
        yPos = mobList[zoneID][mobIndex].pos[2]
        zPos = mobList[zoneID][mobIndex].pos[3]
        rPos = mobList[zoneID][mobIndex].pos[4]
    end
    local mobName = mobList[zoneID][mobIndex].info[2]
    local mobFamily = mobList[zoneID][mobIndex].info[3]
    local mainJob = mobList[zoneID][mobIndex].info[4]
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
        onMobDeath = function(mob, player, isKiller) xi.dynamis.mobOnDeath(mob, mobList[zoneID], zones[zoneID].text.DYNAMIS_TIME_EXTEND, mobVar) end
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
        onMobSpawn = function(mob) 
            local mobID = mob:getID()
            xi.dynamis.setMegaBossStats(mob)
            mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
        
            xi.mix.jobSpecial.config(mob, {
                between = 300,
                specials =
                {
                    {id = xi.jsa.CHAINSPELL, hpp = 25},
                },
            })
        end
        onMobEngaged = function(mob, target)
            local OMobIndex = mobIndex
            local OMob = mob
            local i = 0
            local pets =
            {
                ["Fire Puki"] = {"4650756b" , 130, 134, 0, nil, nil}, -- FPuk
                ["Wind Puki"] = {"5750756b" , 130, 134, 0, nil, nil}, -- WPuk
                ["Poison Puki"] = {"506f50756b" , 130, 134, 0, nil, nil}, -- PoPuk
                ["Petro Puki"] = {"506550756b" , 130, 134, 0, nil, nil}, -- PePuk
            }
            for _, pet in pairs(pets) do
                local mob = zone:insertDynamicEntity({
                    objtype = xi.objType.MOB,
                    name = nameObj[1],
                    x = oMob:getXPos()+math.random()*6-3,
                    y = oMob:getYPos()-0.3,
                    z = oMob:getXPos()+math.random()*6-3,
                    rotation = oMob:getRotPos(),
                    groupId = nameObj[2],
                    groupZoneId = nameObj[3],
                    onMobSpawn = function(mob) xi.dynamis.setNMStats(mob) end,
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
                OMob:setLocalVar(string.format("PetID_%i", i + 1), mob:getID())
                mob:setLocalVar("PetMaster", OMobIndex)
                mob:spawn()
                mob:updateEnmity(target)
            end
        end
        onMobFight = function(mob) 
            teles =
            {
            {279.4038, 20, 535.4518},
            {312.6868, 20.5267, 511.9843},
            {322.2653, 20, 481.8030},
            {295.9948, 20.7949, 483.1078},
            {269.6127, 19.5547, 505.3206},
            {240.9685, 20, 521.5283},
            {239.8057, 20.1687, 487.3961},
            {258.6785, 20.1525, 460.4170},
            }
        
        
            local teleTime = mob:getLocalVar("teleTime")
            if mob:getBattleTime() - teleTime > 30 then
                randPos = teles[math.random((1), (8))]
                xi.dynamis.teleport(mob, 1000)
                mob:setPos(randPos, 0)
                for i = 1, 4 do
                    local pet = GetMobByID(mob:getLocalVar(string.format("PetID_%i", i)))
                    if pet:isAlive() and mob:getHPP() <= 99 then
                        pet:disengage()
                        pet:resetEnmity(target)
                        pet:updateEnmity(mob:getTarget())
                    end
                end
                mob:setLocalVar("teleTime", mob:getBattleTime())
            end
        
            for i = 1, 4 do
                local pet = GetMobByID(mob:getLocalVar(string.format("PetID_%i", i)))
                if pet:isAlive() and pet:getCurrentAction() == xi.act.ROAMING then
                    pet:updateEnmity(target)
                end
            end
        end
        onMobRoam = function(mob) mob:setLocalVar("teleTime", 0) end
        onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end
        onMobMagicPrepare = function(mob, target)
            if mob:getHPP() <= 25 then
                return 367 -- Death
            else
                -- Can cast Blindga, Death, Graviga, Silencega, and Sleepga II.
                -- Casts Graviga every time before he teleports.
                local rnd = math.random()
        
                if rnd < 0.2 then
                    return 361 -- Blindga
                elseif rnd < 0.4 then
                    return 367 -- Death
                elseif rnd < 0.6 then
                    return 366 -- Graviga
                elseif rnd < 0.8 then
                    return 274 -- Sleepga II
                else
                    return 359 -- Silencega
                end
            end
        end
        onMobWeaponSkillPrepare = function(mob, target) end
        onMobWeaponSkill = function( target, mob, skill) end
        onMobDeath = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end
    elseif mobName == "Apocalyptic Beast" then -- Dynamis Buburimu Megaboss
        mobVar =  nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = nmInfoLookup[mobName][1]
        groupIdFound = nmInfoLookup[mobName][2]
        groupZoneFound = nmInfoLookup[mobName][3]
        onMobSpawn = function(mob)
            local zone = mob:getZone()
            xi.dynamis.setMegaBossStats(mob)
            -- Set Mods
            mob:setMod(xi.mod.GRAVITYRES, 100)
            mob:setMod(xi.mod.BINDRES, 50)
            mob:setMod(xi.mod.STUNRES, 99)
            mob:setMod(xi.mod.REGAIN, 500)
            mob:setMod(xi.mod.REFRESH, 500)
            mob:setMod(xi.mod.SILENCERES, 100)
            mob:setMod(xi.mod.BLINDRES, 100)
            mob:setMod(xi.mod.PARALYZERES, 50)
            mob:setMod(xi.mod.SLOWRES, 50)
            mob:setMod(xi.mod.SLEEPRES, 100)
            mob:setMod(xi.mod.LULLABYRES, 100)
            -- Make it so we can reference arbitrary mob
            zone:setLocalVar("Apocalyptic_Beast", mob:getID())
        end
        onMobEngaged = function(mob) 
            mob:setLocalVar("last2hrtime", os.time())
            mob:setLocalVar("next2hr", 1)        
        end
        onMobFight = function(mob)
            local abilities2hr =
            {
                [1 ] = xi.jsa.MIGHTY_STRIKES,
                [2 ] = xi.jsa.HUNDRED_FISTS,
                [3 ] = xi.jsa.BENEDICTION,
                [4 ] = xi.jsa.MANAFONT,
                [5 ] = xi.jsa.CHAINSPELL,
                [6 ] = xi.jsa.PERFECT_DODGE,
                [7 ] = xi.jsa.INVINCIBLE,
                [8 ] = xi.jsa.BLOOD_WEAPON,
                [9 ] = xi.jsa.FAMILIAR,
                [10] = xi.jsa.SOUL_VOICE,
                [11] = xi.jsa.EES_DRAGON,
                [12] = xi.jsa.MEIKYO_SHISUI,
                [13] = xi.jsa.MIJIN_GAKURE,
                [14] = xi.jsa.CALL_WYVERN,
                [15] = xi.jsa.ASTRAL_FLOW,
            }
            local manafontspells =
            {
                [1 ] = 176, -- Firaga III
                [2 ] = 181, -- Blizzaga III
                [3 ] = 186, -- Aeroga III
                [4 ] = 191, -- Stonega III
                [5 ] = 196, -- Thundaga III
                [6 ] = 201, -- Waterga III
            }
            local chainspellspells =
            {
                [1 ] = 361, -- Blindga
                [2 ] = 356, -- Paralyga
                [3 ] = 362, -- Bindga
                [4 ] = 365, -- Breakga
                [5 ] = 274, -- Sleepga II
                [6 ] = 367, -- Death
            }
            local soulvoicesongs =
            {
                [1 ] = 376, -- Horde Lullaby
                [2 ] = 373, -- Foe Requiem VI
                [3 ] = 397, -- Valor Minuet IV
                [4 ] = 420, -- Victory March
                [5 ] = 422, -- Carnage Elegy
                [6 ] = 463, -- Foe Lullaby
            }
        
            while os.time() >= (mob:getLocalVar("last2hrtime") + 45) do
                i = mob:getLocalVar("next2hr")
                mob:useMobAbility(abilities2hr[i])
                mob:setLocalVar("last2hrtime", os.time())
                mob:setLocalVar("next2hr", i + 1)
            end
        
            if mob:getLocalVar("familiarcharm") == 1 then
                if mob:getLocalVar("next2hr") == 9 and (os.time() >= (mob:getLocalVar("last2hrtime") + 43)) then
                    mob:useMobAbility(710)
                end
            end
        
            if mob:hasStatusEffect(xi.effect.MANAFONT) then
                if mob:getStatus() == xi.action.NONE then
                    local spell = manafontspells[math.random(1,6)]
                    mob:castSpell(spell)
                end
            end
        
            if mob:hasStatusEffect(xi.effect.CHAINSPELL) then
                if mob:getStatus() == xi.action.NONE then
                    local spell = chainspellspells[math.random(1,6)]
                    mob:castSpell(spell)
                end
            end
        
            if mob:hasStatusEffect(xi.effect.SOUL_VOICE) then
                if mob:getStatus() == xi.action.NONE then
                    local song = soulvoicesongs[math.random(1,6)]
                    mob:castSpell(song)
                end
            end
        end
        onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end
        onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end
        onMobMagicPrepare = function(mob, target) end
        onMobWeaponSkillPrepare = function(mob, target)
            local zone = mob:getZone()
            local voidsong = 10
            local chaosblade = 10
            local bodyslam = 10
            local petroeyes = 10
            local windbreath = 10
            local flamebreath = 10
            local lodesong = 10
            local heavystomp = 10
            local poisonbreath = 10
            local thornsong = 10
            local charm = 10
        
            -- Set Probabilities of Each Skill Based on Dragon Kill Status
            if not GetMobByID(zone:getLocalVar("Aitvaras")):isAlive() then
                voidsong = 0
            end
            if not GetMobByID(zone:getLocalVar("Alklha")):isAlive() then
                chaosblade = 0
            end
            if not GetMobByID(zone:getLocalVar("Barong")):isAlive() then
                bodyslam = 0
            end
            if not GetMobByID(zone:getLocalVar("Basillic")):isAlive() then
                petroeyes = 0
            end
            if not GetMobByID(zone:getLocalVar("Jurik")):isAlive() then
                windbreath = 0
            end
            if not GetMobByID(zone:getLocalVar("Koschei")):isAlive() then
                thornsong = 0
            end
            if not GetMobByID(zone:getLocalVar("Stihi")):isAlive() then
                flamebreath = 0
            end
            if not GetMobByID(zone:getLocalVar("Stollenwurm")):isAlive() then
                lodesong = 0
            end
            if not GetMobByID(zone:getLocalVar("Tarasca")):isAlive() then
                heavystomp = 0
            end
            if not GetMobByID(zone:getLocalVar("Vishap")):isAlive() then
                poisonbreath = 0
            end
            if mob:getLocalVar("familiarcharm") == 0 then
                charm = 0
            end
        
            local totalchance = voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath + lodesong + heavystomp + poisonbreath + charm
            local randomchance = math.random(1, totalchance)
        
            -- Choose Skill
            if randomchance >= (totalchance - voidsong) then
                return 649 -- Voidsong
            elseif randomchance >= (totalchance - (voidsong + chaosblade)) then
                return 647 -- Chaos Blade
            elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam)) then
                return 645 -- Body Slam
            elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes)) then
                return 648 -- Petro Eyes
            elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath)) then
                return 644 -- Wind Breath
            elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong)) then
                return 650 -- Thornsong
            elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath)) then
                return 642 -- Flame Breath
            elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath + lodesong)) then
                return 651 -- Lodesong
            elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath + lodesong + heavystomp)) then
                return 646 -- Heavy Stomp
            elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath + lodesong + heavystomp + poisonbreath)) then
                return 643 -- Poison Breath
            elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath + lodesong + heavystomp + poisonbreath + charm)) then
                return 710 -- Charm
            else
                return 0
            end
        end
        onMobWeaponSkill = function( target, mob, skill) end
        onMobDeath = function(mob, player, isKiller) 
            xi.dynamis.megaBossOnDeath(mob, player, mobVar)
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
        onMobSpawn = function(mob) 
            xi.dynamis.setMegaBossStats(mob)
            -- Set Removable Mods
            mob:addMod(xi.mod.REGEN, 1000)
            mob:addMod(xi.mod.CRITHITRATE, 100)
            mob:addMod(xi.mod.UDMGRANGE, -99)
            mob:addMod(xi.mod.UDMGPHYS, -99)
            mob:addMod(xi.mod.UDMGBREATH, -99)
            mob:addMod(xi.mod.FIRERES, 1000)
            mob:addMod(xi.mod.ICERES, 1000)
            mob:addMod(xi.mod.WINDRES, 1000)
            mob:addMod(xi.mod.EARTHRES, 1000)
            mob:addMod(xi.mod.THUNDERRES, 1000)
            mob:addMod(xi.mod.WATERRES, 1000)
            mob:addMod(xi.mod.LIGHTRES, 1000)
            mob:addMod(xi.mod.DARKRES, 1000)
            -- Set Non-Removable Mods
            -- Anateus should not standback and should be able to avoid most RAs via melee range. (https://ffxiclopedia.fandom.com/wiki/Antaeus)
            mob:addMobMod(xi.mobMod.NO_STANDBACK, 1)
            -- Sleep Res and Lullaby Res are unverified but added in case (https://ffxiclopedia.fandom.com/wiki/Antaeus)
            mob:addMod(xi.mod.SLEEPRES, 99)
            mob:addMod(xi.mod.LULLABYRES, 99)
            -- Adding Normal Dynamis Boss Resistances and Regain
            mob:addMod(xi.mod.GRAVITYRES, 40)
            mob:addMod(xi.mod.BINDRES, 40)
            mob:addMod(xi.mod.REGAIN, 50)
        end
        onMobEngaged = function(mob) xi.dynamis.parentOnEngaged(mob, target) end
        onMobFight = function(mob) 
            local zone = mob:getZone()
            -- Remove Mods Per NM or Elemental Kill
            if not GetMobByID(zone:getLocalVar("Scolopendra")):isAlive() then
                if mob:getMod(xi.mod.REGEN) ~= 0 then
                    mob:setMod(xi.mod.REGEN, 0)
                end
            end
            if not GetMobByID(zone:getLocalVar("Stringes")):isAlive() then
                if mob:getMod(xi.mod.CRITHITRATE) ~= 10 then
                    mob:setMod(xi.mod.CRITHITRATE, 10)
                end
            end
            if not GetMobByID(zone:getLocalVar("Suttung")):isAlive() then
                if mob:getMod(xi.mod.UDMGPHYS) ~= 0 then
                    mob:setMod(xi.mod.UDMGRANGE, 0)
                    mob:setMod(xi.mod.UDMGPHYS, 0)
                    mob:setMod(xi.mod.UDMGBREATH, 0)
                    mob:setMod(xi.mod.UDMGRANGE, 0)
                end
            end
            if not GetMobByID(zone:getLocalVar("Fire_Elemental")):isAlive() then
                if mob:getMod(xi.mod.FIRERES) ~= 0 then
                    mob:setMod(xi.mod.FIRERES, 0)
                end
            end
            if not GetMobByID(zone:getLocalVar("Ice_Elemental")):isAlive() then
                if mob:getMod(xi.mod.ICERES) ~= 0 then
                    mob:setMod(xi.mod.ICERES, 0)
                end
            end
            if not GetMobByID(zone:getLocalVar("Air_Elemental")):isAlive() then
                if mob:getMod(xi.mod.WINDRES) ~= 0 then
                    mob:setMod(xi.mod.WINDRES, 0)
                end
            end
            if not GetMobByID(zone:getLocalVar("Earth_Elemental")):isAlive() then
                if mob:getMod(xi.mod.EARTHRES) ~= 0 then
                    mob:setMod(xi.mod.EARTHRES, 0)
                end
            end
            if not GetMobByID(zone:getLocalVar("Thunder_Elemental")):isAlive() then
                if mob:getMod(xi.mod.THUNDERRES) ~= 0 then
                    mob:setMod(xi.mod.THUNDERRES, 0)
                end
            end
            if not GetMobByID(zone:getLocalVar("Water_Elemental")):isAlive() then
                if mob:getMod(xi.mod.WATERRES) ~= 0 then
                    mob:setMod(xi.mod.WATERRES, 0)
                end
            end
            if not GetMobByID(zone:getLocalVar("Light_Elemental")):isAlive() then
                if mob:getMod(xi.mod.LIGHTRES) ~= 0 then
                    mob:setMod(xi.mod.LIGHTRES, 0)
                end
            end
            if not GetMobByID(zone:getLocalVar("Dark_Elemental")):isAlive() then
                if mob:getMod(xi.mod.DARKRES) ~= 0 then
                    mob:setMod(xi.mod.DARKRES, 0)
                end
            end

        end
        onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end
        onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end
        onMobMagicPrepare = function(mob, target) end
        onMobWeaponSkillPrepare = function(mob, target) end
        onMobWeaponSkill = function( target, mob, skill) end
        onMobDeath = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end
    elseif mobName == "Cirrate Christelle" then
        mobVar =  nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = nmInfoLookup[mobName][1]
        groupIdFound = nmInfoLookup[mobName][2]
        groupZoneFound = nmInfoLookup[mobName][3]
        onMobSpawn = function(mob) 
            xi.dynamis.setMegaBossStats(mob)
            -- Set Mods
            mob:speed(140)
            mob:addMod(xi.mod.REGAIN, 1250)
            mob:SetAutoAttackEnabled(false)
        end
        onMobEngaged = function(mob) xi.dynamis.parentOnEngaged(mob, target) end
        onMobFight = function(mob) 
            local zone = mob:getZone()
            if not GetMobByID(zone:getLocalVar("Dragontrap_1")):isAlive() and GetMobByID(zone:getLocalVar("Dragontrap_2")):isAlive() and GetMobByID(zone:getLocalVar("Dragontrap_3")):isAlive() then
                if mob:getLocalVar("PetsSpawned") ~= 1 then
                local OMobIndex = mobIndex
                local OMob = mob
                local i = 1
                local pets =
                {
                    {"4650756b" , 130, 134, 0, nil, nil}, -- FPuk
                }
                    while i <= 2 do
                        local mob = zone:insertDynamicEntity({
                            objtype = xi.objType.MOB,
                            name = pets[1],
                            x = oMob:getXPos()+math.random()*6-3,
                            y = oMob:getYPos()-0.3,
                            z = oMob:getXPos()+math.random()*6-3,
                            rotation = oMob:getRotPos(),
                            groupId = pets[2],
                            groupZoneId = pets[3],
                            onMobSpawn = function(mob) xi.dynamis.setNMStats(mob) end,
                            onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end,
                            onMobFight = function(mob) xi.dynamis.mobOnFight(mob) end,
                            onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end,
                            onMobDeath = function(mob, playerArg, isKiller)
                                xi.dynamis.mobOnDeath(mob, mobList[mob:getZoneID()], zones[mob:getZoneID()].text.DYNAMIS_TIME_EXTEND)
                            end,
                        })
                        mob:setSpawn(oMob:getXPos()+math.random()*6-3, oMob:getYPos()-0.3, oMob:getZPos()+math.random()*6-3, oMob:getRotPos())
                        mob:setDropID(pets[4])
                        if pets[5] ~= nil then -- If SpellList ~= nil set SpellList
                            mob:setSpellList(pets[5])
                        end
                        if pets[6] ~= nil then -- If SkillList ~= nil set SkillList
                            mob:setMobMod(xi.mobMod.SKILL_LIST, pets[6])
                        end
                        mob:setMobMod(xi.mobMod.SUPERLINK, 1)
                        OMob:setLocalVar(string.format("Nightmare_Morbol_%i", i), mob:getID())
                        mob:setLocalVar("PetMaster", OMobIndex)
                        mob:spawn()
                        mob:updateEnmity(target)
                        if i == 2 then
                            mob:setLocalVar("PetsSpawned", 1)
                        end
                    end
                    i = i + 1
                end
            end

            if not GetMobByID(zone:getLocalVar("Dragontrap_1")):isAlive() and GetMobByID(zone:getLocalVar("Dragontrap_2")):isAlive() and GetMobByID(zone:getLocalVar("Dragontrap_3")):isAlive() then
                mob:setLocalVar("putridbreathcap", 500)
            end
            if not GetMobByID(zone:getLocalVar("Fairy_Ring")):isAlive() then
                mob:speed(40)
                mob:setLocalVar("miasmicbreathpower", 30)
            end
            if not GetMobByID(zone:getLocalVar("Nanatina")):isAlive() then
                mob:setLocalVar("fragrantbreathduration", 30)
            end
            if not GetMobByID(zone:getLocalVar("Stcemqestcint")):isAlive() then
                mob:setLocalVar("vampiriclashpower", 1)
            end

        end
        onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end
        onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end
        onMobMagicPrepare = function(mob, target) end
        onMobWeaponSkillPrepare = function(mob, target) 
            -- Set Locals
            local ID = zones[zone]
            local fragrantbreath = 24
            local miasmicbreath = 24
            local putridbreath = 24
            local vampiriclash = 24
            local randomchance = math.random(1, 100)
            local totalchance = 100

            -- Set Probabilities of Each Skill Based on NM Kill Status
            if not GetMobByID(zone:getLocalVar("Nanatina")):isAlive() then
                fragrantbreath = 12
            end
            if not GetMobByID(zone:getLocalVar("Fairy_Ring")):isAlive() then
                miasmicbreath = 12
            end
            if not GetMobByID(zone:getLocalVar("Dragontrap_1")):isAlive() and GetMobByID(zone:getLocalVar("Dragontrap_2")):isAlive() and GetMobByID(zone:getLocalVar("Dragontrap_3")):isAlive() then
                putridbreath = 12
            end
            if not GetMobByID(zone:getLocalVar("Stcemqestcint")):isAlive() then
                vampiriclash = 12
            end

            -- Choose Skill
            if randomchance >= (totalchance - fragrantbreath) then
                return 1607 -- Fragrant Breath
            elseif randomchance >= (totalchance - (fragrantbreath + miasmicbreath)) then
                return 1605 -- Miasmic Breath
            elseif randomchance >= (totalchance - (fragrantbreath + miasmicbreath + putridbreath)) then
                return 1609 -- Putrid Breath
            elseif randomchance >= (totalchance - (fragrantbreath + miasmicbreath + putridbreath + vampiriclash)) then
                return 1611 -- Vampiric Lash
            else
                return 1610 -- Extremely Bad Breath: Gains Chance as Other Skills are Mitigated
            end
        end
        onMobWeaponSkill = function( target, mob, skill) end
        onMobDeath = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end
    elseif mobName == "Dynamis Lord" then
        mobVar =  nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = nmInfoLookup[mobName][1]
        groupIdFound = nmInfoLookup[mobName][2]
        groupZoneFound = nmInfoLookup[mobName][3]
        onMobSpawn = function(mob)
            dialogDL = 7272
            local zone = mob:getZone()
            xi.dynamis.setMegaBossStats(mob) 
            mob:setMod(xi.mod.SLEEPRESTRAIT, 100)
            mob:setMod(xi.mod.BINDRESTRAIT, 100)
            mob:setMod(xi.mod.GRAVITYRESTRAIT, 100)
            mob:setMod(xi.mod.BINDRESTRAIT, 100)
            mob:setMod(xi.mod.UFASTCAST, 100)
            zone:setLocalVar("MainDynaLord", mob:getID())
            mob:setLocalVar("tpTime", 0)
            mob:SetAutoAttackEnabled(false)
            mob:SetMagicCastingEnabled(false)

            xi.mix.jobSpecial.config(mob, {
                between = 60,
                specials =
                {
                    {id = xi.jsa.HUNDRED_FISTS, hpp = 95, begCode = function(mob) mob:messageText(mob, dialogDL + 11) end},
                    {id = xi.jsa.MIGHTY_STRIKES, hpp = 95, begCode = function(mob) mob:messageText(mob, dialogDL + 14) end},
                    {id = xi.jsa.BLOOD_WEAPON, hpp = 95, begCode = function(mob) mob:messageText(mob, dialogDL + 12) end},
                    {id = xi.jsa.CHAINSPELL, hpp = 50, begCode = function(mob) mob:messageText(mob, dialogDL + 13) end},
                },
            })
        end
        onMobEngaged = function(mob)
            local zone = mob:getZone()
            mob:setLocalVar("teraTime", os.time() + math.random(90,120))
            mob:setLocalVar("lastPetPop", os.time() + 60)
            local mainLord = zone:getLocalVar("MainDynaLord")
            if mob:getID() == mainLord then
                mob:showText(mob, dialogDL + 8) -- Immortal Drakes, deafeated
            end
        end
        onMobFight = function(mob)
            local zone = mob:getZone()
            local tpTime = mob:getLocalVar("tpTime")
            local mainLord = zone:getLocalVar("MainDynaLord")
            local ying = GetMobByID(zone:getLocalVar("Ying"))
            local yang = GetMobByID(zone:getLocalVar("Yang"))
            if os.time() > tpTime and tpTime ~= 0 then
                local cloneMove = zone:getLocalVar("CloneMove")
                mob:useMobAbility(cloneMove)
                mob:setLocalVar("tpTime", 0)
                GetMobByID(mainLord):setLocalVar("teraTime", os.time() + math.random(90,120))
            elseif tpTime == 0 or os.time() > tpTime then
                mob:SetAutoAttackEnabled(true)
                mob:SetMagicCastingEnabled(true)
            end

            if mob:getLocalVar("WeaponskillPerformed") == 1 and mob:getID() ~= mainLord then
                DespawnMob(mog:getID())
            else
                mob:setLocalVar("WeaponskillPerformed", 0)
            end

            local alreadyPopped = false

            if os.time() - mob:getLocalVar("lastPetPop") > 30 then
                local pets = 
                {
                    ["Ying"] = {"4650756b" , 130, 134, 0, nil, nil}, -- Ying
                    ["Yang"] = {"4650756b" , 130, 134, 0, nil, nil}, -- Yang
                }
                for _, dwagon in pairs(pets) do
                    if GetMobByID(string.format("%s", pets[dwagon])):isAlive() then
                        break
                    else
                        mob:entityAnimationPacket("casm")
                        mob:SetAutoAttackEnabled(false)
                        mob:SetMagicCastingEnabled(false)
                        mob:SetMobAbilityEnabled(false)
                        mob:timer(3000, function(mob) 
                            local pet = zone:insertDynamicEntity({
                            objtype = xi.objType.MOB,
                            name = pets[dwagon][1],
                            x = -414.282,
                            y = -44,
                            z = 20.427,
                            rotation = mob:getRotPos(),
                            groupId = pets[dwagon][2],
                            groupZoneId = pets[dwagon][3],
                            onMobSpawn = function(pet) xi.dynamis.setNMStats(pet) end,
                            onMobRoam = function(pet) xi.dynamis.mobOnRoam(pet) end,
                            onMobFight = function(pet) xi.dynamis.mobOnFight(pet) end,
                            onMobRoamAction = function(pet) xi.dynamis.mobOnRoamAction(pet) end,
                            onMobDeath = function(pet, playerArg, isKiller) end,
                            })
                            pet:setSpawn(-414.282, -44, 20.427, mob:getRotPos())
                            mob:setDropID(pets[dwagon][4])
                            if pets[dwagon][5] ~= nil then -- If SpellList ~= nil set SpellList
                                pet:setSpellList(pets[dwagon][5])
                            end
                            if pets[dwagon][6] ~= nil then -- If SkillList ~= nil set SkillList
                                pet:setMobMod(xi.mobMod.SKILL_LIST, pets[dwagon][6])
                            end
                            pet:setMobMod(xi.mobMod.SUPERLINK, 1)
                            mob:setLocalVar(string.format("%s", pets[dwagon]), pet:getID())
                            pet:setLocalVar("PetMaster", mob:getID())
                            zone:setLocalVar(string.format("%s", pets[dwagon]), pet:getID())
                            if mob:isAlive() then
                                mob:entityAnimationPacket("shsm")
                                mob:SetAutoAttackEnabled(true)
                                mob:SetMagicCastingEnabled(true)
                                mob:SetMobAbilityEnabled(true)
                                pet:spawn()
                                pet:updateEnmity(target)
                                mob:setLocalVar("lastPetPop", os.time() +30)
                                if mob:getLocalVar("initialSpawnDialog") == 0 and mob:getID() == mainLord then
                                    mob:showText(mob, dialogDL +7)
                                    mob:setLocalVar("initialSpawnDialog", 1)
                                end
                            end
                        end)
                    end
                end
            end

            if ying:isAlive() and ying:getCurrentAction() == xi.act.ROAMING then
                ying:updateEnmity(target)
            end
            if yang:isAlive() and yang:getCurrentAction() == xi.act.ROAMING then
                yang:updateEnmity(target)
            end

            -- Dynamis Lord spawns clones of himself 1 1/2 - 2min after pull that use a TP move in unison and despawn after
            local teraTime = mob:getLocalVar("teraTime")
            if os.time() > teraTime and mob:getID() == mainLord then
                local targetList = mob:getEnmityList()
                local i = 1
                mob:entityAnimationPacket("casm")
                mob:SetAutoAttackEnabled(false)
                mob:SetMagicCastingEnabled(false)
                mob:SetMobAbilityEnabled(false)
                mob:timer(3000, function(mob) 
                    while i <= 5 do
                        local victim = math.random(#targetList)
                        local victimPos = targetList[victim].entity:getPos()
                        local clone = zone:insertDynamicEntity({
                        objtype = xi.objType.MOB,
                        name = nmInfoLookup["Dynamis Lord"][1],
                        x = victimPos.x,
                        y = victimPos.y,
                        z = victimPos.z,
                        rotation = mob:getRotPos(),
                        groupId = nmInfoLookup["Dynamis Lord"][2],
                        groupZoneId = nmInfoLookup["Dynamis Lord"][3],
                        onMobSpawn = function(pet) xi.dynamis.setNMStats(pet) end,
                        onMobRoam = function(pet) xi.dynamis.mobOnRoam(pet) end,
                        onMobFight = function(pet) xi.dynamis.mobOnFight(pet) end,
                        onMobRoamAction = function(pet) xi.dynamis.mobOnRoamAction(pet) end,
                        onMobDeath = function(pet, playerArg, isKiller) end,
                        })
                        clone:setSpawn(victimPos.x, victimPos.y, victimPos.z, mob:getRotPos())
                        mob:setDropID(nmInfoLookup["Dynamis Lord"][4])
                        if nmInfoLookup["Dynamis Lord"][5] ~= nil then -- If SpellList ~= nil set SpellList
                            clone:setSpellList(nmInfoLookup["Dynamis Lord"][5])
                        end
                        if nmInfoLookup["Dynamis Lord"][6] ~= nil then -- If SkillList ~= nil set SkillList
                            clone:setMobMod(xi.mobMod.SKILL_LIST, nmInfoLookup["Dynamis Lord"][6])
                        end
                        clone:setMobMod(xi.mobMod.SUPERLINK, 1)
                        zone:setLocalVar(string.format("Dynamis_Lord_%i", i), clone:getID())
                        clone:spawn()
                        clone:setHP(mob:getHP())
                        clone:updateEnmity(targetList[victim].entity)
                        clone:setLocalVar("tpTime", os.time() + 2)
                    end
                    i = i + 1
                    if mob:isAlive() then
                        mob:entityAnimationPacket("shsm")
                        mob:SetAutoAttackEnabled(true)
                        mob:SetMagicCastingEnabled(true)
                        mob:SetMobAbilityEnabled(true)
                        local newDynaLord = zone:getLocalVar(string.format("Dynamis_Lord_%i", math.random(1, 5)))
                        zone:setLocalVar("MainDynaLord", newDynaLord)
                    end
                end)
            end
        end
        onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end
        onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end
        onMobMagicPrepare = function(mob, target) 
            local rnd = math.random(0, 1000)
            -- Dynamis Lord has a small chance to choose death
            if rnd <= 0.05 then
                return 367 -- Death
            end
        end
        onMobWeaponSkillPrepare = function(mob, target) 
            -- at or below 25% hp, tera slash & oblivion smash have a chance to insta death on hit.
            -- each has two animations per skill, one jumping (insta death) the other standing on the ground.
            if mob:getHPP() <= 25 then
                if math.random() < 0.25 then
                    return 1135
                elseif math.random() < 0.50 then
                    return 1133
                elseif math.random() < 0.75 then
                    return 1134
                else
                    return 1132
                end
            end
        end
        onMobWeaponSkill = function( target, mob, skill) 
            local zone = mob:getZone()
            local mainLord = zone:getLocalVar("MainDynaLord")
            if skill:getID() == 1135 and mob:getID() == mainLord then
                mob:showText(mob, dialogDL + 1)
            end
            mob:setLocalVar("WeaponskillPerformed", 1)
        end
        onMobDeath = function(mob, player, isKiller)
            local zone = mob:getZone()
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
        onMobSpawn = function(mob) 
            local zone = mob:getZone()
            local dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
            xi.dynamis.setNMStats(mob)
            if dynaLord:getLocalVar("magImmune") < 2 then -- both dragons have not been killed initially
                dynaLord:setMod(xi.mod.UDMGMAGIC, -100)
                dynaLord:setMod(xi.mod.UDMGBREATH, -100)
                dynaLord:setLocalVar("magImmune", 0)
                mob:setSpawn(-364, -35.661, 17.254) -- Reset Ying's spawn point to initial spot.
            else
                mob:setSpawn(-414.282, -44, 20.427) -- Spawned by DL, reset to DL's spawn point.
            end
        end
        onMobEngaged = function(mob) end
        onMobFight = function(mob, target) 
            local zone = mob:getZone()
            local yang = GetMobByID(zone:getLocalVar("Yang"))
            local yangToD = mob:getLocalVar("yangToD")
            -- Repop Yang every 30 seconds if Ying is up and Yang is not.
            if not yang:isSpawned() and os.time() > yangToD + 30 then
                yang:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                yang:spawn()
                yang:updateEnmity(target)
            end
        end
        onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end
        onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end
        onMobMagicPrepare = function(mob, target) end
        onMobWeaponSkillPrepare = function(mob, target) end
        onMobWeaponSkill = function( target, mob, skill) end
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
        onMobSpawn = function(mob) 
            local zone = mob:getZone()
            local dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
            xi.dynamis.setNMStats(mob)
            if dynaLord:getLocalVar("magImmune") < 2 then -- both dragons have not been killed initially
                dynaLord:setMod(xi.mod.UDMGMAGIC, -100)
                dynaLord:setMod(xi.mod.UDMGBREATH, -100)
                dynaLord:setLocalVar("magImmune", 0)
                mob:setSpawn(-364, -35.661, 17.254) -- Reset Ying's spawn point to initial spot.
            else
                mob:setSpawn(-414.282, -44, 20.427) -- Spawned by DL, reset to DL's spawn point.
            end
        end
        onMobEngaged = function(mob) end
        onMobFight = function(mob, target) 
            local zone = mob:getZone()
            local ying = GetMobByID(zone:getLocalVar("Ying"))
            local yingToD = mob:getLocalVar("yingToD")
            -- Repop ying every 30 seconds if Ying is up and ying is not.
            if not ying:isSpawned() and os.time() > yingToD + 30 then
                ying:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                ying:spawn()
                ying:updateEnmity(target)
            end
        end
        onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end
        onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end
        onMobMagicPrepare = function(mob, target) end
        onMobWeaponSkillPrepare = function(mob, target) end
        onMobWeaponSkill = function( target, mob, skill) end
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