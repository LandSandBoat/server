-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Mamool Ja Stabler
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Mamool_Jas_Raptor')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
