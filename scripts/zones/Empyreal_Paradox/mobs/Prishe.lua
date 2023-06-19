-----------------------------------
-- Area: Empyreal Paradox
--  Mob: Prishe
-- Chains of Promathia 8-4 BCNM Fight
-----------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 30)
    mob:setMobMod(xi.mobMod.NO_REST, 1)
    mob:addListener('RAISE_RECEIVED', 'PRISHE_RAISE_RECEIVED', function(target, raiseLevel)
        target:setLocalVar("Raise", 1)
        target:entityAnimationPacket("sp00")
        target:addHP(target:getMaxHP())
        target:addMP(target:getMaxMP())
        target:disengage()
        target:resetAI()
    end)
end

entity.onMobSpawn = function(mob)
end

entity.onMobRoam = function(mob)
    -- Need to multiply getArea by 2 due to the two Promathia versions
    local promathia = ID.mob.PROMATHIA_OFFSET + (mob:getBattlefield():getArea() * 2)
    if not GetMobByID(promathia):isAlive() then
        promathia = promathia + 1
    end

    local wait = mob:getLocalVar("wait")
    local ready = mob:getLocalVar("ready")

    if ready == 0 and wait > 240 then
        if GetMobByID(promathia):getCurrentAction() ~= xi.act.NONE then
            mob:entityAnimationPacket("prov")
            mob:messageText(mob, ID.text.PRISHE_TEXT)
        else
            mob:entityAnimationPacket("prov")
            mob:messageText(mob, ID.text.PRISHE_TEXT + 1)
            promathia = promathia + 1
        end

        mob:setLocalVar("ready", promathia)
        mob:setLocalVar("wait", 0)
    elseif ready > 0 then
        mob:addEnmity(GetMobByID(ready), 0, 1)
    else
        mob:setLocalVar("wait", wait + 3)
    end
end

entity.onMobEngaged = function(mob, target)
    mob:addStatusEffectEx(xi.effect.SILENCE, 0, 0, 0, 5)
    mob:timer(4000, function(prishe)
        prishe:useMobAbility(1487)
    end)
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar("Raise") == 1 then
        mob:setAnimationSub(1)
        mob:messageText(mob, ID.text.PRISHE_TEXT + 3)
        mob:setLocalVar("Raise", 0)
        mob:stun(3000)
    elseif mob:getHPP() < 70 and mob:getLocalVar("HF") == 0 then
        mob:useMobAbility(xi.jsa.HUNDRED_FISTS_PRISHE)
        mob:messageText(mob, ID.text.PRISHE_TEXT + 6)
        mob:setLocalVar("HF", 1)
    elseif mob:getHPP() < 30 and mob:getLocalVar("Bene") == 0 then
        mob:useMobAbility(xi.jsa.BENEDICTION_PRISHE)
        mob:messageText(mob, ID.text.PRISHE_TEXT + 7)
        mob:setLocalVar("Bene", 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    mob:messageText(mob, ID.text.PRISHE_TEXT + 2)
end

return entity
