-----------------------------------
-- Area: Arrapago Reef
--  Mob: Reserve Draugar
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Draugars_Wyvern')
end

return entity
