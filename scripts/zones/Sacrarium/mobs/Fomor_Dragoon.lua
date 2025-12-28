-----------------------------------
-- Area: Sacrarium
--  Mob: Fomor Dragoon
-----------------------------------
mixins = { require('scripts/mixins/fomor_hate') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Fomors_Wyvern')
end

entity.onMobSpawn = function(mob)
    -- Summon wyvern immediately on spawn
    mob:useMobAbility(xi.jsa.CALL_WYVERN)
end

return entity
