-----------------------------------
-- Area: Apollyon NW
--  NPC: Armoury Crate (Recovery)
-----------------------------------
require("scripts/globals/npc_util")
-----------------------------------

local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_REST, 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.NO_DESPAWN, 1)
    mob:setStatus(xi.status.NORMAL)
end

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
