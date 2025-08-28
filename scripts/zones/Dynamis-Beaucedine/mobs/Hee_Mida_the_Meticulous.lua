-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Hee Mida the Meticulous
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
    [ID.mob.HEE_MIDA_THE_METICULOUS - 2] = ID.mob.HEE_MIDA_THE_METICULOUS, -- Vanguard_Salvager
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
