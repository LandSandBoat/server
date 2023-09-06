-----------------------------------
-- ID: 4368
-- Two-Leaf Mandragora Bud
--  5 Minutes, food effect, All Races
-----------------------------------
-- Agility  +2
-- Vitality -4
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4368)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.VIT, -4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.VIT, -4)
end

return itemObject
