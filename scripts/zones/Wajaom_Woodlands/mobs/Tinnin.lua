-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Tinnin
-- !pos 276 0 -694 51
-- Spawned with Monkey Wine: !additem 2573
-----------------------------------
mixins ={require("scripts/mixins/job_special"),
require("scripts/mixins/rage")}
require("scripts/globals/magic")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.ATT, -50)
    mob:addMod(xi.mod.MDEF, 20)
    mob:addMod(xi.mod.VIT, 10)
    mob:addMod(xi.mod.INT, 20)
    mob:addMod(xi.mod.MND, 20)
    mob:addMod(xi.mod.CHR, 20)
    mob:addMod(xi.mod.AGI, 20)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.DARK_MEVA, 250)
    mob:setMod(xi.mod.LIGHT_MEVA, 128)
    mob:setMod(xi.mod.FIRE_MEVA, 170)
    mob:setMod(xi.mod.WATER_MEVA, 250)
    mob:setMod(xi.mod.ICE_MEVA, 200)
    mob:setMod(xi.mod.WIND_MEVA, 170)
    mob:setMod(xi.mod.DARK_SDT, 250)
    mob:setMod(xi.mod.LIGHT_SDT, 128)
    mob:setMod(xi.mod.FIRE_SDT, 170)
    mob:setMod(xi.mod.WATER_SDT, 250)
    mob:setMod(xi.mod.ICE_SDT, 200)
    mob:setMod(xi.mod.WIND_SDT, 170)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:setMod(xi.mod.WATER_ABSORB, 100)
    mob:setMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.GRAVITYRES, 10000)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.LULLABYRES, 10000)
    mob:setMod(xi.mod.FASTCAST, 10)
    mob:addStatusEffect(xi.effect.REGAIN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 50, 3, 0)
    mob:addMod(xi.mod.MOVE, 12)
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
    mob:setMod(xi.mod.REGEN, 50, 3, 0)
    -- Mighty Strikes
      xi.mix.jobSpecial.config(mob, {
        specials ={{id = xi.jsa.MIGHTY_STRIKES, cooldown = 120, hpp = 100},}})

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
