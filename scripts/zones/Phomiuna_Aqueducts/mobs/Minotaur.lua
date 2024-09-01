-----------------------------------
-- Area: Phomiuna Aqueducts
--  Mob: Minotaur
-----------------------------------
mixins = { require('scripts/mixins/fomor_hate') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 15)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('fomorHateAdj', 2)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
