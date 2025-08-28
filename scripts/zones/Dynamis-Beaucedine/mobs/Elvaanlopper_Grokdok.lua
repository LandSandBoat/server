-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Elvaanlopper Grokdok
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
    [ID.mob.ELVAANLOPPER_GROKDOK - 1] = ID.mob.ELVAANLOPPER_GROKDOK, -- Vanguard_Gutslasher
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
