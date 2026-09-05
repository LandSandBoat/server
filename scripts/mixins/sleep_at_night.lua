-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
-----------------------------------

local column =
{
    SLEEP_ANIMATION  = 1,
    WAKEUP_ANIMATION = 2,
    SLEEP_HOUR_START = 3,
    SLEEP_HOUR_END   = 4,
    CAN_CAST         = 5,
    AGGRESSIVE       = 6,
    LINK             = 7,
}

-- AnimationSub used to sleep.
local dataTable =
{
    ['Carmine_Eruca'    ] = { 1, 0, 21,  6, true,  true,  0 }, -- Red Crawlers        -> Awake from 6:00 to 20:59, Only 0 or 1. 1 is asleep.
    ['Date_Eruca'       ] = { 1, 0, 21,  6, true,  true,  1 }, -- Red Crawlers        -> Awake from 6:00 to 20:59, Only 0 or 1. 1 is asleep. -- TODO: Audit Link Behavior
    ['Jnun'             ] = { 1, 0,  6, 18, false, true,  1 }, -- Fat horrible things -> Awake from 18:00 to 5:59, Only 0 or 1. 1 is asleep.
    ['Magmatic_Eruca'   ] = { 1, 0, 21,  6, true,  true,  0 }, -- Red Crawlers        -> Awake from 6:00 to 20:59, Only 0 or 1. 1 is asleep.
    ['Scoriaceous_Eruca'] = { 1, 0, 21,  6, true,  true,  0 }, -- Red Crawlers        -> Awake from 6:00 to 20:59, Only 0 or 1. 1 is asleep.
    ['Wild_Karakul'     ] = { 1, 0, 20,  6, false, false, 1 }, -- Sheep               -> Awake from 6:00 to 19:59, Only 0 or 1. 1 is asleep. -- TODO: Audit Link Behavior
    ['Ziz'              ] = { 3, 1, 20,  4, false, true,  1 }, -- Cockatrices         -> Awake from 4:00 to 19:59, 1 and 2 control puch.
}

local function fallAsleep(mob, mobName)
    mob:setAnimationSub(dataTable[mobName][column.SLEEP_ANIMATION])
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setAggressive(false)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setMagicCastingEnabled(false)
    mob:setLocalVar('[Sleep]wasEngaged', 0)
    mob:setLocalVar('[Sleep]reSleepTime', 0)
end

local function wakeUp(mob, mobName)
    mob:setAnimationSub(dataTable[mobName][column.WAKEUP_ANIMATION])
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setAggressive(dataTable[mobName][column.AGGRESSIVE])
    mob:setMobMod(xi.mobMod.NO_LINK, dataTable[mobName][column.LINK])
    mob:setMagicCastingEnabled(dataTable[mobName][column.CAN_CAST])
    mob:setLocalVar('[Sleep]wasEngaged', 0)
    mob:setLocalVar('[Sleep]reSleepTime', 0)
end

g_mixins.sleep_at_night = function(sleeperMob)
    -- Setup proper animationSub. The values in the DB are all over the place.
    sleeperMob:addListener('SPAWN', 'SLEEP_SPAWN', function(mob)
        local mobName      = mob:getName()
        local currentHour  = VanadielHour()
        local shouldSleep  = currentHour >= dataTable[mobName][column.SLEEP_HOUR_START] or currentHour < dataTable[mobName][column.SLEEP_HOUR_END]

        if shouldSleep then
            fallAsleep(mob, mobName)
        else
            wakeUp(mob, mobName)
        end
    end)

    sleeperMob:addListener('ROAM_TICK', 'SLEEP_ROAM_TICK', function(mob)
        local mobName     = mob:getName()
        local currentHour = VanadielHour()
        local shouldSleep = currentHour >= dataTable[mobName][column.SLEEP_HOUR_START] or currentHour < dataTable[mobName][column.SLEEP_HOUR_END]

        -- Is asleep.
        if mob:getAnimationSub() == dataTable[mobName][column.SLEEP_ANIMATION] then
            if not shouldSleep then
                wakeUp(mob, mobName)
            end

        -- Is awake.
        else
            -- Early return: Mob isn't home.
            if mob:checkDistance(mob:getSpawnPos()) > 25 then
                return
            end

            -- Early return: Mob is home but it's daytime.
            if not shouldSleep then
                return
            end

            -- Early return: Mob is home and should sleep. Sleep imediately if it wasn't engaged.
            if mob:getLocalVar('[Sleep]wasEngaged') == 0 then
                fallAsleep(mob, mobName)
                return
            end

            -- Mob is home and should sleep but was engaged. Set re-sleep timer if not set already.
            local reSleepTime = mob:getLocalVar('[Sleep]reSleepTime')
            local currentTime = GetSystemTime()
            if reSleepTime == 0 then
                reSleepTime = currentTime + 120
                mob:setLocalVar('[Sleep]reSleepTime', reSleepTime)
            end

            -- Mob is home, and has been for 2 minutes. Sleep.
            if currentTime > reSleepTime then
                fallAsleep(mob, mobName)
            end
        end
    end)

    sleeperMob:addListener('ENGAGE', 'SLEEP_ENGAGE', function(mob, target)
        local mobName = mob:getName()
        if mob:getAnimationSub() == dataTable[mobName][column.SLEEP_ANIMATION] then
            wakeUp(mob, mobName)
        end

        mob:setLocalVar('[Sleep]wasEngaged', 1)
        mob:setLocalVar('[Sleep]reSleepTime', 0)
    end)
end

return g_mixins.sleep_at_night
