-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: JiFhu Infiltrator
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
    [ID.mob.JIFHU_INFILTRATOR - 5] = ID.mob.JIFHU_INFILTRATOR, -- Vanguard_Purloiner
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
