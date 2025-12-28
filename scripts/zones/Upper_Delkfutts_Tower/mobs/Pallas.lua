-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Pallas
-----------------------------------
mixins = { require('scripts/mixins/families/gigas_bst_nm') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Gigass_Bat')
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 120)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
