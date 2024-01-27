-----------------------------------
-- ID: 5563
-- Item: Chunk of Orobon Meat
-- Effect: 5 Minutes, food effect, Galka Only
-----------------------------------
-- HP 10
-- MP -10
-- Strength +6
-- Intelligence -8
-- Demon Killer 10
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.RAW_MEAT)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5563)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 10)
    target:addMod(xi.mod.MP, -10)
    target:addMod(xi.mod.STR, 6)
    target:addMod(xi.mod.INT, -8)
    target:addMod(xi.mod.DEMON_KILLER, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 10)
    target:delMod(xi.mod.MP, -10)
    target:delMod(xi.mod.STR, 6)
    target:delMod(xi.mod.INT, -8)
    target:delMod(xi.mod.DEMON_KILLER, 10)
end

return itemObject
