-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}
-----------------------------------

-- three rests in four are {45..60}; the fourth is a nap of 57 to 149 s asleep plus 9 s standing before the walk
local restBands =
{
    awake = { cool = 60, rate = 40, chance = 76 },
    nap   = { min = 57, max = 149, wake = 9, rate = -1 },
}

local subAwake  = 4
local subAsleep = 5

g_mixins.families.meeble = function(meebleMob)
    meebleMob:addListener('SPAWN', 'MEEBLE_SPAWN', function(mob)
        mob:setAnimationSub(subAwake)
    end)

    meebleMob:addListener('ROAM_TICK', 'MEEBLE_ROAM_TICK', function(mob)
        if mob:isFollowingPath() then
            if math.randomInt(1, 100) <= restBands.awake.chance then
                mob:setMobMod(xi.mobMod.ROAM_COOL, restBands.awake.cool)
                mob:setMobMod(xi.mobMod.ROAM_RATE, restBands.awake.rate)
            else
                mob:setMobMod(xi.mobMod.ROAM_COOL, math.randomInt(restBands.nap.min, restBands.nap.max) + restBands.nap.wake)
                mob:setMobMod(xi.mobMod.ROAM_RATE, restBands.nap.rate)
            end
        elseif
            mob:getMobMod(xi.mobMod.ROAM_RATE) == restBands.nap.rate and
            mob:getAnimationSub() == subAwake
        then
            mob:setAnimationSub(subAsleep)
            mob:timer((mob:getMobMod(xi.mobMod.ROAM_COOL) - restBands.nap.wake) * 1000, function(mobArg)
                mobArg:setAnimationSub(subAwake)
                mobArg:setMobMod(xi.mobMod.ROAM_RATE, restBands.awake.rate)
            end)
        end
    end)

    meebleMob:addListener('ENGAGE', 'MEEBLE_ENGAGE', function(mob)
        mob:setAnimationSub(subAwake)
    end)
end

return g_mixins.families.meeble
