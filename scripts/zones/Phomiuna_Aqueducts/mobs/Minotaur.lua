-----------------------------------
-- Area: Phomiuna Aqueducts
--  Mob: Minotaur
-----------------------------------
mixins = { require('scripts/mixins/fomor_hate') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('fomorHateAdj', -2)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
