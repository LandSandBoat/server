-----------------------------------
-- Area: Fei'Yin
--   NM: Goliath
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -165.800, y = -0.112, z =  148.027 }
}

entity.phList =
{
    [ID.mob.GOLIATH + 7] = ID.mob.GOLIATH,
}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.GOLIATH_KILLER)
end

return entity
