-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Scruffix Shaggychest
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_JEUNO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.SCRUFFIX_SHAGGYCHEST - 4] = ID.mob.SCRUFFIX_SHAGGYCHEST, -- Vanguard_Armorer      -0.428   2.599   117.675
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
