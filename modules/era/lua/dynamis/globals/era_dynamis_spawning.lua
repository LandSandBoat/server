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
require("modules/era/lua/dynamis/mobs/era_antaeus")
mixins = {require("scripts/mixins/job_special")}
require("modules/module_utils")

local m = Module:new("era_dynamis_spawning")

xi = xi or {}
xi.dynamis = xi.dynamis or {}

--------------------------------------------
--          Dynamis Mob Spawning          --
--------------------------------------------

xi.dynamis.spawnWave = function(zone, zoneID, waveNumber)
    for _, index in pairs(xi.dynamis.mobList[zoneID][waveNumber].wave) do
        local mobIndex = xi.dynamis.mobList[zoneID][waveNumber].wave[index]
        if mobIndex ~= nil then
            print(string.format("MobIndex: %s", mobIndex))
            local mobType = xi.dynamis.mobList[zoneID][mobIndex].info[1]
            print(string.format("MobType: %s", mobType))
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
    mob:timer(1000, function(mob, target)
        local zoneID = mob:getZoneID()
        local oMobIndex = mob:getZone():getLocalVar(string.format("MobIndex_%s", mob:getID()))
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
            xi.dynamis.normalDynamicSpawn(mob, oMobIndex) -- Normies have their own loop, so they don't need one here.
        end
    end)
end

