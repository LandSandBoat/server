-----------------------------------
-- Area: RoMaeve
--   NM: Nightmare Vase
-----------------------------------
local ID = zones[xi.zone.ROMAEVE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.NIGHTMARE_VASE[1] - 5] = ID.mob.NIGHTMARE_VASE[1],
    [ID.mob.NIGHTMARE_VASE[1] - 3] = ID.mob.NIGHTMARE_VASE[1],
    [ID.mob.NIGHTMARE_VASE[1] - 1] = ID.mob.NIGHTMARE_VASE[1],
    [ID.mob.NIGHTMARE_VASE[2] - 5] = ID.mob.NIGHTMARE_VASE[2],
    [ID.mob.NIGHTMARE_VASE[2] - 3] = ID.mob.NIGHTMARE_VASE[2],
    [ID.mob.NIGHTMARE_VASE[2] - 1] = ID.mob.NIGHTMARE_VASE[2],
}

entity.spawnPoints =
{
    [ID.mob.NIGHTMARE_VASE[1]] =
    {
        { x =  -31.029, y = -5.200, z = -7.555 },
        { x =  -38.892, y = -6.000, z = -0.706 },
        { x =  -42.628, y = -5.200, z = -9.417 },
        { x =  -55.255, y = -5.555, z = 24.697 },
        { x =  -65.535, y = -6.000, z = 15.072 },
        { x =  -71.796, y = -5.200, z = 21.319 },
        { x =  -93.556, y = -6.000, z = -0.131 },
        { x = -102.526, y = -5.200, z =  3.657 },
        { x = -105.634, y = -5.200, z = -7.916 },
    },

    [ID.mob.NIGHTMARE_VASE[2]] =
    {
        { x =  68.198, y = -5.600, z =  17.087 },
        { x =  62.997, y = -5.200, z =  24.771 },
        { x =  54.403, y = -5.424, z =  18.799 },
        { x =  44.904, y = -5.952, z =  -4.392 },
        { x =  37.619, y = -5.200, z = -10.822 },
        { x =  33.296, y = -5.692, z =   0.800 },
        { x = 105.164, y = -5.600, z =  -4.998 },
        { x = 104.359, y = -5.200, z =   6.807 },
        { x =  93.207, y = -6.000, z =  -0.404 },
    },
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 327)
end

return entity
