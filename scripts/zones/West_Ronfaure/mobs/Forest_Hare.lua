-----------------------------------
-- Area: West Ronfaure
--  Mob: Forest Hare
-- Note: PH for Jaggedy-Eared Jack
-----------------------------------
local ID = zones[xi.zone.WEST_RONFAURE]
-----------------------------------
---@type TMobEntity
local entity = {}

local jaggedyPHTable =
{
    [ID.mob.JAGGEDY_EARED_JACK - 1] = ID.mob.JAGGEDY_EARED_JACK -- -262.780 -22.384 -253.873
}

local jaggedySpawnPoints =
{
    { x = -262.780, y = -22.384, z = -253.873 },
    { x = -267.389, y = -21.669, z = -252.720 },
    { x = -273.558, y = -19.943, z = -284.081 },
    { x = -248.681, y = -21.336, z = -163.987 },
    { x = -329.892, y = -9.702,  z = -313.713 },
    { x = -278.421, y = -11.691, z = -351.425 },
    { x = -204.492, y = -20.754, z = -324.770 },
    { x = -297.961, y = -14.931, z = -287.124 },
    { x = -354.061, y = -13.812, z = -260.330 },
    { x = -281.220, y = -19.910, z = -215.226 },
    { x = -331.034, y = -5.545,  z = -291.570 },
    { x = -396.894, y = -18.276, z = -210.088 },
    { x = -264.351, y = -22.097, z = -256.322 },
    { x = -258.142, y = -19.900, z = -196.353 },
    { x = -292.310, y = -16.660, z = -310.630 },
    { x = -256.406, y = -20.754, z = -272.561 },
    { x = -295.354, y = -14.429, z = -304.559 },
    { x = -291.582, y = -20.483, z = -189.155 },
    { x = -384.542, y = -17.336, z = -215.420 },
    { x = -262.351, y = -20.737, z = -210.364 },
    { x = -370.900, y = -19.500, z = -235.931 },
    { x = -322.527, y = -20.000, z = -197.981 },
    { x = -340.369, y = -17.150, z = -222.255 },
    { x = -270.059, y = -20.717, z = -260.793 },
    { x = -272.855, y = -16.783, z = -293.164 },
    { x = -319.361, y = -10.665, z = -268.730 },
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    local params = { }
    params.spawnPoints = jaggedySpawnPoints
    xi.mob.phOnDespawn(mob, jaggedyPHTable, 9, 2400, params) -- 40 minute minimum
end

return entity
