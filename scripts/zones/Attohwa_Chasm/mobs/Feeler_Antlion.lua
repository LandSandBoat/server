-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Feeler Antlion
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 40) -- Don't know exact value
    mob:addMod(xi.mod.REGEN, 30)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("SAND_BLAST", 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
