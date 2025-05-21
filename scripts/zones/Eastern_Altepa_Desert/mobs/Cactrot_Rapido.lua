-----------------------------------
-- Area: Eastern Altepa Desert
-- NM  : Cactrot Rapido
-----------------------------------
---@type TMobEntity
local entity = {}

local pathNodes =
{
    { x = -45, y = 0, z = -204 },
    { x = -99, y = 0, z = -179 },
    { x = -100, y = -1, z = -179 },
    { x = -103, y = -2, z = -178 },
    { x = -105, y = -3, z = -178 },
    { x = -110, y = -4, z = -177 },
    { x = -111, y = -5, z = -177 },
    { x = -116, y = -4, z = -176 },
    { x = -120, y = -3, z = -173 },
    { x = -122, y = -2, z = -171 },
    { x = -127, y = 0, z = -166 },
    { x = -136, y = 3, z = -153 },
    { x = -138, y = 3, z = -149 },
    { x = -140, y = 4, z = -142 },
    { x = -141, y = 4, z = -140 },
    { x = -141, y = 5, z = -138 },
    { x = -143, y = 5, z = -117 },
    { x = -144, y = 3, z = -110 },
    { x = -144, y = 2, z = -109 },
    { x = -144, y = 1, z = -107 },
    { x = -144, y = 0, z = -106 },
    { x = -144, y = 0, z = -105 },
    { x = -143, y = -1, z = -103 },
    { x = -142, y = -2, z = -102 },
    { x = -141, y = -1, z = -99 },
    { x = -140, y = 0, z = -96 },
    { x = -136, y = 1, z = -89 },
    { x = -133, y = 2, z = -83 },
    { x = -129, y = 1, z = -75 },
    { x = -126, y = 0, z = -69 },
    { x = -109, y = 0, z = -33 },
    { x = -104, y = -2, z = -24 },
    { x = -101, y = -3, z = -18 },
    { x = -97, y = -5, z = -11 },
    { x = -94, y = -7, z = -6 },
    { x = -87, y = -8, z =  8 },
    { x = -82, y = -10, z = 17 },
    { x = -78, y = -12, z = 24 },
    { x = -74, y = -13, z = 25 },
    { x = -69, y = -12, z = 25 },
    { x = -50, y = -13, z = 23 },
    { x = -44, y = -12, z = 22 },
    { x = -23, y = -12, z = 21 },
    { x = -18, y = -11, z = 20 },
    { x = -15, y = -11, z = 20 },
    { x = -10, y = -11, z = 20 },
    { x = -5, y = -11, z = 20 },
    { x = -2, y = -11, z = 20 },
    { x = 1, y =  -11, z = 20 },
    { x = 8, y =  -12, z = 19 },
    { x = 12, y = -13, z = 18 },
    { x = 16, y = -15, z = 17 },
    { x = 20, y = -16, z = 16 },
    { x = 23, y = -17, z = 16 },
    { x = 25, y = -16, z = 15 },
    { x = 27, y = -14, z = 15 },
    { x = 29, y = -13, z = 15 },
    { x = 32, y = -11, z = 14 },
    { x = 35, y = -10, z = 13 },
    { x = 38, y = -9, z =  12 },
    { x = 45, y = -8, z =  10 },
    { x = 59, y = -7, z =  5 },
    { x = 92, y = -7, z = -9 },
    { x = 95, y = -8, z = -12 },
    { x = 102, y = -8, z = -16 },
    { x = 105, y = -9, z = -19 },
    { x = 106, y = -9, z = -20 },
    { x = 107, y = -10, z = -21 },
    { x = 110, y = -11, z = -23 },
    { x = 112, y = -11, z = -25 },
    { x = 116, y = -10, z = -28 },
    { x = 116, y = -9, z = -29 },
    { x = 123, y = -8, z = -39 },
    { x = 124, y = -7, z = -41 },
    { x = 130, y = -7, z = -61 },
    { x = 129, y = -8, z = -66 },
    { x = 120, y = -8, z = -80 },
    { x = 119, y = -8, z = -81 },
    { x = 114, y = -7, z = -83 },
    { x = 100, y = -7, z = -87 },
    { x = 78, y = -9, z = -92 },
    { x = 74, y = -9, z = -96 },
    { x = 72, y = -10, z = -100 },
    { x = 65, y = -12, z = -110 },
    { x = 57, y = -12, z = -123 },
    { x = 54, y = -11, z = -129 },
    { x = 51, y = -12, z = -133 },
    { x = 47, y = -13, z = -138 },
    { x = 45, y = -14, z = -140 },
    { x = 45, y = -13, z = -142 },
    { x = 43, y = -12, z = -144 },
    { x = 42, y = -11, z = -146 },
    { x = 36, y = -8, z = -154 },
    { x = 33, y = -7, z = -159 },
    { x = 28, y = -7, z = -167 },
    { x = 22, y = -4, z = -177 },
    { x = 20, y = -3, z = -180 },
    { x = 19, y = -3, z = -182 },
    { x = 14, y = -2, z = -183 },
    { x = 13, y = -1, z = -184 },
    { x = -5, y = -1, z = -188 },
    { x = -10, y = 0, z = -189 },
    { x = -21, y = 0, z = -194 },
    { x = -29, y = 0, z = -198 },
    { x = -40, y = 0, z = -203 },
}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ONE_WAY_LINKING, 1)
    mob:setBaseSpeed(72)
    mob:setAnimationSpeed(180)
    mob:pathThrough(pathNodes, bit.bor(xi.path.flag.PATROL, xi.path.flag.RUN))
end

entity.onMobDisengage = function(mob)
    mob:setAnimationSub(5)
end

entity.onMobEngage = function(mob, target)
    mob:setAnimationSub(0)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.CACTROT_DESACELERADOR)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(172800, 259200)) -- 2 to 3 days
end

return entity
