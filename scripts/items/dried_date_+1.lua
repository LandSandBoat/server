-----------------------------------
-- ID: 5574
-- Item: dried_date_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 12
-- Magic 22
-- Agility -1
-- Intelligence 4
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5574)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 12)
    target:addMod(xi.mod.MP, 22)
    target:addMod(xi.mod.AGI, -1)
    target:addMod(xi.mod.INT, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 12)
    target:delMod(xi.mod.MP, 22)
    target:delMod(xi.mod.AGI, -1)
    target:delMod(xi.mod.INT, 4)
end

return itemObject
