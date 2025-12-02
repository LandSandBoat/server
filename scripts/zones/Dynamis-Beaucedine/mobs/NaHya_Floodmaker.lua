-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: NaHya Floodmaker
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
    { x =  183.227, y =  0.338, z = -197.513 }
}

entity.phList =
{
    [ID.mob.NAHYA_FLOODMAKER - 5] = ID.mob.NAHYA_FLOODMAKER, -- Vanguard_Protector
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
