-----------------------------------
-- ID: 4271
-- Item: rice_dumpling
-- Food Effect: 30minutes, All Races
-----------------------------------
-- HP 17
-- Strength 3
-- Vitality 2
-- Agility 1
-- Attack 20% (caps @ 45)
-- Ranged Attack 30% (caps @ 45)
-- HP Regeneration While Healing 2
-- MP Regeneration While Healing 2
-- Accuracy 5
-- Resist Paralyze +4
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4271)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 17)
    target:addMod(xi.mod.STR, 3)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.FOOD_ATTP, 20)
    target:addMod(xi.mod.FOOD_ATT_CAP, 45)
    target:addMod(xi.mod.FOOD_RATTP, 30)
    target:addMod(xi.mod.FOOD_RATT_CAP, 45)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.MPHEAL, 2)
    target:addMod(xi.mod.ACC, 5)
    target:addMod(xi.mod.PARALYZERES, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 17)
    target:delMod(xi.mod.STR, 3)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.FOOD_ATTP, 20)
    target:delMod(xi.mod.FOOD_ATT_CAP, 45)
    target:delMod(xi.mod.FOOD_RATTP, 30)
    target:delMod(xi.mod.FOOD_RATT_CAP, 45)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.MPHEAL, 2)
    target:delMod(xi.mod.ACC, 5)
    target:delMod(xi.mod.PARALYZERES, 4)
end

return itemObject
