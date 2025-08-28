-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Cobraclaw Buchzvotch
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
    [ID.mob.COBRACLAW_BUCHZVOTCH - 1] = ID.mob.COBRACLAW_BUCHZVOTCH, -- Vanguard_Grappler
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
