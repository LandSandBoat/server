-----------------------------------
-- Area: Dynamis - Windurst
--  Mob: Xuu Bhoqa the Enigma
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special'),
    require('scripts/mixins/remove_doom')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Xuu_Bhoqas_Avatar')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
