--[[
https://ffxiclopedia.fandom.com/wiki/Category:Crawlers

Eruca mobs can optionally be modified by calling tpz.mix.eruca.config(mob, params) from within onMobSpawn.

params is a table that can contain the following keys:
    sleepHour : changes hour at which eruca crawlers naturally fall asleep (default: 18)
    wakeHour  : changes hour at which eruca crawlers naturally wake (default: 6)

Example:

tpz.mix.eruca.config(mob, {
    sleepHour = 20,
    wakeHour = 4,
})

--]]
require("scripts/globals/mixins")
require("scripts/globals/status")
-----------------------------------

tpz = tpz or {}
tpz.mix = tpz.mix or {}
tpz.mix.eruca = tpz.mix.eruca or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function bedTime(mob)
    mob:AnimationSub(mob:AnimationSub() + 1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 1)
    mob:setMobMod(tpz.mobMod.NO_LINK, 1)
    mob:setLocalVar("ResleepTime", 0)
end

local function wakeUp(mob)
    mob:AnimationSub(mob:AnimationSub() - 1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 0)
    mob:setMobMod(tpz.mobMod.NO_LINK, 0)
    mob:setLocalVar("ResleepTime", 0)
end

tpz.mix.eruca.config = function(mob, params)
    if params.sleepHour and type(params.sleepHour) == "number" then
        mob:setLocalVar("[eruca]sleepHour", params.sleepHour)
    end
    if params.wakeHour and type(params.wakeHour) == "number" then
        mob:setLocalVar("[eruca]wakeHour", params.wakeHour)
    end
end

g_mixins.families.eruca = function(mob)
    -- these defaults can be overwritten by using tpz.mix.eruca.config() in onMobSpawn.  sleepHour must be > wakeHour to function properly.
    mob:addListener("SPAWN", "ERUCA_SPAWN", function(mob)
        mob:setLocalVar("[eruca]sleepHour", 18)
        mob:setLocalVar("[eruca]wakeHour", 6)
    end)

    mob:addListener("ROAM_TICK", "ERUCA_ROAM_TICK", function(mob)
        local currentHour = VanadielHour()
        local sleepHour = mob:getLocalVar("[eruca]sleepHour")
        local wakeHour = mob:getLocalVar("[eruca]wakeHour")
        local subAnimation = mob:AnimationSub()

        if subAnimation == 0 and (currentHour >= sleepHour or currentHour < mob:getLocalVar("[eruca]wakeHour")) and not mob:isEngaged() then
            local resleepTime = mob:getLocalVar("ResleepTime")

            if resleepTime ~= 0 and mob:checkDistance(mob:getSpawnPos()) > 25 then
                mob:setLocalVar("ResleepTime", os.time() + 120) -- Reset sleep timer until crawler returns home
            elseif resleepTime <= os.time() then -- No timer was set (normal behavior) OR crawler has been back home for 2 minutes since disengaged
                bedTime(mob)
            end
        elseif subAnimation == 1 and currentHour < sleepHour and currentHour >= mob:getLocalVar("[eruca]wakeHour") then
            wakeUp(mob)
        end
        if VanadielDayElement() == tpz.day.FIRESDAY and mob:getMod(tpz.mod.REGAIN) == 0 then
            mob:setMod(tpz.mod.REGAIN, 30)
        elseif VanadielDayElement() ~= tpz.day.FIRESDAY and mob:getMod(tpz.mod.REGAIN) ~= 0 then
            mob:setMod(tpz.mod.REGAIN, 0)
        end
    end)

    mob:addListener("ENGAGE", "ERUCA_ENGAGE", function(mob, target)
        if mob:AnimationSub() == 1 then
            wakeUp(mob)
        end
    end)

    mob:addListener("DISENGAGE", "ERUCA_DISENGAGE", function(mob)
        mob:setLocalVar("ResleepTime", os.time() + 120) -- Eruca crawlers go back to sleep exactly 2 minutes after they were engaged.
    end)
end

return g_mixins.families.eruca
