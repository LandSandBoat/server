-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Gosspix Blabberlips
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
    [ID.mob.GOSSPIX_BLABBERLIPS - 8] = ID.mob.GOSSPIX_BLABBERLIPS, -- Vanguard_Enchanter
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
