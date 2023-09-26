--[[
jnun mobs can optionally be modified by calling xi.mix.jnun.config(mob, params) from within onMobSpawn
params is a table that can contain the following keys (Sleep hour must be less than wake hour):
    sleepHour : changes hour at which jnun naturally fall asleep (default: 6)
    wakeHour  : changes hour at which jnun naturally wake (default: 18)
Example:
xi.mix.jnun.config(mob, {
    sleepHour = 4,
    wakeHour  = 20,
})

NOTE:
According to the suggested behavior, Jnun only agro players while the player is in the pond. After thorough
testing on retail, it appears that Jnun simply have a short agro range, and give off the illusion that
they will only agro players in their designated swamp.
--]]
require("scripts/globals/mixins")
-----------------------------------

xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.jnun = xi.mix.jnun or {}

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

xi.mix.jnun.config = function(mob, params)
    if params.sleepHour and type(params.sleepHour) == "number" then
        mob:setLocalVar("[jnun]sleepHour", params.sleepHour)
    end

    if params.wakeHour and type(params.wakeHour) == "number" then
        mob:setLocalVar("[jnun]wakeHour", params.wakeHour)
    end
end

g_mixins.families.jnun = function(jnunMob)
    jnunMob:addListener("SPAWN", "JNUN_SPAWN", function(mob)
        mob:setLocalVar("[jnun]sleepHour", 6)
        mob:setLocalVar("[jnun]wakeHour", 18)

        mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 10) -- Do not wander far from their spawn (swamp)
        mob:setMobMod(xi.mobMod.SOUND_RANGE, 7)    -- Very short sound range agro
    end)

    jnunMob:addListener("ROAM_TICK", "JNUN_ROAM_TICK", function(mob)
        local currentHour  = VanadielHour()
        local sleepHour    = mob:getLocalVar("[jnun]sleepHour")
        local wakeHour     = mob:getLocalVar("[jnun]wakeHour")
        local subAnimation = mob:getAnimationSub()

        -- Sleeps during the day
        -- time >= 6 and time <= 18
        if
            subAnimation == 0 and
            currentHour >= sleepHour and
            currentHour < wakeHour
        then
            local resleepTime = mob:getLocalVar("ResleepTime")
            local spawn       = mob:getSpawnPos()

            -- Reset sleep timer until Jnun is near spawn point
            if
                resleepTime ~= 0 and
                mob:checkDistance(spawn.x, spawn.y, spawn.z) > 10
            then
                mob:setLocalVar("ResleepTime", os.time() + 120)

            elseif resleepTime <= os.time() then
                bedTime(mob)
            end

        -- Awake during the night
        -- time < 6 or time >= 18
        elseif
            subAnimation == 1 and
            currentHour < sleepHour or
            currentHour >= wakeHour
        then
            wakeUp(mob)
        end
    end)

    jnunMob:addListener("ENGAGE", "JNUN_ENGAGE", function(mob, target)
        if mob:getAnimationSub() == 1 then
            wakeUp(mob)
        end
    end)

    jnunMob:addListener("DISENGAGE", "JNUN_DISENGAGE", function(mob)
        mob:setLocalVar("ResleepTime", os.time() + 120)
    end)
end

return g_mixins.families.jnun
