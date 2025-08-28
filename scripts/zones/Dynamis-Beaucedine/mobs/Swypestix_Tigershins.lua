-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Swypestix Tigershins
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
    [ID.mob.SWYPESTIX_TIGERSHINS - 2] = ID.mob.SWYPESTIX_TIGERSHINS, -- Vanguard_Hitman
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
