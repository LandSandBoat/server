-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Wyrmwix Snakespecs
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
    [ID.mob.WYRMWIX_SNAKESPECS + 9] = ID.mob.WYRMWIX_SNAKESPECS, -- Vanguard_Enchanter    21.160   0.000   -7.386
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
