-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Duke Berith
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
    [ID.mob.DUKE_BERITH - 1] = ID.mob.DUKE_BERITH, -- Kindred_Red_Mage
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
