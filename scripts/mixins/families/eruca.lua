--[[
https://ffxiclopedia.fandom.com/wiki/Category:Crawlers

Eruca mobs can optionally be modified by calling xi.mix.eruca.config(mob, params) from within onMobSpawn.

params is a table that can contain the following keys:
    sleepHour : changes hour at which eruca crawlers naturally fall asleep (default: 18)
    wakeHour  : changes hour at which eruca crawlers naturally wake (default: 6)

Example:

xi.mix.eruca.config(mob, {
    sleepHour = 20,
    wakeHour = 4,
})

--]]
require("scripts/globals/mixins")
require("scripts/globals/magic")
-----------------------------------

xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.eruca = xi.mix.eruca or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function bedTime(mob)
    mob:setAnimationSub(mob:getAnimationSub() + 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setLocalVar("ResleepTime", 0)
end

local function wakeUp(mob)
    mob:setAnimationSub(mob:getAnimationSub() - 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 0)
    mob:setMobMod(xi.mobMod.NO_LINK, 0)
    mob:setLocalVar("ResleepTime", 0)
end

xi.mix.eruca.config = function(mob, params)
    if params.sleepHour and type(params.sleepHour) == "number" then
        mob:setLocalVar("[eruca]sleepHour", params.sleepHour)
    end

    if params.wakeHour and type(params.wakeHour) == "number" then
        mob:setLocalVar("[eruca]wakeHour", params.wakeHour)
    end
end

g_mixins.families.eruca = function(erucaMob)
    -- these defaults can be overwritten by using xi.mix.eruca.config() in onMobSpawn.  sleepHour must be > wakeHour to function properly.
    erucaMob:addListener("SPAWN", "ERUCA_SPAWN", function(mob)
        mob:setLocalVar("[eruca]sleepHour", 18)
        mob:setLocalVar("[eruca]wakeHour", 6)
    end)

    erucaMob:addListener("ROAM_TICK", "ERUCA_ROAM_TICK", function(mob)
        local currentHour = VanadielHour()
        local sleepHour = mob:getLocalVar("[eruca]sleepHour")
        local subAnimation = mob:getAnimationSub()

        if
            subAnimation == 0 and
            (currentHour >= sleepHour or currentHour < mob:getLocalVar("[eruca]wakeHour")) and
            not mob:isEngaged()
        then
            local resleepTime = mob:getLocalVar("ResleepTime")

            if resleepTime ~= 0 and mob:checkDistance(mob:getSpawnPos()) > 25 then
                mob:setLocalVar("ResleepTime", os.time() + 120) -- Reset sleep timer until crawler returns home
            elseif resleepTime <= os.time() then -- No timer was set (normal behavior) OR crawler has been back home for 2 minutes since disengaged
                bedTime(mob)
            end
        elseif
            subAnimation == 1 and
            currentHour < sleepHour and
            currentHour >= mob:getLocalVar("[eruca]wakeHour")
        then
            wakeUp(mob)
        end

        if
            VanadielDayElement() == xi.magic.ele.FIRE and
            mob:getMod(xi.mod.REGAIN) == 0
        then
            mob:setMod(xi.mod.REGAIN, 30)
        elseif
            VanadielDayElement() ~= xi.magic.ele.FIRE and
            mob:getMod(xi.mod.REGAIN) ~= 0
        then
            mob:setMod(xi.mod.REGAIN, 0)
        end
    end)

    erucaMob:addListener("ENGAGE", "ERUCA_ENGAGE", function(mob, target)
        if mob:getAnimationSub() == 1 then
            wakeUp(mob)
        end
    end)

    erucaMob:addListener("DISENGAGE", "ERUCA_DISENGAGE", function(mob)
        mob:setLocalVar("ResleepTime", os.time() + 120) -- Eruca crawlers go back to sleep exactly 2 minutes after they were engaged.
    end)
end

return g_mixins.families.eruca
