-----------------------------------------
-- ID: 5763
-- Item: yellow_curry_bun_+1
-- Food Effect: 60 min, All Races
-----------------------------------------
-- TODO: Group effects
-- Health Points 30
-- Strength 5
-- Vitality 2
-- Agility 3
-- Intelligence -2
-- Attack 22% (caps @ 85)
-- Ranged Attack 22% (caps @ 85)
-- Resist Sleep +5
-- Resist Stun +6
-- hHP +6
-- hMP +3
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5763)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 30)
    target:addMod(tpz.mod.STR, 5)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.INT, -2)
    target:addMod(tpz.mod.FOOD_ATTP, 22)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 85)
    target:addMod(tpz.mod.FOOD_RATTP, 22)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 85)
    target:addMod(tpz.mod.SLEEPRES, 5)
    target:addMod(tpz.mod.STUNRES, 6)
    target:addMod(tpz.mod.HPHEAL, 6)
    target:addMod(tpz.mod.MPHEAL, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 30)
    target:delMod(tpz.mod.STR, 5)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.INT, -2)
    target:delMod(tpz.mod.FOOD_ATTP, 22)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 85)
    target:delMod(tpz.mod.FOOD_RATTP, 22)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 85)
    target:delMod(tpz.mod.SLEEPRES, 5)
    target:delMod(tpz.mod.STUNRES, 6)
    target:delMod(tpz.mod.HPHEAL, 6)
    target:delMod(tpz.mod.MPHEAL, 3)
end
