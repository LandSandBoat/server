-----------------------------------
--      Tavnazia Era Module      --
-----------------------------------
require("scripts/globals/zone")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
-----------------------------------

xi = xi or {}
xi.dynamis = xi.dynamis or {}

local wormPositions =
{
    { -0.4922, -22.75, -26.778, 193 },
    { -21.282, -21.991, -21.588, 226 },
    { -20.901, -22, 21.3637, 34 },
    { 0.183, -22.75, 24.414, 62 },
    { 30.721, -22, -2.156, 142 },
}

local antlionPositions =
{
    { 19.105, -36, 18.66, 100 },
    { 19.72, -35.8, -18.83, 164 },
    { -19.13, -35.94, -19.75, 225 },
    { -21.65, -36, 18.61, 25 },
}

local firstEyes  = { "eyeOneKilled", "eyeTwoKilled" }
local secondEyes = { "eyeThreeKilled", "eyeFourKilled" }

xi.dynamis.onSpawnNightmareWorm = function(mob)
    xi.dynamis.setNMStats(mob)
    mob:setRoamFlags(xi.roamFlag.WORM)
    -- This is sneaky.  All of our code checks animation sub 0 or 1 for worms.
    -- 4 and 5 have the same functionality, but we want this worm to aggro, so we use 5
    mob:setAnimationSub(5)
    mob:hideName(true)
    mob:setUntargetable(true)
    local newPosition = math.random(1, #wormPositions)
    mob:setPos(wormPositions[newPosition][1], wormPositions[newPosition][2], wormPositions[newPosition][3], wormPositions[newPosition][4])
end

xi.dynamis.onSpawnNightmareAntlion = function(mob)
    xi.dynamis.setNMStats(mob)
    mob:setMobMod(xi.mobMod.ROAM_TURNS, 0)
    mob:setMobMod(xi.mobMod.ROAM_RATE, 0)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
    local newPosition = math.random(1, #antlionPositions)
    mob:setPos(antlionPositions[newPosition][1], antlionPositions[newPosition][2], antlionPositions[newPosition][3], antlionPositions[newPosition][4])
end

xi.dynamis.onMobEngagedNightmareWorm = function(mob, target)
    mob:setAnimationSub(0)
    mob:hideName(false)
    mob:setUntargetable(false)
end

xi.dynamis.tavQMSpawnCheck = function(mob, zone, zoneID)
    local timeNPCOne = GetNPCByID(xi.dynamis.dynaInfoEra[zoneID].timeExtensions[1])
    local timeNPCTwo = GetNPCByID(xi.dynamis.dynaInfoEra[zoneID].timeExtensions[2])
    local req = 0
    local reqT = 0

    for _, eye in pairs(firstEyes) do
        if zone:getLocalVar(eye) == 1 then
            req = req + 1
        end
    end

    if req == 1 and timeNPCOne:getStatus() ~= xi.status.NORMAL then
        local chance = math.random(1, 2)
        if chance == 2 then
            timeNPCOne:setStatus(xi.status.NORMAL) -- Make visible
        end
    elseif req == 2 and timeNPCOne:getStatus() ~= xi.status.NORMAL then
        timeNPCOne:setStatus(xi.status.NORMAL) -- Make visible
    end

    for _, eye in pairs(secondEyes) do
        if zone:getLocalVar(eye) == 1 then
            reqT = reqT + 1
        end
    end

    if reqT == 1 and timeNPCTwo:getStatus() ~= xi.status.NORMAL then
        local chance = math.random(1, 2)
        if chance == 2 then
            timeNPCTwo:setStatus(xi.status.NORMAL) -- Make visible
        end
    elseif reqT == 2 and timeNPCTwo:getStatus() ~= xi.status.NORMAL then
        timeNPCTwo:setStatus(xi.status.NORMAL) -- Make visible
    end
end

xi.dynamis.antlionDeath = function(mob)
    local zone = mob:getZone()
    local worm = zone:getLocalVar("wormDeath")
    local mobIndex = zone:getLocalVar(string.format("MobIndex_%s", mob:getID()))

    zone:setLocalVar("antlionDeath", 1)

    if worm == 1 then
        for _, playerEntity in pairs(zone:getPlayers()) do
            if  playerEntity:hasStatusEffect(xi.effect.SJ_RESTRICTION) then -- Does player have SJ restriction?
                playerEntity:delStatusEffect(xi.effect.SJ_RESTRICTION) -- Remove SJ restriction
            end
        end

        zone:setLocalVar("SJUnlock", 1)
    end

    xi.dynamis.addTimeToDynamis(zone, mobIndex) -- Add Time
end

xi.dynamis.wormDeath = function(mob)
    local zone = mob:getZone()
    local antlion = zone:getLocalVar("antlionDeath")

    zone:setLocalVar("wormDeath", 1)

    if antlion == 1 then
        for _, playerEntity in pairs(zone:getPlayers()) do
            if  playerEntity:hasStatusEffect(xi.effect.SJ_RESTRICTION) then -- Does player have SJ restriction?
                playerEntity:delStatusEffect(xi.effect.SJ_RESTRICTION) -- Remove SJ restriction
            end
        end

        zone:setLocalVar("SJUnlock", 1)
    end
end

xi.dynamis.onSpawnUmbralDiabolos = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMobType(xi.mobskills.mobType.BATTLEFIELD)
    mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0, true)
end

xi.dynamis.onMobEngagedUmbralDiabolos = function(mob, target)
    local zoneID = mob:getZoneID()
    local zone = mob:getZone()

    if zone:getLocalVar("Starlight") == 0 then
        zone:setLocalVar("Starlight", 1)
        for _, member in pairs(zone:getPlayers()) do
            member:changeMusic(0, 239) -- 0 Background Music (Starlight Celebration Music)
            member:changeMusic(1, 239) -- 1 Background Music (Starlight Celebration Music)
        end
    end

    local remainingDiabolos = {}
    if zone:getLocalVar("DiabolosClub") == 0 then
        table.insert(remainingDiabolos, 110)
    end

    if zone:getLocalVar("DiabolosHeart") == 0 then
        table.insert(remainingDiabolos, 111)
    end

    if zone:getLocalVar("DiabolosSpade") == 0 then
        table.insert(remainingDiabolos, 112)
    end

    if zone:getLocalVar("DiabolosDiamond") == 0 then
        table.insert(remainingDiabolos, 113)
    end

    xi.dynamis.nmDynamicSpawn(remainingDiabolos[math.random(#remainingDiabolos)], nil, false, zoneID)
    mob:setHP(0)
end

xi.dynamis.onSpawnDiabolosClub = function(mob)
    local zone = mob:getZone()
    zone:setLocalVar("DiabolosClub", mob:getID())
    xi.dynamis.setNMStats(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 5)
end

xi.dynamis.onMobEngagedDiabolosClub = function(mob, target)
    local zoneID = mob:getZoneID()
    xi.dynamis.nmDynamicSpawn(252, 110, true, zoneID, target, mob)
end

xi.dynamis.onSpawnDiabolosHeart = function(mob)
    local zone = mob:getZone()
    zone:setLocalVar("DiabolosHeart", mob:getID())
    xi.dynamis.setNMStats(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 5)
end

xi.dynamis.onSpawnDiabolosSpade = function(mob)
    local zone = mob:getZone()
    zone:setLocalVar("DiabolosSpade", mob:getID())
    xi.dynamis.setNMStats(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 5)
end

xi.dynamis.onSpawnDiabolosDiamond = function(mob)
    local zone = mob:getZone()
    zone:setLocalVar("DiabolosDiamond", mob:getID())
    xi.dynamis.setNMStats(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 5)
end

-- ToDo
-- Umbrals are suposed to be NPCs
-- Despawn all remaining Umbrals on Diabolos boss engage?
-- Give title when the last diabolos dies
-- Spawn ??? when the last diabolos dies (which gives different title)
-- When does music change? when diabolos spawns?

xi.dynamis.mobOnDeathDiabolosClub = function(mob, player, optParams)
end

xi.dynamis.mobOnDeathDiabolosHeart = function(mob, player, optParams)
end

xi.dynamis.mobOnDeathDiabolosSpade = function(mob, player, optParams)
end

xi.dynamis.mobOnDeathDiabolosDiamond = function(mob, player, optParams)
end
