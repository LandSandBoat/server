-----------------------------------
-- Area: South Gustaberg
--  Mob: Astral Box
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
