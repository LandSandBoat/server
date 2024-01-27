-----------------------------------
-- ID: 5934
-- Item: Chocobiscuit
-- Food Effect: 3Min, All Races
-----------------------------------
-- Magic Regen While Healing 3
-- Charisma 3
-- Evasion 2
-- Aquan Killer 10
-- Silence Resist 10
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 5934)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPHEAL, 3)
    target:addMod(xi.mod.CHR, 3)
    target:addMod(xi.mod.EVA, 2)
    target:addMod(xi.mod.AQUAN_KILLER, 10)
    target:addMod(xi.mod.SILENCERES, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPHEAL, 3)
    target:delMod(xi.mod.CHR, 3)
    target:delMod(xi.mod.EVA, 2)
    target:delMod(xi.mod.AQUAN_KILLER, 10)
    target:delMod(xi.mod.SILENCERES, 10)
end

return itemObject
