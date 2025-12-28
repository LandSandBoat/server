-----------------------------------
-- Area: Dynamis - Tavnazia
--  Mob: Kindred Dragoon
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
    xi.pet.setMobPet(mob, 1, 'Kindreds_Wyvern')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
