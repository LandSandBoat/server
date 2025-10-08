-----------------------------------
-- Area: Mamook
--  Mob: Mamool Ja Pikeman
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Mamool_Jas_Wyvern')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
