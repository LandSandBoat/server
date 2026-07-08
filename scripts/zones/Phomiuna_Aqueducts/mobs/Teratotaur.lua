-----------------------------------
-- Area: Phomiuna_Aqueducts
--  Mob: Teratotaur
-----------------------------------
mixins = { require('scripts/mixins/fomor_hate') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('fomorHateAdj', 1)
end

return entity
