-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Toadbolster
-- BCNM: Toadal Recall
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.BINDRES, 50)
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setLocalVar("tpskill", math.random(15, 30))
    mob:setLocalVar("capreset", 120)
end

entity.onMobEngaged = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobFight = function(mob, target)
    local tpskill = mob:getLocalVar("tpskill")
    local capreset = mob:getLocalVar("capreset")
    local wait = mob:getLocalVar("wait")
    local caps = mob:getLocalVar("caps")
    local reset = mob:getLocalVar("reset")

    if wait >= tpskill and mob:checkDistance(mob:getTarget()) <= 8 then
        if mob:getAnimationSub() == 0 or mob:getAnimationSub() == 4 and caps == 0 then
            mob:useMobAbility(310)
            mob:setLocalVar("tpskill", math.random(15, 30))
            wait = 0
            mob:setLocalVar("caps", 1)
        elseif mob:getAnimationSub() == 1 then
            mob:useMobAbility(311)
            mob:setLocalVar("tpskill", math.random(15, 30))
            wait = 0
            mob:setLocalVar("caps", 2)
        elseif mob:getAnimationSub() == 2 then
            mob:useMobAbility(312)
            mob:setLocalVar("tpskill", 100)
            wait = 0
            mob:setLocalVar("caps", 3)
        end
    else
        mob:setLocalVar("wait", wait+1)
    end

    if mob:getLocalVar("caps") == 3 and wait >= capreset and reset == 0 then
        mob:setLocalVar("caps", 0)
        mob:timer(1000 , function(mobArg) mobArg:setAnimationSub(4) end)
        mob:useMobAbility(626)
        mob:setLocalVar("reset", 1)
        mob:setLocalVar("tpskill", math.random(15, 30))
        mob:setLocalVar("wait", 0)
    else
        mob:setLocalVar("wait", wait+1)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
