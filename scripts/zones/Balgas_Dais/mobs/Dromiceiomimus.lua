-----------------------------------
-- Area: Balgas Dais
--  Mob: Dromiceiomimus
-- BCNM: Rapid Raptors
-----------------------------------
local ID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

---@type TMobEntity
local entity = {}

local paths =
{
    [1] =
    {
        inner =
        {
            { x = -132.799, y =  55.702, z = -223.101 },
            { x = -134.702, y =  55.636, z = -221.158 },
            { x = -136.333, y =  55.584, z = -219.548 },
            { x = -137.790, y =  55.996, z = -218.808 },
            { x = -139.968, y =  55.607, z = -219.697 },
            { x = -141.589, y =  55.614, z = -219.738 },
            { x = -143.068, y =  55.714, z = -222.150 },
            { x = -144.118, y =  55.749, z = -223.468 },
            { x = -142.939, y =  55.670, z = -225.380 },
            { x = -142.811, y =  55.575, z = -227.650 },
            { x = -141.063, y =  56.144, z = -228.124 },
            { x = -139.124, y =  55.764, z = -229.968 },
            { x = -138.674, y =  55.700, z = -229.348 },
            { x = -136.390, y =  55.635, z = -228.525 },
            { x = -134.373, y =  55.505, z = -227.443 },
            { x = -133.536, y =  55.588, z = -225.772 },
        },

        outer =
        {
            { x = -148.108, y =  55.557, z = -223.039 },
            { x = -148.126, y =  55.393, z = -226.919 },
            { x = -145.864, y =  55.459, z = -230.389 },
            { x = -142.797, y =  55.454, z = -232.322 },
            { x = -140.861, y =  55.573, z = -231.984 },
            { x = -137.169, y =  55.682, z = -229.561 },
            { x = -134.443, y =  55.491, z = -232.562 },
            { x = -130.397, y =  55.304, z = -229.155 },
            { x = -129.245, y =  55.420, z = -225.703 },
            { x = -127.689, y =  55.509, z = -222.785 },
            { x = -130.119, y =  55.299, z = -218.560 },
            { x = -133.747, y =  55.345, z = -215.583 },
            { x = -137.560, y =  55.302, z = -214.770 },
            { x = -138.667, y =  55.270, z = -214.399 },
            { x = -143.450, y =  55.425, z = -215.724 },
            { x = -147.165, y =  55.306, z = -218.210 },
        },
    },

    [2] =
    {
        inner =
        {
            { x =   27.266, y =  -4.266, z =  -22.948 },
            { x =   25.363, y =  -4.332, z =  -21.005 },
            { x =   23.732, y =  -4.384, z =  -19.395 },
            { x =   22.275, y =  -3.972, z =  -18.655 },
            { x =   20.097, y =  -4.361, z =  -19.544 },
            { x =   18.476, y =  -4.354, z =  -19.585 },
            { x =   16.997, y =  -4.254, z =  -21.997 },
            { x =   15.947, y =  -4.219, z =  -23.315 },
            { x =   17.126, y =  -4.298, z =  -25.227 },
            { x =   17.254, y =  -4.393, z =  -27.497 },
            { x =   19.002, y =  -3.824, z =  -27.971 },
            { x =   20.941, y =  -4.204, z =  -29.815 },
            { x =   21.391, y =  -4.268, z =  -29.195 },
            { x =   23.675, y =  -4.333, z =  -28.372 },
            { x =   25.692, y =  -4.463, z =  -27.290 },
            { x =   26.529, y =  -4.380, z =  -25.619 },
        },

        outer =
        {
            { x =   11.957, y =  -4.411, z =  -22.886 },
            { x =   11.939, y =  -4.575, z =  -26.766 },
            { x =   14.201, y =  -4.509, z =  -30.236 },
            { x =   17.268, y =  -4.514, z =  -32.169 },
            { x =   19.204, y =  -4.395, z =  -31.831 },
            { x =   22.896, y =  -4.286, z =  -29.408 },
            { x =   25.622, y =  -4.477, z =  -32.409 },
            { x =   29.668, y =  -4.664, z =  -29.002 },
            { x =   30.820, y =  -4.548, z =  -25.550 },
            { x =   32.376, y =  -4.459, z =  -22.632 },
            { x =   29.946, y =  -4.669, z =  -18.407 },
            { x =   26.318, y =  -4.623, z =  -15.430 },
            { x =   22.505, y =  -4.666, z =  -14.617 },
            { x =   21.398, y =  -4.698, z =  -14.246 },
            { x =   16.615, y =  -4.543, z =  -15.571 },
            { x =   12.900, y =  -4.662, z =  -18.057 },
        },
    },

    [3] =
    {
        inner =
        {
            { x =  187.196, y = -64.263, z =  177.002 },
            { x =  185.293, y = -64.329, z =  178.945 },
            { x =  183.662, y = -64.381, z =  180.555 },
            { x =  182.205, y = -63.969, z =  181.295 },
            { x =  180.027, y = -64.358, z =  180.406 },
            { x =  178.406, y = -64.351, z =  180.365 },
            { x =  176.927, y = -64.251, z =  177.953 },
            { x =  175.877, y = -64.216, z =  176.635 },
            { x =  177.056, y = -64.295, z =  174.723 },
            { x =  177.184, y = -64.390, z =  172.453 },
            { x =  178.932, y = -63.821, z =  171.979 },
            { x =  180.871, y = -64.201, z =  170.135 },
            { x =  181.321, y = -64.265, z =  170.755 },
            { x =  183.605, y = -64.330, z =  171.578 },
            { x =  185.622, y = -64.460, z =  172.660 },
            { x =  186.459, y = -64.377, z =  174.331 },
        },

        outer =
        {
            { x =  171.887, y = -64.408, z =  177.064 },
            { x =  171.869, y = -64.572, z =  173.184 },
            { x =  174.131, y = -64.506, z =  169.714 },
            { x =  177.198, y = -64.511, z =  167.781 },
            { x =  179.134, y = -64.392, z =  168.119 },
            { x =  182.826, y = -64.283, z =  170.542 },
            { x =  185.552, y = -64.474, z =  167.541 },
            { x =  189.598, y = -64.661, z =  170.948 },
            { x =  190.750, y = -64.545, z =  174.400 },
            { x =  192.306, y = -64.456, z =  177.318 },
            { x =  189.876, y = -64.666, z =  181.543 },
            { x =  186.248, y = -64.620, z =  184.520 },
            { x =  182.435, y = -64.663, z =  185.333 },
            { x =  181.328, y = -64.695, z =  185.704 },
            { x =  176.545, y = -64.540, z =  184.379 },
            { x =  172.830, y = -64.659, z =  181.893 },
        },
    },
}