xi.dynamis.normalDynamicSpawn = function(mob, oMobIndex)
    local mobFamily = mob:getFamily()
    local mobID = mob:getID()
    local mobZoneID = mob:getZoneID()
    local oMob = GetMobByID(mobID)
    local zone = GetZone(mobZoneID)
    local normalMobLookup =
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
                [1]  = {"48574152", 159, 134, 0, nil, nil}, -- HWAR
                [2]  = {"484d4e4b", 163, 134, 0, nil, nil}, -- HMNK
                [3]  = {"4857484d", 161, 134, 0, nil, nil}, -- HWHM
                [4]  = {"48424c4d", 164, 134, 0, nil, nil}, -- HBLM
                [5]  = {"4852444d", 162, 134, 0, nil, nil}, -- HRDM
                [6]  = {"48544846", 160, 134, 0, nil, nil}, -- HTHF
                [7]  = {"48504c44", 166, 134, 0, nil, nil}, -- HPLD
                [8]  = {"4844524b", 167, 134, 0, nil, nil}, -- HDRK
                [9]  = {"48425354", 168, 134, 0, nil, nil}, -- HBST
                [10] = {"48425244", 170, 134, 0, nil, nil}, -- HBRD
                [11] = {"48524e47", 171, 134, 0, nil, nil}, -- HRNG
                [12] = {"4853414d", 172, 134, 0, nil, nil}, -- HSAM
                [13] = {"484e494e", 173, 134, 0, nil, nil}, -- HNIN
                [14] = {"48445247", 174, 134, 0, nil, nil}, -- HDRG
                [15] = {"48534d4e", 176, 134, 0, nil, nil}, -- HSMN
            },
            [xi.zone.DYNAMIS_XARCABARD] = -- Spawn Kindred (Done)
            {
                [1]  = {"4b574152", 32, 135, 0, nil, nil}, -- KWAR
                [2]  = {"4b4d4e4b", 33, 135, 0, nil, nil}, -- KMNK
                [3]  = {"4b57484d", 29, 135, 0, nil, nil}, -- KWHM
                [4]  = {"4b424c4d", 30, 135, 0, nil, nil}, -- KBLM
                [5]  = {"4b52444d", 31, 135, 0, nil, nil}, -- KRDM
                [6]  = {"4b544846", 34, 135, 0, nil, nil}, -- KTHF
                [7]  = {"4b504c44", 15, 135, 0, nil, nil}, -- KPLD
                [8]  = {"4b44524b", 16, 135, 0, nil, nil}, -- KDRK
                [9]  = {"4b425354", 17, 135, 0, nil, nil}, -- KBST
                [10] = {"4b425244", 20, 135, 0, nil, nil}, -- KBRD
                [11] = {"4b524e47", 19, 135, 0, nil, nil}, -- KRNG
                [12] = {"4b53414d", 22, 135, 0, nil, nil}, -- KSAM
                [13] = {"4b4e494e", 23, 135, 0, nil, nil}, -- KNIN
                [14] = {"4b445247", 27, 135, 0, nil, nil}, -- KDRG
                [15] = {"4b534d4e", 24, 135, 0, nil, nil}, -- KSMN
            },
            [xi.zone.DYNAMIS_TAVNAZIA] = -- Spawn Kindred and Hydra
            {
                [2] = -- Floor 2 Spawn Hydras (Done)
                {
                    [1]  = {"48574152", 159, 134, 0, nil, nil}, -- HWAR
                    [2]  = {"484d4e4b", 163, 134, 0, nil, nil}, -- HMNK
                    [3]  = {"4857484d", 161, 134, 0, nil, nil}, -- HWHM
                    [4]  = {"48424c4d", 164, 134, 0, nil, nil}, -- HBLM
                    [5]  = {"4852444d", 162, 134, 0, nil, nil}, -- HRDM
                    [6]  = {"48544846", 160, 134, 0, nil, nil}, -- HTHF
                    [7]  = {"48504c44", 166, 134, 0, nil, nil}, -- HPLD
                    [8]  = {"4844524b", 167, 134, 0, nil, nil}, -- HDRK
                    [9]  = {"48425354", 168, 134, 0, nil, nil}, -- HBST
                    [10] = {"48425244", 170, 134, 0, nil, nil}, -- HBRD
                    [11] = {"48524e47", 171, 134, 0, nil, nil}, -- HRNG
                    [12] = {"4853414d", 172, 134, 0, nil, nil}, -- HSAM
                    [13] = {"484e494e", 173, 134, 0, nil, nil}, -- HNIN
                    [14] = {"48445247", 174, 134, 0, nil, nil}, -- HDRG
                    [15] = {"48534d4e", 176, 134, 0, nil, nil}, -- HSMN
                },
                [3] = -- Floor 3 Spawn Kindred (Done)
                {
                    [1]  = {"4b574152", 32, 135, 0, nil, nil}, -- KWAR
                    [2]  = {"4b4d4e4b", 33, 135, 0, nil, nil}, -- KMNK
                    [3]  = {"4b57484d", 29, 135, 0, nil, nil}, -- KWHM
                    [4]  = {"4b424c4d", 30, 135, 0, nil, nil}, -- KBLM
                    [5]  = {"4b52444d", 31, 135, 0, nil, nil}, -- KRDM
                    [6]  = {"4b544846", 34, 135, 0, nil, nil}, -- KTHF
                    [7]  = {"4b504c44", 15, 135, 0, nil, nil}, -- KPLD
                    [8]  = {"4b44524b", 16, 135, 0, nil, nil}, -- KDRK
                    [9]  = {"4b425354", 17, 135, 0, nil, nil}, -- KBST
                    [10] = {"4b425244", 20, 135, 0, nil, nil}, -- KBRD
                    [11] = {"4b524e47", 19, 135, 0, nil, nil}, -- KRNG
                    [12] = {"4b53414d", 22, 135, 0, nil, nil}, -- KSAM
                    [13] = {"4b4e494e", 23, 135, 0, nil, nil}, -- KNIN
                    [14] = {"4b445247", 27, 135, 0, nil, nil}, -- KDRG
                    [15] = {"4b534d4e", 24, 135, 0, nil, nil}, -- KSMN
                },
            },
        },
        [92] = -- Goblin Replica
        {
            [1]  = {"48574152", 159, 134, 0, nil, nil}, -- GWAR
            [2]  = {"484d4e4b", 163, 134, 0, nil, nil}, -- GMNK
            [3]  = {"4857484d", 161, 134, 0, nil, nil}, -- GWHM
            [4]  = {"48424c4d", 164, 134, 0, nil, nil}, -- GBLM
            [5]  = {"4852444d", 162, 134, 0, nil, nil}, -- GRDM
            [6]  = {"48544846", 160, 134, 0, nil, nil}, -- GTHF
            [7]  = {"48504c44", 166, 134, 0, nil, nil}, -- GPLD
            [8]  = {"4844524b", 167, 134, 0, nil, nil}, -- GDRK
            [9]  = {"48425354", 168, 134, 0, nil, nil}, -- GBST
            [10] = {"48425244", 170, 134, 0, nil, nil}, -- GBRD
            [11] = {"48524e47", 171, 134, 0, nil, nil}, -- GRNG
            [12] = {"4853414d", 172, 134, 0, nil, nil}, -- GSAM
            [13] = {"484e494e", 173, 134, 0, nil, nil}, -- GNIN
            [14] = {"48445247", 174, 134, 0, nil, nil}, -- GDRG
            [15] = {"48534d4e", 176, 134, 0, nil, nil}, -- GSMN
        },
        [93] = -- Orc Statue
        {
            [1]  = {"48574152", 159, 134, 0, nil, nil}, -- OWAR
            [2]  = {"484d4e4b", 163, 134, 0, nil, nil}, -- OMNK
            [3]  = {"4857484d", 161, 134, 0, nil, nil}, -- OWHM
            [4]  = {"48424c4d", 164, 134, 0, nil, nil}, -- OBLM
            [5]  = {"4852444d", 162, 134, 0, nil, nil}, -- ORDM
            [6]  = {"48544846", 160, 134, 0, nil, nil}, -- OTHF
            [7]  = {"48504c44", 166, 134, 0, nil, nil}, -- OPLD
            [8]  = {"4844524b", 167, 134, 0, nil, nil}, -- ODRK
            [9]  = {"48425354", 168, 134, 0, nil, nil}, -- OBST
            [10] = {"48425244", 170, 134, 0, nil, nil}, -- OBRD
            [11] = {"48524e47", 171, 134, 0, nil, nil}, -- ORNG
            [12] = {"4853414d", 172, 134, 0, nil, nil}, -- OSAM
            [13] = {"484e494e", 173, 134, 0, nil, nil}, -- ONIN
            [14] = {"48445247", 174, 134, 0, nil, nil}, -- ODRG
            [15] = {"48534d4e", 176, 134, 0, nil, nil}, -- OSMN
        },
        [94] = -- Quadav Statue (Done)
        {
            [1]  = {"51574152", 19, 134, 0, nil, nil}, -- QWAR
            [2]  = {"514d4e4b", 25, 134, 0, nil, nil}, -- QMNK
            [3]  = {"5157484d", 29, 134, 0, nil, nil}, -- QWHM
            [4]  = {"51424c4d", 42, 134, 0, nil, nil}, -- QBLM
            [5]  = {"5152444d", 20, 134, 0, nil, nil}, -- QRDM
            [6]  = {"51544846", 33, 134, 0, nil, nil}, -- QTHF
            [7]  = {"51504c44", 30, 134, 0, nil, nil}, -- QPLD
            [8]  = {"5144524b", 38, 134, 0, nil, nil}, -- QDRK
            [9]  = {"51425354", 21, 134, 0, nil, nil}, -- QBST
            [10] = {"51425244", 23, 134, 0, nil, nil}, -- QBRD
            [11] = {"51524e47", 34, 134, 0, nil, nil}, -- QRNG
            [12] = {"5153414d", 31, 134, 0, nil, nil}, -- QSAM
            [13] = {"514e494e", 32, 134, 0, nil, nil}, -- QNIN
            [14] = {"51445247", 26, 134, 0, nil, nil}, -- QDRG
            [15] = {"51534d4e", 35, 134, 0, nil, nil}, -- QSMN
        },
        [95] = -- Yagudo Statue
        {
            [1]  = {"48574152", 159, 134, 0, nil, nil}, -- YWAR
            [2]  = {"484d4e4b", 163, 134, 0, nil, nil}, -- YMNK
            [3]  = {"4857484d", 161, 134, 0, nil, nil}, -- YWHM
            [4]  = {"48424c4d", 164, 134, 0, nil, nil}, -- YBLM
            [5]  = {"4852444d", 162, 134, 0, nil, nil}, -- YRDM
            [6]  = {"48544846", 160, 134, 0, nil, nil}, -- YTHF
            [7]  = {"48504c44", 166, 134, 0, nil, nil}, -- YPLD
            [8]  = {"4844524b", 167, 134, 0, nil, nil}, -- YDRK
            [9]  = {"48425354", 168, 134, 0, nil, nil}, -- YBST
            [10] = {"48425244", 170, 134, 0, nil, nil}, -- YBRD
            [11] = {"48524e47", 171, 134, 0, nil, nil}, -- YRNG
            [12] = {"4853414d", 172, 134, 0, nil, nil}, -- YSAM
            [13] = {"484e494e", 173, 134, 0, nil, nil}, -- YNIN
            [14] = {"48445247", 174, 134, 0, nil, nil}, -- YDRG
            [15] = {"48534d4e", 176, 134, 0, nil, nil}, -- YSMN
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
                onMobRoam = function(mob) end,
                onMobRoamAction = function(mob)  end,
                onMobDeath = function(mob, playerArg, isKiller)
                    xi.dynamis.mobOnDeath(mob)
                end,
                --releaseIdOnDeath = true
            })
            mob:setSpawn(oMob:getXPos()+math.random()*6-3, oMob:getYPos()-0.3, oMob:getZPos()+math.random()*6-3, oMob:getRotPos())
            mob:spawn()
            mob:setDropID(nameObj[job][4])
            if nameObj[job][5] ~= nil then -- If SpellList ~= nil set SpellList
                mob:setSpellList(nameObj[job][5])
            end
            if nameObj[job][6] ~= nil then -- If SkillList ~= nil set SkillList
                mob:setMobMod(xi.mobMod.SKILL_LIST, nameObj[job][6])
            end
            if oMob ~= nil and oMob ~= 0 then
                mob:setLocalVar("Parent", oMob:getID())
                mob:updateEnmity(GetMobByID(oMob:getID()):getTarget())
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
            ["Vanguard Eye"] = {"56457965" , 163, 134, 0, nil, nil}, -- Vanguard Eye (VEye)
            ["Prototype Eye"] = {"50457965" , 61, 42, 0, nil, nil}, -- Prototype Eye (PEye)
            ["Goblin Statue"] = {"4753746174" , 158, 134, 0, nil, nil}, -- Goblin Statue (GStat)
            ["Goblin Replica"] = {"475253746174" , 157, 134, 0, nil, nil}, -- Goblin Statue (GRStat)
            ["Statue Prototype"] = {"475053746174" , 36, 42, 0, nil, nil}, -- Goblin Statue (GPStat)
            ["Serjeant Tombstone"] = {"4f53746174" , 89, 134, 0, nil, nil}, -- Orc Statue (OStat)
            ["Warchief Tombstone"] = {"4f5753746174" , 90, 134, 0, nil, nil}, -- Orc Statue (OWStat)
            ["Tombstone Prototype"] = {"545053746174" , 20, 42, 0, nil, nil}, -- Orc Statue (TPStat)
            ["Adamantking Effigy"] = {"5153746174" , 55, 134, 0, nil, nil}, -- Quadav Statue (QStat)
            ["Adamantking Image"] = {"514953746174" , 56, 134, 0, nil, nil}, -- Quadav Statue (QIStat)
            ["Effigy Prototype"] = {"515053746174" , 9, 42, 0, nil, nil}, -- Quadav Statue (QPStat)
            ["Avatar Idol"] = {"5953746174" , 124, 134, 0, nil, nil}, -- Yagudo Statue (YStat)
            ["Manifest Icon"] = {"594d53746174" , 68, 39, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Avatar Icon"] = {"414953746174" , 123, 134, 0, nil, nil}, -- Yagudo Statue (AIStat)
            ["Icon Prototype"] = {"595053746174" , 32, 42, 0, nil, nil}, -- Yagudo Statue (YPStat)
        },
        ["Nightmare"] =
        {
            ["Nightmare Bunny"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Cockatrice"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Crab"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Dhalmel"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Eft"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Mandragora"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Raven"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Scorpion"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Urganite"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Cluster"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Hornet"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Leech"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Makara"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Taurus"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Antlion"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Bugard"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Worm"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Hippogryph"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Manticore"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Sabotender"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Sheep"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
            ["Nightmare Fly"] = {"594d53746174" , 130, 134, 0, nil, nil}, -- Yagudo Statue (YMStat)
        },
        ["TE Normal"] = 
        {
            ["Vanguard Vindicator"] = {"51574152", 19, 134, 0, nil, nil},
            ["Vanguard Constable"] = {"5157484d", 29, 134, 0, nil, nil},
            ["Vanguard Militant"] = {"514d4e4b", 25, 134, 0, nil, nil},
        },
    }
    local mobFunctions =
    {
        ["Statue"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.setStatueStats(mob, mobIndex) end},
            ["onMobEngaged"] = {function(mob, target) xi.dynamis.parentOnEngaged(mob, target) end},
            ["onMobFight"] = {function(mob) xi.dynamis.statueOnFight(mob) end},
        },
        ["Nightmare"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.setMobStats(mob) end},
            ["onMobEngaged"] = {function(mob, target) xi.dynamis.parentOnEngaged(mob, target) end},
            ["onMobFight"] = {function(mob) xi.dynamis.statueOnFight(mob) end},
        },
        ["TE Normal"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.setMobStats(mob) end},
            ["onMobEngaged"] = {function(mob, target) end},
            ["onMobFight"] = {function(mob) end},
        }
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
        onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end,
        onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end,
        onMobDeath = function(mob, playerArg, isKiller)
            xi.dynamis.mobOnDeath(mob)
        end,
        --releaseIdOnDeath = true
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
    if oMob ~= nil and oMob ~= 0 then
        mob:setLocalVar("Parent", oMob:getID())
        if forceLink == 1 then mob:updateEnmity(oMob:getTarget()) end
    end
