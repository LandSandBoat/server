-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Marquis Orias
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
    [ID.mob.MARQUIS_ORIAS - 10] = ID.mob.MARQUIS_ORIAS, -- Kindred_Black_Mage
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
