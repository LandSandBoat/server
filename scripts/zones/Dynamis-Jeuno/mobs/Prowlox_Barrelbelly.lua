-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Prowlox Barrelbelly
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_JEUNO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.PROWLOX_BARRELBELLY - 1] = ID.mob.PROWLOX_BARRELBELLY, -- Vanguard_Ambusher     7.509    2.500   118.109
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
