-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Spellspear Djokvukk
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Djokvukks_Wyvern')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