local raptorTrackAssignments =
{
    [0] = paths[1].inner,
    [1] = paths[1].outer,
    [3] = paths[2].inner,
    [4] = paths[2].outer,
    [6] = paths[3].inner,
    [7] = paths[3].outer,
}

local function getNearestStartPoint(path, pos)
    local nearestStartPoint    = 1 -- Fall back to the first point if something goes wrong.
    local xDistanceFromPos     = path[1].x - pos.x
    local zDistanceFromPos     = path[1].z - pos.z
    local nearestPointDistance = xDistanceFromPos * xDistanceFromPos + zDistanceFromPos * zDistanceFromPos

    for point = 2, #path do -- Starting at the 2nd point, iterate through the path and find the point closest to the mob's current position.
        xDistanceFromPos = path[point].x - pos.x
        zDistanceFromPos = path[point].z - pos.z

        local pathDistance = xDistanceFromPos * xDistanceFromPos + zDistanceFromPos * zDistanceFromPos
        if pathDistance < nearestPointDistance then -- If this point is closer than the previously recorded closest point, update the nearest point variables.
            nearestStartPoint    = point
            nearestPointDistance = pathDistance
        end
    end

    return nearestStartPoint -- Return the index of the nearest point on the path to the mob's current position.
end

local function buildRunPath(path, mob)
    local runPath       = {}
    local startingPoint = getNearestStartPoint(path, mob:getPos()) -- Fetches the path point to the mob to start the run from.
    local pathLength    = math.random(15, 50) -- Will generate a path between 15 and 50 points long.
    local direction     = math.random(0, 1) == 0 and -1 or 1 -- Randomly choose to run the path clockwise or counter-clockwise.

    for offset = 0, pathLength - 1 do -- Starting from the nearest point, add points to the run path in the chosen direction.
        local pointTable = ((startingPoint + offset * direction - 1) % #path) + 1 -- Loop through the path and wrap-around using modulo to make a full circle if needed.
        runPath[#runPath + 1] = path[pointTable] -- Add the point to the run path.
    end

    return runPath
end

local innerRaptorSkills =
{
    xi.mobSkill.THUNDERBOLT_RAPTOR,
    xi.mobSkill.FROST_BREATH_1,
}

local outerRaptorSkills =
{
    xi.mobSkill.SCYTHE_TAIL_1,
    xi.mobSkill.FOUL_BREATH_1,
}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('trackIndex', mob:getID() - ID.mob.DROMICEIOMIMUS)
    local track = raptorTrackAssignments[mob:getLocalVar('trackIndex')]

    if not track then
        return
    end

    if
        track == paths[1].inner or
        track == paths[2].inner or
        track == paths[3].inner
    then
        mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 300) -- Inner Raptor hits much harder.
    else
        mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    end

    mob:setLocalVar('runPhase', 1)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setBaseSpeed(44)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('raptorRunTime', GetSystemTime() + math.random(25, 40))
end

entity.onMobFight = function(mob, target)
    local currentTime = GetSystemTime()

    switch (mob:getLocalVar('runPhase')): caseof
    {
        -- Phase 1 : In combat, waiting for the timer to run out before starting to run.
        [1] = function()
            if currentTime < mob:getLocalVar('raptorRunTime') then
                return
            end

            local track = raptorTrackAssignments[mob:getLocalVar('trackIndex')]

            if not track then
                return
            end

            mob:setLocalVar('runPhase', 2)
            mob:setBaseSpeed(126)
            mob:setAutoAttackEnabled(false)
            mob:setMobAbilityEnabled(false)
            mob:pathThrough(buildRunPath(track, mob), bit.bor(xi.path.flag.SCRIPT, xi.path.flag.COORDS, xi.path.flag.RUN))
        end,

        -- Phase 2 : Running the path...
        [2] = function()
            if mob:isFollowingPath() then
                return
            end

            mob:setAutoAttackEnabled(true)
            mob:setMobAbilityEnabled(true)
            mob:setLocalVar('runPhase', 3)
        end,

        -- Phase 3 : Path finished, running to target to execute mobSkill
        [3] = function()
            if mob:checkDistance(target) > 7 then
                return
            end

            local track = raptorTrackAssignments[mob:getLocalVar('trackIndex')]

            if not track then
                return
            end

            if
                track == paths[1].inner or
                track == paths[2].inner or
                track == paths[3].inner
            then
                mob:useMobAbility(innerRaptorSkills[math.random(1, #innerRaptorSkills)])
            else
                mob:useMobAbility(outerRaptorSkills[math.random(1, #outerRaptorSkills)])
            end

            mob:setLocalVar('runPhase', 1)
            mob:setLocalVar('raptorRunTime', currentTime + math.random(25, 40))
            mob:setBaseSpeed(44)
        end,
    }
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local track = raptorTrackAssignments[mob:getLocalVar('trackIndex')]

    if not track then
        return 0
    end

    if
        track == paths[1].inner or
        track == paths[2].inner or
        track == paths[3].inner
    then
        return innerRaptorSkills[math.random(1, #innerRaptorSkills)]
    else
        return outerRaptorSkills[math.random(1, #outerRaptorSkills)]
    end
end

entity.onMobDisengage = function(mob)
    mob:clearPath()
    mob:setBaseSpeed(44)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setLocalVar('runPhase', 1)
end

return entity
