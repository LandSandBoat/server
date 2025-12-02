-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Mortilox Wartpaws
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
    { x =  13.664, y =  1.615, z =  66.393 }
}

entity.phList =
{
    [ID.mob.MORTILOX_WARTPAWS + 5] = ID.mob.MORTILOX_WARTPAWS, -- Vanguard_Necromancer  -9.120   1.400   67.003
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Avatar')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
