-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Whistrix Toadthroat
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
    [ID.mob.WHISTRIX_TOADTHROAT - 1] = ID.mob.WHISTRIX_TOADTHROAT, -- Vanguard_Maestro
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
