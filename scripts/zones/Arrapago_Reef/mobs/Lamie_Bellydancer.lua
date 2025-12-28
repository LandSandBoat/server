-----------------------------------
-- Area: Arrapago Reef
--  Mob: Lamie Bellydancer
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Lamias_Elemental')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
