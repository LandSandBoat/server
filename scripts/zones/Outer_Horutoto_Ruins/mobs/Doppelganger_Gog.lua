-----------------------------------
-- Area: Outer Horutoto Ruins (194)
--   NM: Doppelganger Gog
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  310.000, y =  0.000, z =  710.000 },
    { x =  508.000, y =  0.000, z =  709.000 },
    { x =  530.000, y =  0.000, z =  775.000 }
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
