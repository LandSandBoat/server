-----------------------------------
-- Area: Rolanberry Fields
--   NM: Silk Caterpillar
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  340.000, y =  0.380, z =  179.000 },
    { x =  344.537, y = -0.297, z =  151.739 },
    { x =  324.745, y =  0.191, z =  174.566 },
    { x =  305.389, y =  1.418, z =  193.677 },
    { x =  326.271, y =  1.934, z =  214.137 },
    { x =  348.977, y =  1.111, z =  210.698 },
    { x =  380.297, y = -0.248, z =  167.144 }
}

entity.spawnPoints =
{
    { x = 340.000, y =  0.380, z = 179.000 },
    { x = 344.537, y = -0.297, z = 151.739 },
    { x = 324.745, y =  0.191, z = 174.566 },
    { x = 305.389, y =  1.418, z = 193.677 },
    { x = 326.271, y =  1.934, z = 214.137 },
    { x = 348.977, y =  1.111, z = 210.698 },
    { x = 380.297, y = -0.248, z = 167.144 },
}

entity.onMobInitialize = function(mob)
    -- Despawns 3.5 minutes after spawning, approximately when the Jeuno-Bastok airship departs Jeuno to fly back over towards Bastok.
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 210)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
