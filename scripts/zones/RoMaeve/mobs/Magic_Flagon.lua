-----------------------------------
-- Area: RoMaeve
--  Mob: Magic Flagon
-- Note: PH for Nightmare Vase and Rogue Receptacle
-- TODO: Nightmare Vase and Rogue Receptacle PHs should be in spawn groups
-----------------------------------
local ID = zones[xi.zone.ROMAEVE]
-----------------------------------
---@type TMobEntity
local entity = {}

local nightmareSpawnPoints =
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

local nightmarePHTable =
{
    [ID.mob.NIGHTMARE_VASE[1] - 5] = ID.mob.NIGHTMARE_VASE[1],
    [ID.mob.NIGHTMARE_VASE[1] - 3] = ID.mob.NIGHTMARE_VASE[1],
    [ID.mob.NIGHTMARE_VASE[1] - 1] = ID.mob.NIGHTMARE_VASE[1],
    [ID.mob.NIGHTMARE_VASE[2] - 5] = ID.mob.NIGHTMARE_VASE[2],
    [ID.mob.NIGHTMARE_VASE[2] - 3] = ID.mob.NIGHTMARE_VASE[2],
    [ID.mob.NIGHTMARE_VASE[2] - 1] = ID.mob.NIGHTMARE_VASE[2],
}

local rogueSpawnPoints =
{
    { x =  219.800, y = -3.200, z = -41.220 },
    { x = -307.000, y =  2.000, z = 216.000 },
    { x = -299.000, y =  0.000, z = 192.000 },
    { x = -334.000, y =  3.000, z = 182.000 },
    { x = -301.000, y =  0.000, z = 166.000 },
}

local roguePHTable =
{
    [ID.mob.ROGUE_RECEPTACLE - 4] = ID.mob.ROGUE_RECEPTACLE,
    [ID.mob.ROGUE_RECEPTACLE - 1] = ID.mob.ROGUE_RECEPTACLE,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 120, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, nightmarePHTable, 10, 3600, { spawnPoints = nightmareSpawnPoints }) -- 1 hour
    xi.mob.phOnDespawn(mob, roguePHTable, 10, 7200, { spawnPoints = rogueSpawnPoints }) -- 2 hour
end

return entity
