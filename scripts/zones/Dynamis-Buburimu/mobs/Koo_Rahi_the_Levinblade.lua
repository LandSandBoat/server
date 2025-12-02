-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Koo Rahi the Levinblade
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

entity.spawnPoints =
{
    { x =  107.140, y = -8.302, z = -14.404 }
}

entity.phList =
{
    [ID.mob.KOO_RAHI_THE_LEVINBLADE - 4] = ID.mob.KOO_RAHI_THE_LEVINBLADE, -- Vanguard_Persecutor
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
