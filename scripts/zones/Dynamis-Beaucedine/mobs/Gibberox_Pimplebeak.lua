-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Gibberox Pimplebeak
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
    [ID.mob.GIBBEROX_PIMPLEBEAK - 1] = ID.mob.GIBBEROX_PIMPLEBEAK, -- Vanguard_Enchanter
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
