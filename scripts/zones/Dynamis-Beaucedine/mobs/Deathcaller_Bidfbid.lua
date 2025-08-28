-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Deathcaller Bidfbid
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
    [ID.mob.DEATHCALLER_BIDFBID - 2] = ID.mob.DEATHCALLER_BIDFBID, -- Vanguard_Dollmaster
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
