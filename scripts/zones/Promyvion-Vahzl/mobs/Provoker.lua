-----------------------------------
-- Area: Promyvion - Vahzl
--   NM: Provoker
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobInitialize(mob)
    mob:addMod(tpz.mod.ACC, 50)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobFight(mob, target)

    local changeTime = mob:getLocalVar("changeTime")
    local element = mob:getLocalVar("element")

    if changeTime == 0 then
        mob:setLocalVar("changeTime", math.random(2, 3)*15)
        return
    end
    if mob:getBattleTime() >= changeTime then
        local newElement = element
        while newElement == element do
            newElement = math.random(1, 8)
        end
        if element ~= 0 then
            mob:delMod(tpz.magic.absorbMod[element], 100)
        end

        mob:useMobAbility(624)
        mob:addMod(tpz.magic.absorbMod[newElement], 100)
        mob:setLocalVar("changeTime", mob:getBattleTime() + math.random(2, 3)*15)
        mob:setLocalVar("element", newElement)
    end
end

function onAdditionalEffect(mob, target, damage)
    local element = mob:getLocalVar("element")
    local index =
    {
        [1] = tpz.mob.ae.ENFIRE,
        [2] = tpz.mob.ae.ENSTONE,
        [3] = tpz.mob.ae.ENWATER,
        [4] = tpz.mob.ae.ENAERO,
        [5] = tpz.mob.ae.ENBLIZZARD,
        [6] = tpz.mob.ae.ENTHUNDER,
        [7] = tpz.mob.ae.ENLIGHT,
        [8] = tpz.mob.ae.ENDARK
    }
    if index[element] then
        return tpz.mob.onAddEffect(mob, target, damage, index[element], {chance = 1000})
    else
        return 0, 0, 0 -- Just in case its somehow not got a variable set
    end
end

function onMobDeath(mob, player, isKiller)
end
