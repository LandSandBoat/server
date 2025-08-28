-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: GiBhe Fleshfeaster
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
    [ID.mob.GIBHE_FLESHFEASTER - 10] = ID.mob.GIBHE_FLESHFEASTER, -- Vanguard_Constable
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
