-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Prince Seere
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.PRINCE_SEERE - 1] = ID.mob.PRINCE_SEERE, -- Kindred_White_Mage
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
