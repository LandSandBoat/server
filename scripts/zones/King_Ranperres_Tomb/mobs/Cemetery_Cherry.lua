-----------------------------------
-- Area: King Ranperres Tomb
--   NM: Cemetery Cherry
-- !pos 33.000 0.500 -287.000 190
-----------------------------------
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local function spawnSaplings()
    for i = ID.mob.CHERRY_SAPLING_OFFSET, ID.mob.CHERRY_SAPLING_OFFSET + 12 do
        local mob = GetMobByID(i)
        if mob ~= nil and mob:getName() == 'Cherry_Sapling' and not mob:isSpawned() then
            SpawnMob(i)
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)

    local saplingsRespawn = math.random(1800, 3600) -- 30 to 60 minutes
    mob:timer(saplingsRespawn * 1000, function(mobArg)
        spawnSaplings()
    end)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("wasKilled", 0)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:setLocalVar("wasKilled", 1)
    player:addTitle(xi.title.MON_CHERRY)
end

entity.onMobDespawn = function(mob)
    local saplingsRespawn = 0
    if mob:getLocalVar("wasKilled") == 1 then
        saplingsRespawn = math.random(216000, 259200) -- 60 to 72 hours
    else
        saplingsRespawn = math.random(1800, 3600) -- 30 to 60 minutes
    end

    mob:timer(saplingsRespawn * 1000, function(mobArg)
        spawnSaplings()
    end)
end

return entity
