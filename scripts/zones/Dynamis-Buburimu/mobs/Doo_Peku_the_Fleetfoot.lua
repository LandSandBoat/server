-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Doo Peku the Fleetfoot
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special'),
    require('scripts/mixins/remove_doom')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BUBURIMU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.DOO_PEKU_THE_FLEETFOOT - 3] = ID.mob.DOO_PEKU_THE_FLEETFOOT, -- Vanguard_Assassin
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
