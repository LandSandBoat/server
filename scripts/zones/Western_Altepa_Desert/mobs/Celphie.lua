-----------------------------------
-- Area: Western Altepa Desert (125)
--   NM: Celphie
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =   78.226, y = -0.497, z =   69.745 },
    { x =   57.256, y =  0.116, z =   13.972 },
    { x =   70.263, y =  0.130, z =  -23.484 },
    { x =   50.014, y =  0.256, z =    7.088 },
    { x =   10.439, y = -0.280, z =  -80.476 },
    { x =   35.924, y =  0.087, z =  -98.228 },
    { x =  118.575, y = -0.299, z =  127.016 },
    { x =   99.000, y = -0.030, z =  116.000 },
    { x =   64.890, y =  0.695, z =   27.299 },
    { x =  107.745, y = -0.049, z =   16.725 },
    { x =   50.780, y =  0.329, z =   75.859 },
    { x =  144.842, y =  0.712, z =    1.704 },
    { x =  109.647, y = -0.104, z =   28.621 },
    { x =  153.282, y =  0.670, z =   18.954 },
    { x =   54.705, y = -0.098, z =  -18.060 },
    { x =   64.969, y = -0.031, z =   52.197 },
    { x =  107.552, y =  0.439, z =   38.576 },
    { x =   65.149, y =  0.446, z =   31.267 },
    { x =   78.105, y =  0.629, z =   25.666 },
    { x =   70.277, y =  0.284, z =   36.266 },
    { x =  114.485, y =  0.089, z =   32.253 },
    { x =   51.581, y =  0.377, z =   40.451 },
    { x =   44.360, y =  0.421, z =   68.761 },
    { x =  124.936, y =  0.789, z =   15.110 },
    { x =   68.789, y =  0.358, z =   38.265 },
    { x =   58.112, y =  0.808, z =  114.074 },
    { x =   63.820, y =  0.472, z =   48.170 },
    { x =  151.685, y =  0.214, z =   36.615 },
    { x =  122.444, y =  0.017, z =   75.632 },
    { x =   65.755, y =  0.190, z =   48.801 },
    { x =   57.940, y =  0.071, z =  -29.694 },
    { x =   84.990, y =  0.296, z =   11.658 },
    { x =  104.704, y =  0.484, z =   32.804 },
    { x =   95.397, y = -0.229, z =   25.741 },
    { x =  133.721, y =  0.567, z =   43.579 },
    { x =   79.601, y =  0.846, z =   23.081 },
    { x =   97.649, y =  0.746, z =   35.410 },
    { x =   79.711, y =  0.739, z =   55.434 },
    { x =  101.831, y = -0.158, z =   15.928 },
    { x =  150.314, y =  0.249, z =   30.233 },
    { x =   82.403, y =  0.367, z =   51.396 },
    { x =  139.050, y =  0.534, z =   21.020 },
    { x =  104.483, y =  0.314, z =   54.140 },
    { x =   82.348, y =  0.623, z =   14.276 },
    { x =   94.648, y =  0.755, z =    3.837 },
    { x =   74.736, y =  0.062, z =   38.806 },
    { x =   48.570, y =  0.784, z =   92.642 },
    { x =   78.887, y =  0.073, z =  -34.507 },
    { x =  101.957, y =  0.595, z =   71.922 },
    { x =   67.375, y =  0.533, z =   33.004 }
}

entity.phList =
{
    [ID.mob.CELPHIE - 1] = ID.mob.CELPHIE, -- 50.014 0.256 7.088
}

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Celphie gains strong regen after hundred fists wears
    if skill:getID() == xi.jsa.HUNDRED_FISTS then
        mob:setLocalVar('regenTime', GetSystemTime() + 45)
    end
end

entity.onMobFight = function(mob, target)
    local regenTimer = mob:getLocalVar('regenTime')
    if
        regenTimer < GetSystemTime() and
        regenTimer ~= 0 and
        mob:getMod(xi.mod.REGEN) == 0
    then
        mob:setMod(xi.mod.REGEN, 40)
    end
end

entity.onMobDespawn = function(mob)
    mob:setMod(xi.mod.REGEN, 0)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
