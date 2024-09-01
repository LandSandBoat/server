-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Feeler Antlion
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 40) -- Don't know exact value
    mob:addMod(xi.mod.REGEN, 30)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 120)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('SAND_BLAST', 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
