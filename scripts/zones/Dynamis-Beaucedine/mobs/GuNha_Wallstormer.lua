-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: GuNha Wallstormer
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
    [ID.mob.GUNHA_WALLSTORMER - 6] = ID.mob.GUNHA_WALLSTORMER, -- Vanguard_Vindicator
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
