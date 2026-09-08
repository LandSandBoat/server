-----------------------------------
-- Area: Mamook
--  Mob: Mamool Ja Strapper
-----------------------------------
mixins =
{
    require('scripts/mixins/weapon_break'),
    require('scripts/mixins/pet_resummon'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Mamool_Jas_Lizard')
end

return entity