end

xi.dynamis.nmDynamicSpawn = function(mobIndex, oMobIndex, forceLink, zoneID, target, oMob) 
    local zone = GetZone(zoneID)
    local xPos = 0
    local yPos = 0
    local zPos = 0
    local rPos = 0
    if xi.dynamis.mobList[zoneID][mobIndex].pos == nil then
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
    xi.dynamis.nmInfoLookup = 
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
            -- Dynamis Buburimu
            -- Dynamis - Bastok
            ["Aa'Nyu Dismantler"] = {"41614e79", 40, 134, 0, nil, nil, "AaNyu_killed"}, -- AaNy (DRK)
            ["Gu'Nhi Noondozer"] = {"47754e68", 53, 134, 0, nil, nil, "GuNhi_killed"}, -- GuNh (SMN)
            ["Be'Ebo Tortoisedriver"] = {"42654562", 48, 134, 0, nil, nil, "BeEbo_killed"}, -- BeEb (BST)
            ["Gi'Pha Manameister"] = {"47695068", 43, 134, 0, nil, nil, "GiPha_killed"}, -- GiPh (BLM)
            ["Ko'Dho Cannonball"] = {"4b6f4468", 46, 134, 0, nil, nil, "KoDho_killed"}, -- KoDh (MNK)
            ["Ze'Vho Fallsplitter"] = {"5a655668", 40, 134, 0, nil, nil, "ZeVho_killed"}, -- ZeVh (DRK)
            ["Effigy Shield PLD"] = {"45504c44", 30, 134, 0, nil, nil}, -- EPLD (PLD)
            ["Effigy Shield NIN"] = {"454e494e", 32, 134, 0, nil, nil}, -- ENIN (NIN)
            ["Effigy Shield BRD"] = {"45425244", 23, 134, 0, nil, nil}, -- EBRD (BRD)
            ["Effigy Shield DRK"] = {"4544524b", 38, 134, 0, nil, nil}, -- EDRK (DRK)
            ["Effigy Shield SAM"] = {"4553414d", 31, 134, 0, nil, nil}, -- ESAM (SAM)
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
        ["Gu'Dha Effigy"] = {"424d62", 1, 186, 0, nil, nil, "MegaBoss_Killed"}, -- Bastok Megaboss (BMb)
        ["Goblin Golem"] = {}, -- Jeuno Megaboss (JMb)
        ["Overlord's Tombstone"] = {}, -- Sandy Megaboss (SMb)
        ["Tzee Xicu Idol"] = {}, -- Windy Megaboss (WMb)
    }
    local nmFunctions =
    {
        ["Beastmen"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.setNMStats(mob) end},
            ["onMobEngaged"] = {function(mob, target) xi.dynamis.parentOnEngaged(mob, target) end},
            ["onMobFight"] = {function(mob) end},
            ["onMobRoam"] = {function(mob) xi.dynamis.mobOnRoam(mob) end},
            ["onMobRoamAction"] = {function(mob) xi.dynamis.mobOnRoamAction(mob) end},
            ["onMobMagicPrepare"] = {function(mob) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller)
                local zoneID = mob:getZoneID()
                local mobIndex = mob:getZone():getLocalVar(string.format("MobIndex_%s", mob:getID()))
                local mobName = xi.dynamis.mobList[zoneID][mobIndex].info[2]
                local mobVar = xi.dynamis.nmInfoLookup[mobFamily][mobName][7]
                xi.dynamis.mobOnDeath(mob, mobVar) end},
        },
        ["Statue Megaboss"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.setMegaBossStats(mob) end},
            ["onMobEngaged"] = {function(mob, target)  xi.dynamis.parentOnEngaged(mob, target) end},
            ["onMobFight"] = {function(mob) end},
            ["onMobRoam"] = {function(mob) xi.dynamis.mobOnRoam(mob) end},
            ["onMobRoamAction"] = {function(mob) xi.dynamis.mobOnRoamAction(mob) end},
            ["onMobMagicPrepare"] = {function(mob) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller)
                local zoneID = mob:getZoneID()
                local mobIndex = mob:getZone():getLocalVar(string.format("MobIndex_%s", mob:getID()))
                local mobName = xi.dynamis.mobList[zoneID][mobIndex].info[2]
                local mobVar = xi.dynamis.nmInfoLookup[mobFamily][mobName][7]
                xi.dynamis.megabossOnDeath(mob, player, mobVar) end},
        },
        -- ["Angra Mainyu"] =
        -- {
        --     ["onMobSpawn"] = {function(mob) xi.dynamis.setMegaBossStats(mob) end},
        --     ["onMobEngaged"] = {function(mob, target)  xi.dynamis.parentOnEngaged(mob, target) end},
        --     ["onMobFight"] = {function(mob) xi.dynamis.mobOnFight(mob) end},
        --     ["onMobRoam"] = {function(mob) xi.dynamis.mobOnRoam(mob) end},
        --     ["onMobRoamAction"] = {function(mob) xi.dynamis.mobOnRoamAction(mob) end},
        --     ["onMobMagicPrepare"] = {function(mob) end},
        --     ["onMobWeaponSkillPrepare"] = {function(mob) end},
        --     ["onMobWeaponSkill"] = {function(mob) end},
        --     ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end},
        -- },
        -- ["Apocalyptic Beast"] =
        -- {
        --     ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnAntaeus(mob) end},
        --     ["onMobEngaged"] = {function(mob, target)  xi.dynamis.onEngagedAntaeus(mob, target) end},
        --     ["onMobFight"] = {function(mob) xi.dynamis.onFightAntaeus(mob, target) end},
        --     ["onMobRoam"] = {function(mob) xi.dynamis.onMobRoamAntaeus(mob) end},
        --     ["onMobRoamAction"] = {function(mob) xi.dynamis.onMobRoamActionAntaeus(mob) end},
        --     ["onMobMagicPrepare"] = {function(mob) end},
        --     ["onMobWeaponSkillPrepare"] = {function(mob) end},
        --     ["onMobWeaponSkill"] = {function(mob) end},
        --     ["onMobDeath"] = {function(mob) xi.dynamis.onMobDeathAntaeus(mob, player, isKiller) end},
        -- },
        ["Antaeus"] =
        {
            ["onMobSpawn"] = {function(mob) xi.dynamis.onSpawnAntaeus(mob) end},
            ["onMobEngaged"] = {function(mob, target)  xi.dynamis.onEngagedAntaeus(mob, target) end},
            ["onMobFight"] = {function(mob, target) xi.dynamis.onFightAntaeus(mob, target) end},
            ["onMobRoam"] = {function(mob) xi.dynamis.onMobRoamAntaeus(mob) end},
            ["onMobRoamAction"] = {function(mob) xi.dynamis.onMobRoamActionAntaeus(mob) end},
            ["onMobMagicPrepare"] = {function(mob) end},
            ["onMobWeaponSkillPrepare"] = {function(mob) end},
            ["onMobWeaponSkill"] = {function(mob) end},
            ["onMobDeath"] = {function(mob, player, isKiller) xi.dynamis.onMobDeathAntaeus(mob, player, isKiller) end},
        },
    }
    if mobFamily == "Goblin" or mobFamily == "Orc" or mobFamily == "Quadav" or mobFamily == "Yagudo" or mobFamily == "Kindred" or mobFamily == "Hydra" then -- Used for Beastmen NMs to Spawn in Parallel to Non-Standards
        mobVar =  xi.dynamis.nmInfoLookup[mobFamily][mobName][7]
        mobNameFound = xi.dynamis.nmInfoLookup[mobFamily][mobName][1]
        groupIdFound = xi.dynamis.nmInfoLookup[mobFamily][mobName][2]
        groupZoneFound = xi.dynamis.nmInfoLookup[mobFamily][mobName][3]
        functionLookup = "Beastmen"
    elseif mobName == "Gu'Dha Effigy" or mobName == "Goblin Golem" or mobName == "Overlord's Tombstone" or mobName == "Tzee Xicu Idol" then -- City Dynamis Megabosses (Bastok, Jeuno, Sandy, Windy)
        mobVar =  xi.dynamis.nmInfoLookup[mobName][7]
        mobNameFound = xi.dynamis.nmInfoLookup[mobName][1]
        groupIdFound = xi.dynamis.nmInfoLookup[mobName][2]
        groupZoneFound = xi.dynamis.nmInfoLookup[mobName][3]
        functionLookup = "Statue Megaboss"
    -- elseif mobName == "Angra Mainyu" then -- Dynamis Beaucedine Megaboss
    --     mobVar =  xi.dynamis.nmInfoLookup[mobFamily][mobName][7]
    --     mobNameFound = xi.dynamis.nmInfoLookup[mobName][1]
    --     groupIdFound = xi.dynamis.nmInfoLookup[mobName][2]
    --     groupZoneFound = xi.dynamis.nmInfoLookup[mobName][3]
    --     onMobDeath = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end
    -- elseif mobName == "Apocalyptic Beast" then -- Dynamis Buburimu Megaboss
    --     mobVar =  xi.dynamis.nmInfoLookup[mobFamily][mobName][7]
    --     mobNameFound = xi.dynamis.nmInfoLookup[mobName][1]
    --     groupIdFound = xi.dynamis.nmInfoLookup[mobName][2]
    --     groupZoneFound = xi.dynamis.nmInfoLookup[mobName][3]
    --     onMobDeath = function(mob, player, isKiller)
    --         xi.dynamis.megaBossOnDeath(mob, player, isKiller)
    --         if GetMobByID(zone:getLocalVar("Aitvaras")):isAlive() then
    --             DespawnMob(zone:getLocalVar("Aitvaras"))
    --         end
    --         if GetMobByID(zone:getLocalVar("Alklha")):isAlive() then
    --             DespawnMob(zone:getLocalVar("Alklha"))
    --         end
    --         if GetMobByID(zone:getLocalVar("Barong")):isAlive() then
    --             DespawnMob(zone:getLocalVar("Barong"))
    --         end
    --         if GetMobByID(zone:getLocalVar("Basillic")):isAlive() then
    --             DespawnMob(zone:getLocalVar("Basillic"))
    --         end
    --         if GetMobByID(zone:getLocalVar("Jurik")):isAlive() then
    --             DespawnMob(zone:getLocalVar("Jurik"))
    --         end
    --         if GetMobByID(zone:getLocalVar("Koschei")):isAlive() then
    --             DespawnMob(zone:getLocalVar("Koschei"))
    --         end
    --         if GetMobByID(zone:getLocalVar("Stihi")):isAlive() then
    --             DespawnMob(zone:getLocalVar("Stihi"))
    --         end
    --         if GetMobByID(zone:getLocalVar("Stollenwurm")):isAlive() then
    --             DespawnMob(zone:getLocalVar("Stollenwurm"))
    --         end
    --         if GetMobByID(zone:getLocalVar("Tarasca")):isAlive() then
    --             DespawnMob(zone:getLocalVar("Tarasca"))
    --         end
    --         if GetMobByID(zone:getLocalVar("Vishap")):isAlive() then
    --             DespawnMob(zone:getLocalVar("Vishap"))
    --         end
    --     end
    -- elseif mobName == "Antaeus" then -- Dynamis - Qufim Megaboss
    --     mobVar =  xi.dynamis.nmInfoLookup[mobFamily][mobName][7]
    --     mobNameFound = xi.dynamis.nmInfoLookup[mobName][1]
    --     groupIdFound = xi.dynamis.nmInfoLookup[mobName][2]
    --     groupZoneFound = xi.dynamis.nmInfoLookup[mobName][3]
    --     
    -- elseif mobName == "Cirrate Christelle" then
    --     mobVar =  xi.dynamis.nmInfoLookup[mobFamily][mobName][7]
    --     mobNameFound = xi.dynamis.nmInfoLookup[mobName][1]
    --     groupIdFound = xi.dynamis.nmInfoLookup[mobName][2]
    --     groupZoneFound = xi.dynamis.nmInfoLookup[mobName][3]
    --     onMobDeath = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end
    -- elseif mobName == "Dynamis Lord" then
    --     mobVar =  xi.dynamis.nmInfoLookup[mobFamily][mobName][7]
    --     mobNameFound = xi.dynamis.nmInfoLookup[mobName][1]
    --     groupIdFound = xi.dynamis.nmInfoLookup[mobName][2]
    --     groupZoneFound = xi.dynamis.nmInfoLookup[mobName][3]
    --     onMobDeath = function(mob, player, isKiller)
    --         local zone = mob:getZone()
    --         local dialogDL = 7272
    --         xi.dynamis.megaBossOnDeath(mob, player, mobVar)
    --         if isKiller then
    --             mob:showText(mob, dialogDL + 2)
    --             DespawnMob(zone:getLocalVar("Ying"))
    --             DespawnMob(zone:getLocalVar("Yang"))
    --         end
    --         zone:setLocalVar("MainDynaLord", mob:getID())
    --     end
    -- elseif mobName == ("Fairy Ring" or "Nantina" or "Dragontrap" or "Alklha" or "Stihi" or "Basilic" or "Jurik" or "Barong" or 
    --                    "Tarasca" or "Stollenwurm" or "Koschei" or "Aitvaras" or "Vishap") then -- Dynamis Zone NMs No Auto Attack
    --     mobVar =  xi.dynamis.nmInfoLookup[mobFamily][mobName][7]
    --     mobNameFound = xi.dynamis.nmInfoLookup[mobName][1]
    --     groupIdFound = xi.dynamis.nmInfoLookup[mobName][2]
    --     groupZoneFound = xi.dynamis.nmInfoLookup[mobName][3]
    --     onMobSpawn = function(mob) xi.dynamis.setMegaBossStats(mob) 
    --         local zone = mob:getZone()
    --         zone:setLocalVar(mobVar, mob:getID())
    --         xi.dynamis.setNMStats(mob)
    --         mob:addMod(xi.mod.REGAIN, 1250)
    --         mob:SetAutoAttackEnabled(false)
    --     end
    --     onMobEngaged = function(mob) xi.dynamis.parentOnEngaged(mob, target) end
    --     onMobFight = function(mob) xi.dynamis.mobOnFight(mob) end
    --     onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end
    --     onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end
    --     onMobMagicPrepare = function(mob, target) end
    --     onMobWeaponSkillPrepare = function(mob, target) end
    --     onMobWeaponSkill = function( target, mob, skill) end
    --     onMobDeath = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end
    -- elseif mobName == ("Scolopendra" or "Suttung" or "Stringes" or "Fire Elemental" or "Water Elemental" or "Ice Elemental" or "Lightning Elemental" or 
    --                    "Earth Elemental" or "Air Elemental" or "Light Elemental" or "Dark Elemental" or "Vanguard Dragon") then -- Dynamis Zone NMs with Auto Attack
    --     mobVar =  xi.dynamis.nmInfoLookup[mobFamily][mobName][7]
    --     mobNameFound = xi.dynamis.nmInfoLookup[mobName][1]
    --     groupIdFound = xi.dynamis.nmInfoLookup[mobName][2]
    --     groupZoneFound = xi.dynamis.nmInfoLookup[mobName][3]
    --     onMobSpawn = function(mob) 
    --         local zone = mob:getZone()
    --         zone:setLocalVar(mobVar, mob:getID())
    --         xi.dynamis.setNMStats(mob)
    --     end
    --     onMobEngaged = function(mob) xi.dynamis.parentOnEngaged(mob, target) end
    --     onMobFight = function(mob) xi.dynamis.mobOnFight(mob) end
    --     onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end
    --     onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end
    --     onMobMagicPrepare = function(mob, target) end
    --     onMobWeaponSkillPrepare = function(mob, target) end
    --     onMobWeaponSkill = function( target, mob, skill) end
    --     onMobDeath = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end
    -- elseif mobName == "Ying" then
    --     mobVar =  xi.dynamis.nmInfoLookup[mobFamily][mobName][7]
    --     mobNameFound = xi.dynamis.nmInfoLookup[mobName][1]
    --     groupIdFound = xi.dynamis.nmInfoLookup[mobName][2]
    --     groupZoneFound = xi.dynamis.nmInfoLookup[mobName][3]
    --     onMobDeath = function(mob, player, isKiller) 
    --         local zone = mob:getZone()
    --         local yang = GetMobByID(zone:getLocalVar("Yang"))
    --         local dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
    --         local dialogYing = 7289
    --         if isKiller then
    --             if yang:isAlive() == true then
    --                 mob:showText(mob, dialogYing)
    --             else
    --                 mob:showText(mob, dialogYing + 2)
    --             end
    --         end

    --         yang:setLocalVar("yingToD", os.time())
    --         if dynaLord:getLocalVar("magImmune") == 0 then
    --             dynaLord:setMod(xi.mod.UDMGMAGIC, 0)
    --             dynaLord:setMod(xi.mod.UDMGBREATH, 0)
    --             if dynaLord:getLocalVar("physImmune") == 1 then -- other dragon is also dead
    --                 dynaLord:setLocalVar("physImmune", 2)
    --                 dynaLord:setLocalVar("magImmune", 2)
    --             else
    --                 dynaLord:setLocalVar("magImmune", 1)
    --             end
    --         end
    --     end
    -- elseif mobName == "Yang" then
    --     mobVar =  xi.dynamis.nmInfoLookup[mobFamily][mobName][7]
    --     mobNameFound = xi.dynamis.nmInfoLookup[mobName][1]
    --     groupIdFound = xi.dynamis.nmInfoLookup[mobName][2]
    --     groupZoneFound = xi.dynamis.nmInfoLookup[mobName][3]
    --     onMobDeath = function(mob, player, isKiller) 
    --         local zone = mob:getZone()
    --         local ying = GetMobByID(zone:getLocalVar("Ying"))
    --         local dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
    --         local dialogYing = 7290
    --         if isKiller then
    --             if ying:isAlive() == true then
    --                 mob:showText(mob, dialogYing)
    --             else
    --                 mob:showText(mob, dialogYing + 2)
    --             end
    --         end

    --         ying:setLocalVar("yingToD", os.time())
    --         if dynaLord:getLocalVar("physImmune") == 0 then
    --             dynaLord:setMod(xi.mod.UDMGMAGIC, 0)
    --             dynaLord:setMod(xi.mod.UDMGBREATH, 0)
    --             if dynaLord:getLocalVar("magImmune") == 1 then -- other dragon is also dead
    --                 dynaLord:setLocalVar("physImmune", 2)
    --                 dynaLord:setLocalVar("magImmune", 2)
    --             else
    --                 dynaLord:setLocalVar("physImmune", 1)
    --             end
    --         end
    --     end
    -- elseif string.sub(mobName, 1, 9) == "Animated " then -- Animated Weapons
    --     mobVar =  xi.dynamis.nmInfoLookup[mobFamily][mobName][7]
    --     mobNameFound = xi.dynamis.nmInfoLookup[mobName][1]
    --     groupIdFound = xi.dynamis.nmInfoLookup[mobName][2]
    --     groupZoneFound = xi.dynamis.nmInfoLookup[mobName][3]
    --     onMobSpawn = function(mob) xi.dynamis.setMegaBossStats(mob) end
    --     onMobEngaged = function(mob) xi.dynamis.parentOnEngaged(mob, target) end
    --     onMobFight = function(mob) xi.dynamis.mobOnFight(mob) end
    --     onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end
    --     onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end
    --     onMobMagicPrepare = function(mob, target) end
    --     onMobWeaponSkillPrepare = function(mob, target) end
    --     onMobWeaponSkill = function( target, mob, skill) end
    --     onMobDeath = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end
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
        onMobSpawn = nmFunctions[functionLookup]["onMobSpawn"][1],
        onMobEngaged= nmFunctions[functionLookup]["onMobEngaged"][1],
        onMobFight= nmFunctions[functionLookup]["onMobFight"][1],
        onMobRoam= nmFunctions[functionLookup]["onMobRoam"][1],
        onMobRoamAction= nmFunctions[functionLookup]["onMobRoamAction"][1],
        onMobMagicPrepare= nmFunctions[functionLookup]["onMobMagicPrepare"][1],
        onMobWeaponSkillPrepare= nmFunctions[functionLookup]["onMobWeaponSkillPrepare"][1],
        onMobWeaponSkill= nmFunctions[functionLookup]["onMobWeaponSkill"][1],
        onMobDeath= nmFunctions[functionLookup]["onMobDeath"][1],
        --releaseIdOnDeath = true
    })
    mob:setSpawn(xPos, yPos, zPos, rPos)
    mob:spawn()
    if mobFamily == nil then
        mob:setDropID(xi.dynamis.nmInfoLookup[mobName][4])
        if xi.dynamis.nmInfoLookup[mobName][5] ~= nil then -- If SpellList ~= nil set SpellList
            mob:setSpellList(xi.dynamis.nmInfoLookup[mobName][5])
        end
        if xi.dynamis.nmInfoLookup[mobName][6] ~= nil then -- If SkillList ~= nil set SkillList
            mob:setMobMod(xi.mobMod.SKILL_LIST, xi.dynamis.nmInfoLookup[mobName][6])
        end
    else
        mob:setDropID(xi.dynamis.nmInfoLookup[mobFamily][mobName][4])
        if xi.dynamis.nmInfoLookup[mobFamily][mobName][5] ~= nil then -- If SpellList ~= nil set SpellList
            mob:setSpellList(xi.dynamis.nmInfoLookup[mobFamily][mobName][5])
        end
        if xi.dynamis.nmInfoLookup[mobFamily][mobName][6] ~= nil then -- If SkillList ~= nil set SkillList
            mob:setMobMod(xi.mobMod.SKILL_LIST, xi.dynamis.nmInfoLookup[mobFamily][mobName][6])
        end
    end
    if oMobIndex ~= nil then
        mob:setLocalVar("Parent", oMobIndex)
    end
    zone:setLocalVar(string.format("MobIndex_%s", mob:getID()), mobIndex)
    mob:setLocalVar(string.format("MobIndex_%s", mob:getID()), mobIndex)
    if forceLink == true then
        mob:updateEnmity(target)
    end
    print(string.format("Mob ID: %s", mob:getID()))
