-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Shamblix Rottenheart
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BUBURIMU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.SHAMBLIX_ROTTENHEART - 4] = ID.mob.SHAMBLIX_ROTTENHEART, -- Vanguard_Tinkerer
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
