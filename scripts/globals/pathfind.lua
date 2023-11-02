-----------------------------------
--
-- NPC PATH WALKING
--
-----------------------------------
xi = xi or {}

xi.path =
{
    flag =
    {
        NONE     = 0,
        RUN      = 1,
        WALLHACK = 2,
        REVERSE  = 4,
        SCRIPT   = 8,
        SLIDE    = 16,
        PATROL   = 32,
        COORDS   = 64,
    },

    -- returns the point at the given index
    get = function(points, index)
        local point = points[index]
        return { point["x"], point["y"], point["z"] }
    end,

    -- returns first point in given path
    first = function(points)
        return xi.path.get(points, 1)
    end,

    -- returns last point in given path
    last = function(points)
        return xi.path.get(points, #points)
    end,

    -- Randomly picks a point to path to given a table of x, y, z coordinates.
    randomPath = function(mob, points, params)
        if
            not mob:isFollowingPath() and
            #points >= 1
        then
            if mob:getLocalVar("[PATH]nextPoint") == 0 then
                mob:setLocalVar("[PATH]nextPoint", math.random(1, #points))
            end

            if params == nil then
                params = 0
            end

            local nextPos = points[mob:getLocalVar("[PATH]nextPoint")]

            -- Update to next destination for path.
            if mob:checkDistance(nextPos.x, nextPos.y, nextPos.z) < 1 then
                mob:setLocalVar("[PATH]nextPoint", math.random(1, #points))
                nextPos = points[mob:getLocalVar("[PATH]nextPoint")]
            end

            mob:pathTo(nextPos.x, nextPos.y, nextPos.z, params)
        end
    end,

    -- Paths a mob using the navmesh through a given table of x, y, z, coordinates.
    -- Path should loop and will go on indefinitely.
    patrol = function(mob, points, params)
        if
            not mob:isFollowingPath() and
            #points >= 1
        then
            if mob:getLocalVar("[PATH]nextPoint") == 0 then
                mob:setLocalVar("[PATH]nextPoint", 1)
            end

            if params == nil then
                params = 0
            end

            local nextPos = points[mob:getLocalVar("[PATH]nextPoint")]

            -- Update to next destination for path. If out of range of table, reset to 1
            if mob:checkDistance(nextPos.x, nextPos.y, nextPos.z) < 1 then
                mob:setLocalVar("[PATH]nextPoint", mob:getLocalVar("[PATH]nextPoint") + 1)

                if mob:getLocalVar("[PATH]nextPoint") > #points then
                    mob:setLocalVar("[PATH]nextPoint", 1)
                end

                nextPos = points[mob:getLocalVar("[PATH]nextPoint")]
            end

            mob:pathTo(nextPos.x, nextPos.y, nextPos.z, params)
        end
    end,

    -- Paths an entity using the navmesh through a given table of x, y, z, coordinates.
    -- Path will end once the last coordinate is reached. This func also sets a
    -- variable indicating that they have finished their path. [PATH]pathFnished.
    -- If a mob is pulled away from final position, it will path back to said final
    -- position upon roaming.
    route = function(entity, points, params)
        if
            not entity:isFollowingPath() and
            #points >= 1
        then
            if entity:getLocalVar("[PATH]nextPoint") == 0 then
                entity:setLocalVar("[PATH]nextPoint", 1)
            end

            if params == nil then
                params = 0
            end

            local nextPos = points[entity:getLocalVar("[PATH]nextPoint")]

            -- Update to next destination for path. If destination reached, flag [PATH]pathFinished to 1
            if entity:checkDistance(nextPos.x, nextPos.y, nextPos.z) < 1 then
                entity:setLocalVar("[PATH]nextPoint", entity:getLocalVar("[PATH]nextPoint") + 1)

                if entity:getLocalVar("[PATH]nextPoint") >= #points then
                    entity:setLocalVar("[PATH]pathFinished", 1)
                    nextPos = points[#points]
                end
            end

            entity:pathTo(nextPos.x, nextPos.y, nextPos.z, params)
        end
    end,
}