end

xi.dynamis.spawnDynamicPet =function(target, mob) 
    local mobFamily = mob:getFamily()
    local isNM = mob:isMobType(MOBTYPE_NOTORIOUS)
    local mobJob = mob:getJob()
    local oMob = GetMobByID(mob:getID())
    local oMobIndex = oMob:getZone():getLocalVar(string.format("MobIndex_%s", oMob:getID()))
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
                [false] = {"56536c696d65" , 130, 134, 0, nil, nil}, -- Normal Goblin BST (VSlime)
                [true] = -- Goblin NM
                {
                    ["Routsix_Rubbertendon"] = {"56536c696d65" , 130, 134, 0, nil, nil}, -- NM Goblin BST (VSlime)
                    ["Blazax_Boneybad"] = {"56536c696d65" , 130, 134, 0, nil, nil}, -- NM Goblin BST (VSlime)
                    ["Rutrix_Hamgams"] = {"56536c696d65" , 130, 134, 0, nil, nil}, -- NM Goblin BST (VSlime)
                    ["Trailblix_Goatmug"] = {"56536c696d65" , 130, 134, 0, nil, nil}, -- NM Goblin BST (VSlime)
                    ["Woodnix_Shrillwistle"] = {"5753536c696d65" , 7, 40, 0, nil, nil}, -- NM Goblin BST (WSSlime)
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
                [false] = {"56486563", 77, 134, 0, nil, nil}, -- Normal Orc BST (VHec)
                [true] = -- Orc NM
                {
                    ["Mithraslaver_Debhabob"] = {"56486563", 77, 134, 0, nil, nil}, -- NM Orc BST (VHec)
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
                [false] = {"5653636f", 22, 134, 0, nil, nil}, -- Normal Quadav BST (VSco)
                [true] = -- Quadav NM
                {
                    ["SoGho_Adderhandler"] = {"5653636f", 22, 134, 0, nil, nil}, -- NM Quadav BST (VSco)
                    ["BeEbo_Tortoisedriver"] = {"5653636f", 22, 134, 0, nil, nil}, -- NM Quadav BST (VSco)
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
                [false] = {"4b566f75", 100, 135, 0, nil, nil}, -- Normal Kindred BST (KVou)
                [true] = -- NM Kindred
                {
                    ["Marquis_Andras"] = {"41566f75", 55, 135, 0, nil, nil}, -- NM Kindred BST (AVou)
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
                [false] = {"48486f75", 169, 134, 0, nil, nil}, -- Normal Hydra BST (HHou)
                [true] = -- Hydra NM
                {
                    ["Dagourmarche"] = {"44486f75", 169, 134, 0, nil, nil}, -- NM Hydra BST (DHou)
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
                [false] = {"5643726f", 100, 135, 0, nil, nil}, -- Normal Yagudo BST (VCro)
                [true] = -- Yagudo NM
                {
                    ["Soo_Jopo_the_Fiendking"] = {"5643726f", 100, 135, 0, nil, nil}, -- NM Yagudo BST (VCro)
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
            xi.dynamis.mobOnDeath(mob)
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

--------------------------------------------
--        Dynamis Mob Pathing/Roam        --
--------------------------------------------

xi.dynamis.mobOnRoamAction = function(mob) -- Handle statue pathing.
    
end

xi.dynamis.mobOnRoam = function(mob) 
    if mob:getRoamFlags() == xi.roamFlag.EVENT then
        local zoneID = mob:getZoneID()
        local mobIndex = mob:getLocalVar(string.format("MobIndex_%s", mob:getID()))
        for key, index in pairs(xi.dynamis.mobList[zoneID].patrolPaths) do
            local table = xi.dynamis.mobList[zoneID][index].patrolPath
            if mobIndex == index then
                local flags = xi.path.flag.RUN
                local home = {table[1], table[2], table[3]}
                local dest = {table[4], table[5], table[6]}
                local spawn = mob:getSpawnPos()
                local current = {mob:getXPos(), mob:getYPos(), mob:getZPos()}
                if current[1] == home[1] and current[3] == home[3] then
                    mob:pathTo(dest[1], dest[2], dest[3], flags)
                elseif current[1] == dest[1] and current[3] == dest[3] then
                    mob:pathTo(home[1], home[2], home[3], flags)
                elseif current[1] == spawn.x and current[3] == spawn.z then
                    mob:pathTo(home[1], home[2], home[3], flags)
                end
            end
            key = key + 1
        end
    end
end

--------------------------------------------
--            Dynamis Mob Stats           --
--------------------------------------------

xi.dynamis.setMobStats = function(mob)
    if mob ~= nil then
        local job = mob:getMainJob()

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

        mob:setMobMod(xi.mobMod.HP_SCALE, 132)
        mob:setHP(mob:getMaxHP())
        mob:setMobType(xi.mobskills.mobType.NORMAL)
        mob:setMobLevel(math.random(78,80))
        mob:setTrueDetection(true)

        if     job == xi.job.WAR then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.id = xi.jsa.MIGHTY_STRIKES
            params.specials.skill.hpp = math.random(55,80)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.MNK then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.id = xi.jsa.HUNDRED_FISTS
            params.specials.skill.hpp = math.random(55,70)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.WHM then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.id = xi.jsa.BENEDICTION
            params.specials.skill.hpp = math.random(40,60)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.BLM then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.id = xi.jsa.MANAFONT
            params.specials.skill.hpp = math.random(55,80)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.RDM then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.id = xi.jsa.CHAINSPELL
            params.specials.skill.hpp = math.random(55,80)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.THF then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.id = xi.jsa.PERFECT_DODGE
            params.specials.skill.hpp = math.random(55,75)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.PLD then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.id = xi.jsa.INVINCIBLE
            params.specials.skill.hpp = math.random(55,75)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.DRK then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.id = xi.jsa.BLOOD_WEAPON
            params.specials.skill.hpp = math.random(55,75)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.BST then
        elseif job == xi.job.BRD then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.id = xi.jsa.SOUL_VOICE
            params.specials.skill.hpp = math.random(55,80)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.RNG then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.id = familyEES[mob:getFamily()]
            params.specials.skill.hpp = math.random(55,75)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.SAM then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.id = xi.jsa.MEIKYO_SHISUI
            params.specials.skill.hpp = math.random(55,80)
            xi.mix.jobSpecial.config(mob, params)
        elseif job == xi.job.NIN then
            local params = { }
            params.specials = { }
            params.specials.skill = { }
            params.specials.skill.id = xi.jsa.MIJIN_GAKURE
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
    mob:setMobType(xi.mobskills.mobType.NOTORIOUS)
    mob:setMobMod(xi.mobMod.HP_SCALE, 132)
    mob:setHP(mob:getMaxHP())
    mob:setMobLevel(math.random(80,82))
    mob:setMod(xi.mod.STR, -15)
    mob:setMod(xi.mod.VIT, -5)
    mob:setTrueDetection(true)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)

    if job == xi.job.NIN then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = xi.jsa.MIJIN_GAKURE
        params.specials.skill.hpp = math.random(15,25)
        xi.mix.jobSpecial.config(mob, params)
    end
end

xi.dynamis.setStatueStats = function(mob, mobIndex)
    local zoneID = mob:getZoneID()
    local eyes = xi.dynamis.mobList[zoneID][mobIndex].eyes
    mob:setRoamFlags(xi.roamFlag.EVENT)
    mob:setMobType(xi.mobskills.mobType.NOTORIOUS)
    mob:setMobLevel(math.random(82,84))
    mob:setMod(xi.mod.STR, -5)
    mob:setMod(xi.mod.VIT, -5)
    mob:setMod(xi.mod.DMGMAGIC, -50)
    mob:setMod(xi.mod.DMGPHYS, -50)
    mob:setTrueDetection(true)
    -- Disabling WHM job trait mods because their job is set to WHM in the DB.
    mob:setMod(xi.mod.MDEF, 0)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.MPHEAL, 0)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
    
    if mob:getFamily() >= 92 and mob:getFamily() <= 95 then -- If statue
        if eyes ~= nil then
            mob:setLocalVar("eyeColor", eyes) -- Set Eyes if need be
            if eyes >= 2 then -- If HP or MP restore statue
                mob:setUnkillable(true) -- Set Unkillable as we will use skills then kill.
            end
        else
            eyes = xi.dynamis.eye.RED
            mob:setLocalVar("eyeColor", eyes) -- Set Eyes if need be
        end
    end
end

xi.dynamis.setMegaBossStats = function(mob)
    mob:setMobType(xi.mobskills.mobType.NOTORIOUS)
    mob:setMobLevel(88)
    mob:setMod(xi.mod.STR, -10)
    mob:setTrueDetection(true)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
end

xi.dynamis.setPetStats = function(mob)
    mob:setMobLevel(78)
    mob:setMod(xi.mod.STR, -40)
    mob:setMod(xi.mod.INT, -30)
    mob:setMod(xi.mod.VIT, -20)
    mob:setMod(xi.mod.RATTP, -20)
    mob:setMod(xi.mod.ATTP, -20)
    mob:setMod(xi.mod.DEFP, -5)
    mob:setTrueDetection(true)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
end

xi.dynamis.setAnimatedWeaponStats = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.HP_HEAL_CHANCE, 90)
    mob:setMod(xi.mod.STUNRESTRAIT, 75)
    mob:setMod(xi.mod.PARALYZERESTRAIT, 100)
    mob:setMod(xi.mod.SLOWRESTRAIT, 100)
    mob:setMod(xi.mod.SILENCERESTRAIT, 100)
    mob:setMod(xi.mod.LULLABYRESTRAIT, 100)
    mob:setMod(xi.mod.SLEEPRESTRAIT, 100)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
end

xi.dynamis.setEyeStats = function(mob)
    mob:setMobType(xi.mobskills.mobType.NOTORIOUS)
    mob:setMobLevel(math.random(82,84))
    mob:setMod(xi.mod.DEF, 420)
    mob:addMod(xi.mod.MDEF, 150)
    mob:addMod(xi.mod.DMGMAGIC, -25)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)
end

xi.dynamis.teleport = function(mob, hideDuration)
    if mob:isDead() then
        return
    end

    mob:hideName(true)
    mob:untargetable(true)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:SetMobSkillAttack(false)
    mob:entityAnimationPacket("kesu")

    hideDuration = hideDuration or 5000

    if hideDuration < 1500 then
        hideDuration = 1500
    end

    mob:timer(hideDuration, function(mob)
    mob:hideName(false)
    mob:untargetable(false)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:SetMobSkillAttack(true)

        if mob:isDead() then
            return
        end

        mob:entityAnimationPacket("deru")
    end)
end

--------------------------------------------
--            Dynamis Mob Death           --
--------------------------------------------

xi.dynamis.mobOnDeath = function (mob, mobVar)
    local zone = mob:getZone()
    local zoneID = mob:getZoneID()
    local mobIndex = zone:getLocalVar(string.format("MobIndex_%s", mob:getID()))
    if mob:getLocalVar("dynamisMobOnDeathTriggered") == 1 then return -- Don't trigger more than once.
    else -- Stops execution of code below if the above is true.
        if mobVar ~= nil then zone:setLocalVar(string.format("%s", mobVar), 1) end -- Set Death Requirements Variable
        xi.dynamis.addTimeToDynamis(zone, mobIndex) -- Add Time
        mob:setLocalVar("dynamisMobOnDeathTriggered", 1) -- onDeath lua happens once per party member that killed the mob, but we want this to only run once per mob
    end
end

m:addOverride("xi.dynamis.megaBossOnDeath", function(mob, player, mobVar)
    local zoneID = mob:getZoneID()
    if mob:getLocalVar("GaveTimeExtension") ~= 1 then -- Ensure we don't give more than 1 time extension.
        xi.dynamis.mobOnDeath(mob,mobVar) -- Process time extension and wave spawning
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
            mob:untargetable(true)
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
            mob:untargetable(true)
            mob:SetAutoAttackEnabled(false)
            if mob:hasStatusEffect(xi.effect.STUN) then
                mob:delStatusEffectSilent(xi.effect.STUN)
            end
            mob:useMobAbility(1125) -- Use Recover MP
        end
    end
end

return m