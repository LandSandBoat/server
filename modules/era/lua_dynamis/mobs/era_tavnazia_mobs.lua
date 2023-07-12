-----------------------------------
--      Tavnazia Era Module      --
-----------------------------------
require("scripts/globals/zone")
require("scripts/globals/spell_data")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/status")
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
    local newPosition = math.random(1, #wormPositions)
    mob:setPos(wormPositions[newPosition][1],wormPositions[newPosition][2],wormPositions[newPosition][3],wormPositions[newPosition][4])
end

xi.dynamis.onSpawnNightmareAntlion = function(mob)
    mob:setMobMod(xi.mobMod.ROAM_TURNS, 0)
    mob:setMobMod(xi.mobMod.ROAM_RATE, 0)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
    local newPosition = math.random(1, #antlionPositions)
    mob:setPos(antlionPositions[newPosition][1],antlionPositions[newPosition][2],antlionPositions[newPosition][3],antlionPositions[newPosition][4])
end

xi.dynamis.tavFirstQMSpawnCheck = function(mob, zone, zoneID)
    local timeNPC = GetNPCByID(xi.dynamis.dynaInfoEra[zoneID].timeExtensionNPCOne)
    local req = 0
    for _, eye in pairs(firstEyes) do
        if zone:getLocalVar(eye) == 1 then
            req = req + 1
        end
    end

    if req == 1 and timeNPC:getStatus() ~= xi.status.NORMAL then
        local chance = math.random(1, 2)
        if chance == 2 then
            timeNPC:setStatus(xi.status.NORMAL) -- Make visible
        end
    elseif req == 2 and timeNPC:getStatus() ~= xi.status.NORMAL then
        timeNPC:setStatus(xi.status.NORMAL) -- Make visible
    end
end

xi.dynamis.tavFirstQMSpawnCheck = function(mob, zone, zoneID)
    local timeNPC = GetNPCByID(xi.dynamis.dynaInfoEra[zoneID].timeExtensionNPCTwo)
    local req = 0
    for _, eye in pairs(secondEyes) do
        if zone:getLocalVar(eye) == 1 then
            req = req + 1
        end
    end

    if req == 1 and timeNPC:getStatus() ~= xi.status.NORMAL then
        local chance = math.random(1, 2)
        if chance == 2 then
            timeNPC:setStatus(xi.status.NORMAL) -- Make visible
        end
    elseif req == 2 and timeNPC:getStatus() ~= xi.status.NORMAL then
        timeNPC:setStatus(xi.status.NORMAL) -- Make visible
    end
end

xi.dynamis.antlionDeath = function(mob)
    local zone = mob:getZone()
    local worm = zone:getLocalVar("wormDeath")

    zone:setLocalVar("antlionDeath", 1)

    if worm == 1 then
        for _, playerEntity in pairs(zone:getPlayers()) do
            if  playerEntity:hasStatusEffect(xi.effect.SJ_RESTRICTION) then -- Does player have SJ restriction?
                playerEntity:delStatusEffect(xi.effect.SJ_RESTRICTION) -- Remove SJ restriction
            end
        end
        zone:setLocalVar("SJUnlock", 1)
    end
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
