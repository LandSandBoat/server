-----------------------------------
-- Area: North Gustaberg
--  Mob: Maneating Hornet
-- Note: Place Holder For Stinging Sophie
-----------------------------------
local ID = zones[xi.zone.NORTH_GUSTABERG]
-----------------------------------
---@type TMobEntity
local entity = {}

local sophiePHTable =
{
    [ID.mob.STINGING_SOPHIE[1] - 6] = ID.mob.STINGING_SOPHIE[1], -- 196.873 -40.415 500.153
    [ID.mob.STINGING_SOPHIE[1] - 5] = ID.mob.STINGING_SOPHIE[1], -- 352.974 -40.359 472.914
    [ID.mob.STINGING_SOPHIE[1] - 4] = ID.mob.STINGING_SOPHIE[1], -- 216.150 -41.182 445.157
    [ID.mob.STINGING_SOPHIE[1] - 3] = ID.mob.STINGING_SOPHIE[1], -- 353.313 -40.347 463.609
    [ID.mob.STINGING_SOPHIE[1] - 2] = ID.mob.STINGING_SOPHIE[1], -- 237.753 -40.500 469.738
    [ID.mob.STINGING_SOPHIE[1] - 1] = ID.mob.STINGING_SOPHIE[1], -- 197.369 -40.612 453.688

    [ID.mob.STINGING_SOPHIE[2] - 5] = ID.mob.STINGING_SOPHIE[2], -- 210.607 -40.478 566.096
    [ID.mob.STINGING_SOPHIE[2] - 4] = ID.mob.STINGING_SOPHIE[2], -- 288.447 -40.842 634.161
    [ID.mob.STINGING_SOPHIE[2] - 3] = ID.mob.STINGING_SOPHIE[2], -- 295.890 -41.593 614.738
    [ID.mob.STINGING_SOPHIE[2] - 2] = ID.mob.STINGING_SOPHIE[2], -- 363.973 -40.774 562.355
    [ID.mob.STINGING_SOPHIE[2] - 1] = ID.mob.STINGING_SOPHIE[2], -- 356.544 -40.528 570.302
}

local stingingSophie =
{
    [ID.mob.STINGING_SOPHIE[1]] =
    {
        { x = 234.104, y = -40.332, z = 462.288 },
    },
    [ID.mob.STINGING_SOPHIE[2]] =
    {
        { x = 352.974, y = -40.359, z = 472.914 },
        { x = 353.313, y = -40.347, z = 463.609 },
        { x = 237.753, y = -40.500, z = 469.738 },
        { x = 216.150, y = -41.182, z = 445.157 },
        { x = 197.369, y = -40.612, z = 453.688 },
        { x = 196.873, y = -40.415, z = 500.153 },
        { x = 210.607, y = -40.478, z = 566.096 },
        { x = 288.447, y = -40.842, z = 634.161 },
        { x = 295.890, y = -41.593, z = 614.738 },
        { x = 356.544, y = -40.528, z = 570.302 },
        { x = 363.973, y = -40.774, z = 562.355 },
        { x = 308.116, y = -60.352, z = 550.771 },
        { x = 308.975, y = -61.082, z = 525.690 },
        { x = 310.309, y = -60.634, z = 521.404 },
        { x = 285.813, y = -60.784, z = 518.539 },
        { x = 283.958, y = -60.926, z = 530.016 },
        { x = 255.987, y = -39.942, z = 599.076 },
        { x = 272.464, y = -39.788, z = 423.530 },
        { x = 178.638, y = -40.846, z = 506.046 },
        { x = 216.014, y = -40.313, z = 565.127 },
        { x = 293.364, y = -41.000, z = 617.523 },
        { x = 308.459, y = -39.780, z = 635.766 },
        { x = 236.612, y = -40.000, z = 458.831 },
        { x = 349.108, y = -39.789, z = 592.532 },
        { x = 258.034, y = -41.000, z = 411.800 },
        { x = 211.296, y = -40.958, z = 457.627 },
        { x = 220.812, y = -40.101, z = 437.207 },
        { x = 188.552, y = -39.822, z = 478.633 },
        { x = 262.773, y = -40.000, z = 599.993 },
        { x = 194.046, y = -40.087, z = 511.385 },
        { x = 353.048, y = -40.574, z = 577.119 },
        { x = 284.173, y = -40.278, z = 615.288 },
        { x = 349.850, y = -39.793, z = 461.709 },
        { x = 206.148, y = -40.509, z = 444.612 },
        { x = 207.247, y = -40.366, z = 473.452 },
        { x = 314.403, y = -39.996, z = 437.785 },
        { x = 321.860, y = -40.000, z = 614.763 },
        { x = 182.365, y = -41.140, z = 500.929 },
        { x = 323.611, y = -40.000, z = 600.652 },
        { x = 271.563, y = -40.084, z = 433.923 },
        { x = 371.609, y = -41.586, z = 548.679 },
        { x = 363.904, y = -40.556, z = 549.428 },
        { x = 246.018, y = -40.617, z = 407.564 },
        { x = 206.759, y = -39.875, z = 541.410 },
        { x = 289.548, y = -39.632, z = 429.275 },
        { x = 231.661, y = -39.227, z = 567.517 },
        { x = 308.448, y = -40.925, z = 613.064 },
        { x = 222.364, y = -40.747, z = 465.730 },
        { x = 309.996, y = -40.918, z = 611.928 },
        { x = 356.987, y = -40.006, z = 584.836 },
    },
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 17, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    local nmId   = sophiePHTable[mob:getID()]
    local params = { }
    params.spawnPoints = stingingSophie[nmId]
    xi.mob.phOnDespawn(mob, sophiePHTable, 5, 1, params) -- Pure Lottery
end

return entity
