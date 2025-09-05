-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Distilix Stickytoes
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

entity.spawnPoints =
{
    { x =  1.122, y =  2.500, z =  105.777 }
}

entity.phList =
{
    [ID.mob.DISTILIX_STICKYTOES - 3] = ID.mob.DISTILIX_STICKYTOES, -- Vanguard_Alchemist    -2.164   2.5     106.255
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
