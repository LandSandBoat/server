-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Ruffbix Jumbolobes
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
    [ID.mob.RUFFBIX_JUMBOLOBES - 2] = ID.mob.RUFFBIX_JUMBOLOBES, -- Vanguard_Armorer
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
