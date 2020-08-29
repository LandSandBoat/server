-----------------------------------
-- Area: Promyvion - Vahzl
--   NM: Provoker
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobInitialize(mob)
    mob:addMod(tpz.mod.DOUBLE_ATTACK, 25)
    mob:addMod(tpz.mod.ACC, 50)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobFight(mob, target)

    local changeTime = mob:getLocalVar("changeTime")
    local element = mob:getLocalVar("element")

    if (changeTime == 0) then
        mob:setLocalVar("changeTime", math.random(2, 3)*15)
        return
    end
    if (mob:getBattleTime() >= changeTime) then
        local newelement = element
        while (newelement == element) do
            newelement = math.random(1, 8)
        end
        if (element ~= 0) then
            mob:delMod(tpz.magic.absorbMod[element], 100)
        end

        mob:useMobAbility(624)
        mob:addMod(tpz.magic.absorbMod[newelement], 100)
        mob:setLocalVar("changeTime", mob:getBattleTime() + math.random(2, 3)*15)
        mob:setLocalVar("element", newelement)
    end
end

function onAdditionalEffect(mob, target, damage)

    local element = mob:getLocalVar("element")

    if (element ~= 0) then
        if (element == 1) then
            return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENFIRE, {chance = 1000})
        elseif (element == 2) then
            return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENSTONE, {chance = 1000})
        elseif (element == 3) then
            return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENWATER, {chance = 1000})
        elseif (element == 4) then
            return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENAERO, {chance = 1000})
        elseif (element == 5) then
            return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENBLIZZARD, {chance = 1000})
        elseif (element == 6) then
            return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENTHUNDER, {chance = 1000})
        elseif (element == 7) then
            return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENLIGHT, {chance = 1000})
        elseif (element == 8) then
            return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENDARK, {chance = 1000})
        end
    end
end

function onMobDeath(mob, player, isKiller)
end
