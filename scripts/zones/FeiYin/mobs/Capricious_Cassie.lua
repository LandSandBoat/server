-----------------------------------
-- Area: Fei'Yin
--   NM: Capricious Cassie
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -69.000, y =  0.075, z =  189.000 },
    { x = -75.552, y =  0.576, z =  177.090 },
    { x = -71.940, y =  0.576, z =  183.768 },
    { x = -64.506, y =  0.576, z =  170.202 },
    { x = -68.358, y =  0.224, z =  209.099 },
    { x = -71.416, y =  0.258, z =  208.709 },
    { x = -52.096, y =  0.576, z =  157.417 },
    { x = -34.932, y =  0.507, z =  166.115 },
    { x = -37.558, y =  0.576, z =  197.011 },
    { x = -48.685, y =  0.576, z =  190.334 },
    { x = -71.957, y =  0.576, z =  166.480 },
    { x = -60.198, y =  0.221, z =  209.135 },
    { x = -51.053, y =  0.576, z =  160.541 },
    { x = -31.618, y =  0.576, z =  176.952 },
    { x = -54.569, y =  0.576, z =  164.872 },
    { x = -74.544, y =  0.090, z =  210.626 },
    { x = -78.054, y =  0.576, z =  181.669 },
    { x = -53.548, y =  0.576, z =  174.446 },
    { x = -60.303, y =  0.557, z =  204.273 },
    { x = -52.706, y =  0.420, z =  206.448 },
    { x = -59.936, y =  0.260, z =  208.696 },
    { x = -79.958, y =  0.478, z =  205.541 },
    { x = -81.337, y =  0.576, z =  182.845 },
    { x = -67.607, y =  0.036, z =  166.814 },
    { x = -64.650, y =  0.470, z =  154.344 },
    { x = -71.973, y =  0.576, z =  165.941 },
    { x = -53.871, y =  0.576, z =  164.852 },
    { x = -70.315, y =  0.576, z =  200.885 },
    { x = -84.039, y =  0.572, z =  182.904 },
    { x = -39.277, y =  0.576, z =  181.679 },
    { x = -70.833, y =  0.576, z =  165.050 },
    { x = -70.728, y =  0.576, z =  172.760 },
    { x = -87.518, y =  0.353, z =  195.808 },
    { x = -46.088, y =  0.576, z =  190.297 },
    { x = -60.196, y =  0.576, z =  171.352 },
    { x = -48.242, y =  0.275, z =  208.520 },
    { x = -89.685, y =  0.173, z =  184.675 },
    { x = -82.105, y =  0.576, z =  182.042 },
    { x = -51.455, y =  0.576, z =  182.715 },
    { x = -67.537, y =  0.576, z =  198.618 },
    { x = -43.417, y =  0.576, z =  193.960 },
    { x = -59.000, y = -0.006, z =  148.284 },
    { x = -45.890, y =  0.576, z =  177.262 },
    { x = -70.121, y =  0.576, z =  203.582 },
    { x = -74.442, y =  0.576, z =  171.153 },
    { x = -85.232, y =  0.497, z =  170.570 },
    { x = -74.157, y =  0.576, z =  158.338 },
    { x = -75.971, y =  0.576, z =  190.393 },
    { x = -58.071, y =  0.576, z =  174.487 },
    { x = -80.852, y =  0.576, z =  195.573 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(75600, 86400))
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobRoam = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobFight = function(mob, target)
    local targetPos = target:getPos()
    local spawnPos = mob:getSpawnPos()
    local arenaBoundaries =
    {
        { { -87, 142 }, { -93, 146 } }, -- G-7 SW hallway
        { { -98, 208 }, { -94, 213 } }, -- G-6 NW hallway
        { { -13, 254 }, {  -8, 257 } }, -- H-5 N hallway
        { {  18, 192 }, {  15, 187 } }, -- H-6 E hallway
    }
    local drawInTable =
    {
        conditions =
        {
            targetPos.z < 130, -- S hallway
            not utils.sameSideOfLine(arenaBoundaries[1], targetPos, spawnPos),
            not utils.sameSideOfLine(arenaBoundaries[2], targetPos, spawnPos),
            targetPos.z > 250 and not utils.sameSideOfLine(arenaBoundaries[3], targetPos, spawnPos),
            not utils.sameSideOfLine(arenaBoundaries[4], targetPos, spawnPos),
        },
        position = mob:getPos(),
        wait = 3,
    }
    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            utils.drawIn(target, drawInTable)
            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.CASSIENOVA)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21-24 hours
end

return entity
