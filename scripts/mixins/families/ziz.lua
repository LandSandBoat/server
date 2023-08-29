--[[
https://ffxiclopedia.fandom.com/wiki/Ziz

AnimationSub(1) small neck pouch
AnimationSub(2) large neck pouch
AnimationSub(3) sleeping z's
--]]
require('scripts/globals/mixins')
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function sleepDuringNight(mob)
    local aSub = mob:getAnimationSub()
    local totd = VanadielTOTD()

    if totd == xi.time.NIGHT or totd == xi.time.MIDNIGHT then -- 20:00 to 4:00
        if aSub ~= 3 then
            mob:setAnimationSub(3)
            mob:setAggressive(false)
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        end
    else
        if aSub ~= 1 then
            mob:setAnimationSub(1)
            mob:setAggressive(true)
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end
end

g_mixins.families.ziz = function(zizMob)
    zizMob:addListener('SPAWN', 'ZIZ_SPAWN', function(mob)
        sleepDuringNight(mob)
    end)

    zizMob:addListener('ROAM_TICK', 'ZIZ_ROAM', function(mob)
        sleepDuringNight(mob)
    end)

    zizMob:addListener('ENGAGE', 'ZIZ_ENGAGE', function(mob, target)
        mob:setAnimationSub(1)
        mob:setAggressive(true)
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    end)
end

return g_mixins.families.ziz
