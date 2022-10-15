-----------------------------------
-- Area: Dangruf Wadi (191)
--  Mob: Geyser Lizard
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    DespawnMob(mob:getID(), 600)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 225)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar("pop", os.time() + (math.random(45, 75) * 60))
end

return entity
