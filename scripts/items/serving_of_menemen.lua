-----------------------------------
-- ID: 5586
-- Item: serving_of_menemen
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- HP 30
-- MP 30
-- Agility 1
-- Intelligence -1
-- HP recovered while healing 1
-- MP recovered while healing 1
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5586)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 30)
    target:addMod(xi.mod.MP, 30)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.INT, -1)
    target:addMod(xi.mod.HPHEAL, 1)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 30)
    target:delMod(xi.mod.MP, 30)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.INT, -1)
    target:delMod(xi.mod.HPHEAL, 1)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
