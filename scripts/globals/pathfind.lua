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

    -- returns number of points in given path
    length = function(points)
        return #points
    end,

    -- returns first point in given path
    first = function(points)
        return xi.path.get(points, 1)
    end,

    -- returns last point in given path
    last = function(points)
        local length = xi.path.length(points)
        local result = xi.path.get(points, length)
        return result
    end,

    -- Randomly picks a point to path to within the provided distance range
    randomPath = function(mob, points, min, max)
        local mobPosition = mob:getPos()

        local validPoints = {}
        for point, position in ipairs(points) do
            local distance =  utils.distance(mobPosition, position)
            if distance > min and distance < max then
                table.insert(validPoints, point)
            end
        end

        if #validPoints > 0 then
            local target = points[validPoints[math.random(1, #validPoints)]]
            mob:pathThrough({ target.x, target.y, target.z })
        end
    end
}
