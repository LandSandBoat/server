-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Taruroaster Biggsjig
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BEAUCEDINE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.TARUROASTER_BIGGSJIG - 1] = ID.mob.TARUROASTER_BIGGSJIG, -- Vanguard_Mesmerizer
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
