-----------------------------------
-- Area:  Buburimu Peninsula (118)
-- NM:    Backoo
-- Notes: Spawns only from hours 06 to 16.
-----------------------------------
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLOW)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 263)
end

entity.onMobDespawn = function(mob)
    if RESPAWN_SAVE_TIME then
        GetMobByID(ID.mob.BACKOO):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        GetMobByID(ID.mob.BACKOO):setRespawnTime(math.random(3600, 5400), true) -- 60-90 minute respawn, depending on if it's daytime
    end
end

return entity
