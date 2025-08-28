-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Maa Zaua the Wyrmkeeper
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
    [ID.mob.MAA_ZAUA_THE_WYRMKEEPER - 2] = ID.mob.MAA_ZAUA_THE_WYRMKEEPER, -- Vanguard_Partisan
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
