-----------------------------------
-- Area: Sacrarium
--  Mob: Teratotaur
-----------------------------------
mixins = { require('scripts/mixins/fomor_hate') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('fomorHateAdj', 4) -- treated as negative in fomor_hate mixin
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
