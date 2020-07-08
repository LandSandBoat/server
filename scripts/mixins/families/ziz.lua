--[[
https://ffxiclopedia.fandom.com/wiki/Ziz

AnimationSub(1) small neck pouch
AnimationSub(2) large neck pouch
AnimationSub(3) sleeping z's
--]]
require("scripts/globals/mixins")
require("scripts/globals/status")
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function sleepDuringNight(mob)
    local aSub = mob:AnimationSub()
    local totd = VanadielTOTD()

    if totd == tpz.time.NIGHT or totd == tpz.time.MIDNIGHT then -- 20:00 to 4:00
        if aSub ~= 3 then
            mob:AnimationSub(3)
            mob:setAggressive(0)
            mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        end
    else
        if aSub ~= 1 then
            mob:AnimationSub(1)
            mob:setAggressive(1)
            mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
        end
    end
end

g_mixins.families.ziz = function(mob)
    mob:addListener("SPAWN", "ZIZ_SPAWN", function(mob)
        sleepDuringNight(mob)
    end)

    mob:addListener("ROAM_TICK", "ZIZ_ROAM", function(mob)
        sleepDuringNight(mob)
    end)

    mob:addListener("ENGAGE", "ZIZ_ENGAGE", function(mob, target)
        mob:AnimationSub(1)
        mob:setAggressive(1)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    end)
end

return g_mixins.families.ziz
