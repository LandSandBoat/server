-----------------------------------
-- ID: 5587
-- Item: serving_of_menemen_+1
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- HP 35
-- MP 35
-- Agility 2
-- Intelligence -2
-- HP recovered while healing 2
-- MP recovered while healing 2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5587)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 35)
    target:addMod(xi.mod.MP, 35)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.INT, -2)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.MPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 35)
    target:delMod(xi.mod.MP, 35)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.INT, -2)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.MPHEAL, 2)
end

return itemObject
