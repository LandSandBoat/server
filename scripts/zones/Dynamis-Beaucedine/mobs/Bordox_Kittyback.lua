-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Bordox Kittyback
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
    [ID.mob.BORDOX_KITTYBACK - 2] = ID.mob.BORDOX_KITTYBACK, -- Vanguard_Welldigger
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
