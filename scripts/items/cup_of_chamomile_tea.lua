-----------------------------------
-- ID: 4603
-- Item: cup_of_chamomile_tea
-- Food Effect: 180Min, All Races
-----------------------------------
-- Magic 8
-- Vitality -2
-- Charisma 2
-- Magic Regen While Healing 1
-- Sleep resistance -30
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4603)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 8)
    target:addMod(xi.mod.VIT, -2)
    target:addMod(xi.mod.CHR, 2)
    target:addMod(xi.mod.MPHEAL, 1)
    target:addMod(xi.mod.SLEEPRES, -30)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 8)
    target:delMod(xi.mod.VIT, -2)
    target:delMod(xi.mod.CHR, 2)
    target:delMod(xi.mod.MPHEAL, 1)
    target:delMod(xi.mod.SLEEPRES, -30)
end

return itemObject
