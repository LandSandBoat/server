-----------------------------------
-- Area: Boneyard Gully
--  Mob: Race Runner
--  ENM: Like the Wind
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -539, y = 0, z = -481 },
    { x = -556, y = 0, z = -478 },
    { x = -581, y = 0, z = -475 },
    { x = -579, y = -3, z = -460 },
    { x = -572, y = 2, z = -433 },
    { x = -545, y = 1, z = -440 },
    { x = -532, y = 0, z = -466 },
}

entity.onMobSpawn = function(mob)
    entity.onMobRoam(mob)
    mob:pathThrough(pathNodes, bit.bor(xi.path.flag.PATROL, xi.path.flag.REVERSE))
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
