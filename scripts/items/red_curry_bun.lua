-----------------------------------
-- ID: 5759
-- Item: red_curry_bun
-- Food Effect: 30 Min, All Races
-----------------------------------
-- TODO: Group effects
-- Health 25
-- Strength 7
-- Agility 1
-- Intelligence -2
-- Attack % 23 (cap 150)
-- Ranged Atk % 23 (cap 150)
-- Demon Killer 4
-- Resist Sleep +3
-- HP recovered when healing +2
-- MP recovered when healing +1
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5759)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 25)
    target:addMod(xi.mod.STR, 7)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.INT, -2)
    target:addMod(xi.mod.FOOD_ATTP, 23)
    target:addMod(xi.mod.FOOD_ATT_CAP, 150)
    target:addMod(xi.mod.FOOD_RATTP, 23)
    target:addMod(xi.mod.FOOD_RATT_CAP, 150)
    target:addMod(xi.mod.DEMON_KILLER, 4)
    target:addMod(xi.mod.SLEEPRES, 3)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 25)
    target:delMod(xi.mod.STR, 7)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.INT, -2)
    target:delMod(xi.mod.FOOD_ATTP, 23)
    target:delMod(xi.mod.FOOD_ATT_CAP, 150)
    target:delMod(xi.mod.FOOD_RATTP, 23)
    target:delMod(xi.mod.FOOD_RATT_CAP, 150)
    target:delMod(xi.mod.DEMON_KILLER, 4)
    target:delMod(xi.mod.SLEEPRES, 3)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
