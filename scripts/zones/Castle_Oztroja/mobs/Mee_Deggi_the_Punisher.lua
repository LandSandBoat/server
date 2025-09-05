-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Mee Deggi the Punisher
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -207.840, y = -0.498, z =  109.939 },
    { x = -178.119, y = -0.644, z =  153.039 },
    { x = -188.253, y = -0.087, z =  158.955 },
    { x = -233.116, y = -0.741, z =  172.067 },
    { x = -254.302, y = -0.057, z =  163.759 },
    { x = -227.415, y = -4.340, z =  145.213 },
    { x = -207.370, y = -0.056, z =  106.537 },
    { x = -235.639, y = -0.063, z =  103.280 },
    { x = -200.486, y =  1.000, z =  121.330 },
    { x = -201.276, y =  0.000, z =  101.003 },
    { x = -236.336, y =  0.922, z =  114.246 },
    { x = -212.840, y =  1.000, z =  120.586 },
    { x = -221.028, y =  1.000, z =  110.607 },
    { x = -199.722, y =  1.000, z =  159.576 },
    { x = -247.810, y = -0.469, z =  180.088 },
    { x = -196.532, y =  1.000, z =  163.676 },
    { x = -226.746, y = -0.123, z =  180.691 },
    { x = -202.509, y =  0.000, z =  179.250 },
    { x = -244.984, y =  0.726, z =  159.910 },
    { x = -195.774, y =  0.000, z =  179.256 },
    { x = -210.076, y = -0.604, z =   97.497 },
    { x = -236.267, y =  0.130, z =  102.585 },
    { x = -199.962, y =  1.000, z =  117.889 },
    { x = -200.931, y =  1.000, z =  150.333 },
    { x = -181.558, y =  0.000, z =  170.371 },
    { x = -261.732, y = -0.302, z =  130.822 },
    { x = -217.938, y =  1.000, z =  162.589 },
    { x = -259.525, y = -0.064, z =  136.719 },
    { x = -195.130, y =  0.727, z =  122.116 },
    { x = -244.069, y =  0.000, z =  179.402 },
    { x = -188.840, y =  0.000, z =  118.054 },
    { x = -225.489, y =  0.868, z =  111.226 },
    { x = -182.578, y = -0.309, z =  143.739 },
    { x = -253.170, y =  1.000, z =  107.838 },
    { x = -194.412, y =  1.000, z =  154.210 },
    { x = -187.727, y = -0.912, z =  112.638 },
    { x = -219.652, y =  1.000, z =  113.864 },
    { x = -202.067, y =  1.000, z =  144.255 },
    { x = -211.906, y =  0.000, z =  179.330 },
    { x = -244.243, y =  0.924, z =  145.509 },
    { x = -184.446, y = -0.556, z =  133.969 },
    { x = -239.122, y =  1.000, z =  131.491 },
    { x = -217.440, y =  0.042, z =  178.733 },
    { x = -259.423, y = -0.076, z =  136.640 },
    { x = -211.816, y = -0.078, z =  167.255 },
    { x = -257.173, y = -0.158, z =  167.621 },
    { x = -260.119, y = -0.330, z =  129.172 },
    { x = -184.559, y = -0.564, z =  134.447 },
    { x = -246.817, y =  1.000, z =  126.654 },
    { x = -256.918, y = -0.084, z =  148.852 }
}

entity.phList =
{
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 39] = ID.mob.MEE_DEGGI_THE_PUNISHER, -- Yagudo_Interrogator: -207.370 -0.056 106.537
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 31] = ID.mob.MEE_DEGGI_THE_PUNISHER, -- Yagudo_Interrogator: -188.253 -0.087 158.955
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 16] = ID.mob.MEE_DEGGI_THE_PUNISHER, -- Yagudo_Interrogator: -254.302 -0.057 163.759
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 1]  = ID.mob.MEE_DEGGI_THE_PUNISHER, -- Yagudo_Interrogator: -227.415 -4.340 145.213
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 34] = ID.mob.MEE_DEGGI_THE_PUNISHER, -- Yagudo_Drummer:      -178.119 -0.644 153.039
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 25] = ID.mob.MEE_DEGGI_THE_PUNISHER, -- Yagudo_Drummer:      -235.639 -0.063 103.280
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 17] = ID.mob.MEE_DEGGI_THE_PUNISHER, -- Yagudo_Drummer:      -233.116 -0.741 172.067
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 2]  = ID.mob.MEE_DEGGI_THE_PUNISHER, -- Yagudo_Drummer:      -207.840 -0.498 109.939
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
