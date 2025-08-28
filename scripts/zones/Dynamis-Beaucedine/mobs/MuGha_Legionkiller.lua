-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: MuGha Legionkiller
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
    [ID.mob.MUGHA_LEGIONKILLER - 2] = ID.mob.MUGHA_LEGIONKILLER, -- Vanguard_Defender
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
