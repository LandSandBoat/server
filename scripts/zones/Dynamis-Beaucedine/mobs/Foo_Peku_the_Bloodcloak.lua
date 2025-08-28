-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Foo Peku the Bloodcloak
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
    [ID.mob.FOO_PEKU_THE_BLOODCLOAK - 2] = ID.mob.FOO_PEKU_THE_BLOODCLOAK, -- Vanguard_Skirmisher
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
