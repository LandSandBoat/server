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
        return {point["x"], point["y"], point["z"]};
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
}
