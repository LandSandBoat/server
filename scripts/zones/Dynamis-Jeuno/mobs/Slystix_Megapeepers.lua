-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Slystix Megapeepers
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
    [ID.mob.SLYSTIX_MEGAPEEPERS - 1] = ID.mob.SLYSTIX_MEGAPEEPERS, -- Vanguard_Hitman       -8.440   2.500   118.349
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
