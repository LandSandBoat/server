-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Lockbuster Zapdjipp
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
    [ID.mob.LOCKBUSTER_ZAPDJIPP - 2] = ID.mob.LOCKBUSTER_ZAPDJIPP, -- Vanguard_Pillager
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
