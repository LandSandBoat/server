-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Ree Nata the Melomanic
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
    [ID.mob.REE_NATA_THE_MELOMANIC - 4] = ID.mob.REE_NATA_THE_MELOMANIC, -- Vanguard_Chanter
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
