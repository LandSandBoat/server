-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Quu Domi the Gallant
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  103.948, y = -1.250, z = -189.869 },
    { x =   67.103, y = -0.079, z = -176.981 },
    { x =   99.000, y = -0.181, z = -149.000 },
    { x =   46.861, y =  0.343, z = -176.989 },
    { x =   35.847, y = -0.500, z = -101.685 },
    { x =   59.000, y = -4.000, z = -131.000 },
    { x =   33.832, y = -0.068, z = -176.627 },
    { x =   20.544, y =  0.000, z = -121.398 },
    { x =   31.837, y =  0.184, z = -137.826 },
    { x =   80.843, y =  1.000, z = -130.427 },
    { x =   97.365, y =  0.000, z = -129.224 },
    { x =   20.694, y =  0.000, z = -122.428 },
    { x =   62.965, y =  1.000, z = -110.195 },
    { x =   77.182, y = -0.032, z = -171.636 },
    { x =   37.845, y =  0.000, z = -104.135 },
    { x =   47.819, y = -0.381, z =  -99.047 },
    { x =   57.716, y =  1.000, z = -165.852 },
    { x =   86.672, y =  0.000, z = -103.196 },
    { x =   72.681, y =  0.367, z = -167.813 },
    { x =   83.170, y =  1.000, z = -136.492 },
    { x =   65.748, y =  1.000, z = -160.707 },
    { x =   98.162, y = -0.023, z = -151.412 },
    { x =   34.100, y =  1.000, z = -126.059 },
    { x =   17.609, y =  0.025, z = -141.503 },
    { x =   81.751, y =  0.000, z = -172.530 },
    { x =   84.239, y = -0.126, z = -113.070 },
    { x =   89.402, y =  0.731, z = -168.426 },
    { x =   86.359, y =  0.602, z = -170.946 },
    { x =   24.309, y = -0.579, z = -110.052 },
    { x =  102.607, y =  0.000, z = -163.066 },
    { x =   83.216, y =  1.000, z = -144.533 },
    { x =   54.197, y =  0.459, z = -114.073 },
    { x =   25.728, y = -0.501, z = -165.874 },
    { x =  102.828, y =  0.000, z = -160.506 },
    { x =   98.023, y =  0.000, z = -115.367 },
    { x =   75.078, y =  1.000, z = -158.843 },
    { x =   25.186, y = -0.774, z = -169.315 },
    { x =   84.421, y =  1.000, z = -138.305 },
    { x =   53.271, y =  0.957, z = -116.708 },
    { x =   60.759, y =  1.000, z = -119.950 },
    { x =   32.345, y = -0.501, z = -173.114 },
    { x =   67.678, y = -0.772, z =  -99.881 },
    { x =   96.540, y =  0.000, z = -133.219 },
    { x =   48.871, y =  1.000, z = -118.239 },
    { x =  103.370, y = -0.009, z = -180.544 },
    { x =   42.608, y =  1.000, z = -121.952 },
    { x =   37.650, y =  1.000, z = -145.171 },
    { x =   83.778, y =  1.000, z = -143.465 },
    { x =   37.863, y =  1.000, z = -118.840 },
    { x =   19.013, y = -0.210, z = -152.679 }
}

entity.phList =
{
    [ID.mob.QUU_DOMI_THE_GALLANT - 39] = ID.mob.QUU_DOMI_THE_GALLANT, -- Yagudo_Oracle: 46.861 0.343 -176.989
    [ID.mob.QUU_DOMI_THE_GALLANT - 25] = ID.mob.QUU_DOMI_THE_GALLANT, -- Yagudo_Oracle: 67.103 -0.079 -176.981
    [ID.mob.QUU_DOMI_THE_GALLANT - 17] = ID.mob.QUU_DOMI_THE_GALLANT, -- Yagudo_Oracle: 99.000 -0.181 -149.000
    [ID.mob.QUU_DOMI_THE_GALLANT - 2]  = ID.mob.QUU_DOMI_THE_GALLANT, -- Yagudo_Oracle: 35.847 -0.500 -101.685
    [ID.mob.QUU_DOMI_THE_GALLANT - 41] = ID.mob.QUU_DOMI_THE_GALLANT, -- Yagudo_Herald: 33.832 -0.068 -176.627
    [ID.mob.QUU_DOMI_THE_GALLANT - 33] = ID.mob.QUU_DOMI_THE_GALLANT, -- Yagudo_Herald: 18.545 -0.056 -120.283
    [ID.mob.QUU_DOMI_THE_GALLANT - 26] = ID.mob.QUU_DOMI_THE_GALLANT, -- Yagudo_Herald: 103.948 -1.250 -189.869
    [ID.mob.QUU_DOMI_THE_GALLANT - 3]  = ID.mob.QUU_DOMI_THE_GALLANT, -- Yagudo_Herald: 59.000 -4.000 -131.000
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
