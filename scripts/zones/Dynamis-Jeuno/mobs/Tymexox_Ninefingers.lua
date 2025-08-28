-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Tymexox Ninefingers
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
    [ID.mob.TYMEXOX_NINEFINGERS - 4] = ID.mob.TYMEXOX_NINEFINGERS, -- Vanguard_Tinkerer     2.257    2.489   117.621
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
