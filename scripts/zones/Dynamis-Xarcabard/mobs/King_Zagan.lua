-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: King Zagan
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  33.587, y = -23.791, z = -108.695 }
}

entity.phList =
{
    [ID.mob.KING_ZAGAN - 12] = ID.mob.KING_ZAGAN, -- Kindred_Dragoon
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Zagans_Wyvern')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
