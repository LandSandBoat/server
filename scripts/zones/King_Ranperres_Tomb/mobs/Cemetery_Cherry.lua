-----------------------------------
-- Area: King Ranperres Tomb
--   NM: Cemetery Cherry
-- !pos 33.000 0.500 -287.000 190
-----------------------------------
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

function spawnSaplings()
    for i = ID.mob.CHERRY_SAPLING_OFFSET, ID.mob.CHERRY_SAPLING_OFFSET + 12 do
        local mob = GetMobByID(i)
        if mob ~= nil and mob:getName() == 'Cherry_Sapling' and not mob:isSpawned() then
            SpawnMob(i)
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)

    local saplingsRespawn = math.random(1800, 3600) -- 30 to 60 minutes
    mob:timer(saplingsRespawn * 1000, function(mob) spawnSaplings() end)
end

function onMobSpawn(mob)
    mob:setLocalVar("wasKilled", 0)
end

function onMobDeath(mob, player, isKiller)
    mob:setLocalVar("wasKilled", 1)
    player:addTitle(tpz.title.MON_CHERRY)
end

function onMobDespawn(mob)
    local saplingsRespawn = 0
    if mob:getLocalVar("wasKilled") == 1 then
        saplingsRespawn = math.random(216000, 259200) -- 60 to 72 hours
    else
        saplingsRespawn = math.random(1800, 3600) -- 30 to 60 minutes
    end
    mob:timer(saplingsRespawn * 1000, function(mob) spawnSaplings() end)
end

return entity
