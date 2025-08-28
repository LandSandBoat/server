-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: JiKhu Towercleaver
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
    [ID.mob.JIKHU_TOWERCLEAVER - 1] = ID.mob.JIKHU_TOWERCLEAVER, -- Vanguard_Hatamoto
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
