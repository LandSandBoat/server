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

NOTE:
According to the suggested behavior, Karakul will spawn a chigoe each time they use a weaponskill. However there are
not an appropriate ratio of Chigoe IDs to Karakul IDs. There appears to be, however, 10 reserved IDs for chigoes from Karakul.
The first being for Wild Karakul, and the others for the Peallaidh NM.
***This would mean that the zone would only be able to support up to 5 chigoe being spawned by Wild Karakul at once.***

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

    -- ******Chigoe pet behavior omitted until https://github.com/LandSandBoat/server/pull/4381 is merged*******

    -- karakulMob:addListener("WEAPONSKILL_STATE_EXIT", "KARAKUL_WEAPONSKILL_STATE_EXIT", function(mob, target, skill)
    --     local spawn = mob:getPos()

    --     for i = 0, 4 do
    --         local chigoe = GetMobByID(zones[mob:getZoneID()].mob.WILD_KARAKUL_CHIGOE + i)

    --         if not chigoe:isAlive() then
    --             chigoe:setSpawn(spawn.x, spawn.y, spawn.z)
    --             SpawnMob(chigoe:getID()):updateEnmity(target)
    --             chigoe:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)

    --             -- Targets master if target is pet
    --             if target:isPet() then
    --                 chigoe:updateEnmity(target:getMaster())
    --             end

    --             return -- Spawn only one
    --         end
    --     end
    -- end)

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
