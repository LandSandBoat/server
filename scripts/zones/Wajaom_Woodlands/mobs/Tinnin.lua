-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Tinnin
-- !pos 276 0 -694
-- Spawned with Monkey Wine: @additem 2573
-- Wiki: http://ffxiclopedia.wikia.com/wiki/Tinnin
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/mixins/rage")
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 12000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 30000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 8000)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMod(xi.mod.UDMGBREATH, -10000) -- immune to breath damage
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setHP(mob:getMaxHP() / 2)
    mob:setUnkillable(true)
    mob:setMod(xi.mod.REGEN, 50)

    -- Regen Head every 1.5-4 minutes 90-240
    mob:setLocalVar("headTimer", os.time() + math.random(60, 190))

    -- Number of crits to lose a head
    mob:setLocalVar("CritToTheFace", math.random(10, 30))
    mob:setLocalVar("crits", 0)
end

entity.onMobRoam = function(mob)
    -- Regen head
    local headTimer = mob:getLocalVar("headTimer")
    if mob:getAnimationSub() == 2 and os.time() > headTimer then
        mob:setAnimationSub(1)
        mob:setLocalVar("headTimer", os.time() + math.random(60, 190))

        -- First time it regens second head, 25%. Reduced afterwards.
        if mob:getLocalVar("secondHead") == 0 then
            mob:addHP(mob:getMaxHP() * .25)
            mob:setLocalVar("secondHead", 1)
        else
            mob:addHP(mob:getMaxHP() * .05)
        end

    elseif mob:getAnimationSub() == 1 and os.time() > headTimer then
        mob:setAnimationSub(0)
        mob:setLocalVar("headTimer", os.time() + math.random(60, 190))

        -- First time it regens third head, 25%. Reduced afterwards.
        if mob:getLocalVar("thirdHead") == 0 then
            mob:addHP(mob:getMaxHP() * .25)
            mob:setMod(xi.mod.REGEN, 10)
            mob:setLocalVar("thirdHead", 1)
            mob:setUnkillable(false) -- It can be killed now that has all his heads
        else
            mob:addHP(mob:getMaxHP() * .05)
        end
    end
end

entity.onMobFight = function(mob, target)
    local headTimer = mob:getLocalVar("headTimer")
    if mob:getAnimationSub() == 2 and os.time() > headTimer then
        mob:setAnimationSub(1)
        mob:setLocalVar("headTimer", os.time() + math.random(60, 190))

        -- First time it regens second head, 25%. Reduced afterwards.
        if mob:getLocalVar("secondHead") == 0 then
            mob:addHP(mob:getMaxHP() * .25)
            mob:setLocalVar("secondHead", 1)
        else
            mob:addHP(mob:getMaxHP() * .05)
        end

        if bit.band(mob:getBehaviour(), xi.behavior.NO_TURN) > 0 then -- disable no turning for the forced mobskills upon head growth
            mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.NO_TURN)))
        end

        -- These need to be listed in reverse order as forced moves are added to the top of the queue.
        mob:useMobAbility(1830) -- Polar Blast
        mob:useMobAbility(1832) -- Barofield

    elseif mob:getAnimationSub() == 1 and os.time() > headTimer then
        mob:setAnimationSub(0)
        mob:setLocalVar("headTimer", os.time() + math.random(60, 190))

        -- First time it regens third head, 25%. Reduced afterwards.
        if mob:getLocalVar("thirdHead") == 0 then
            mob:setMod(xi.mod.REGEN, 10)
            mob:addHP(mob:getMaxHP() * .25)
            mob:setLocalVar("thirdHead", 1)
            mob:setUnkillable(false) -- It can be killed now that has all his heads
        else
            mob:addHP(mob:getMaxHP() * .05)
        end

        if bit.band(mob:getBehaviour(), xi.behavior.NO_TURN) > 0 then -- disable no turning for the forced mobskills upon head growth
            mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.NO_TURN)))
        end

        -- Reverse order, same deal.
        mob:useMobAbility(1828) -- Pyric Blast
        mob:useMobAbility(1830) -- Polar Blast
        mob:useMobAbility(1832) -- Barofield
    end
end

entity.onCriticalHit = function(mob)
    local critNum = mob:getLocalVar("crits")

    if (critNum + 1) > mob:getLocalVar("CritToTheFace") then  -- Lose a head
        if mob:getAnimationSub() == 0 then
            mob:setAnimationSub(1)
            mob:setLocalVar("headTimer", os.time() + math.random(60, 190))
        elseif mob:getAnimationSub() == 1 then
            mob:setAnimationSub(2)
            mob:setLocalVar("headTimer", os.time() + math.random(60, 190))
        else
            -- Meh
        end

        -- Number of crits to lose a head, re-randoming
        mob:setLocalVar("CritToTheFace", math.random(10, 30))

        critNum = 0 -- reset the crits on the NM
    else
        critNum = critNum + 1
    end

    mob:setLocalVar("crits", critNum)
end

entity.onMobDrawIn = function(mob, target)
    mob:addTP(3000) -- Uses a mobskill upon drawing in a player. Not necessarily on the person drawn in.
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
