--[[
Karakul mobs can optionally be modified by calling xi.mix.karakul.config(mob, params) from within onMobSpawn

params is a table that can contain the following keys:
    sleepHour : changes hour at which karakul naturally fall asleep (default: 18)
    wakeHour  : changes hour at which Karakul naturally wake (default: 6)

Example:

xi.mix.karakul.config(mob, {
    sleepHour = 20,
    wakeHour = 4,
})
--]]
require("scripts/globals/mixins")
-----------------------------------

xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.karakul = xi.mix.karakul or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function bedTime(mob)
    mob:setAnimationSub(1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setLocalVar("ResleepTime", 0)
end

local function wakeUp(mob)
    mob:setAnimationSub(0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 0)
    mob:setMobMod(xi.mobMod.NO_LINK, 0)
    mob:setLocalVar("ResleepTime", 0)
end

xi.mix.karakul.config = function(mob, params)
    if params.sleepHour and type(params.sleepHour) == "number" then
        mob:setLocalVar("[karakul]sleepHour", params.sleepHour)
    end

    if params.wakeHour and type(params.wakeHour) == "number" then
        mob:setLocalVar("[karakul]wakeHour", params.wakeHour)
    end
end

g_mixins.families.karakul = function(karakulMob)
    -- these defaults can be overwritten by using xi.mix.karakul.config() in onMobSpawn.  sleepHour must be > wakeHour to function properly.
    karakulMob:addListener("SPAWN", "KARAKUL_SPAWN", function(mob)
        mob:setLocalVar("[karakul]sleepHour", 18)
        mob:setLocalVar("[karakul]wakeHour", 6)
    end)

    karakulMob:addListener("ROAM_TICK", "KARAKUL_ROAM_TICK", function(mob)
        local currentHour = VanadielHour()
        local sleepHour = mob:getLocalVar("[karakul]sleepHour")
        local subAnimation = mob:getAnimationSub()

        if
            subAnimation == 0 and
            (currentHour >= sleepHour or currentHour < mob:getLocalVar("[karakul]wakeHour")) and
            not mob:isEngaged()
        then
            local resleepTime = mob:getLocalVar("ResleepTime")
            local spawn       = mob:getSpawnPos()

            if resleepTime ~= 0 and mob:checkDistance(spawn.x, spawn.y, spawn.z) > 25 then
                mob:setLocalVar("ResleepTime", os.time() + 120) -- Reset sleep timer until karakul returns home
            elseif resleepTime <= os.time() then -- No timer was set (normal behavior) OR karakul has been back home for 2 minutes since disengaged
                bedTime(mob)
            end
        elseif
            subAnimation == 1 and
            currentHour < sleepHour and
            currentHour >= mob:getLocalVar("[karakul]wakeHour")
        then
            wakeUp(mob)
        end
    end)

    karakulMob:addListener("ENGAGE", "KARAKUL_ENGAGE", function(mob, target)
        if mob:getAnimationSub() == 1 then
            wakeUp(mob)
        end
    end)

    karakulMob:addListener("DISENGAGE", "KARAKUL_DISENGAGE", function(mob)
        mob:setLocalVar("ResleepTime", os.time() + 120)
    end)
end

return g_mixins.families.karakul
