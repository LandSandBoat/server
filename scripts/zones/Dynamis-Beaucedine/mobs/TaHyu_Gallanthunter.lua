-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: TaHyu Gallanthunter
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

entity.spawnPoints =
{
    { x =  401.534, y =  0.413, z = -189.173 }
}

entity.phList =
{
    [ID.mob.TAHYU_GALLANTHUNTER - 6] = ID.mob.TAHYU_GALLANTHUNTER, -- Vanguard_Vigilante
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
