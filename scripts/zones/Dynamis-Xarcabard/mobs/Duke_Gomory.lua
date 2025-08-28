-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Duke Gomory
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
    [ID.mob.DUKE_GOMORY - 1] = ID.mob.DUKE_GOMORY, -- Kindred_Monk
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
