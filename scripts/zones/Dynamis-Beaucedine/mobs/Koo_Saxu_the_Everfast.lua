-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Koo Saxu the Everfast
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special'),
    require('scripts/mixins/remove_doom')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BEAUCEDINE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.KOO_SAXU_THE_EVERFAST - 1] = ID.mob.KOO_SAXU_THE_EVERFAST, -- Vanguard_Priest
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
