-----------------------------------
-- Area: Mamook
--  Mob: Mamool Ja Pikeman
-----------------------------------
mixins =
{
    require('scripts/mixins/weapon_break'),
    require('scripts/mixins/drg_wyvern'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Mamool_Jas_Wyvern')
end

return entity
