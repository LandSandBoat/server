-----------------------------------
-- ID: 6272
-- Item: fried_popoto
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +30
-- VIT +2
-- Fire resistance +20
-- DEF +20% (cap 145)
-- Subtle Blow +8
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6272)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 30)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.FIRE_MEVA, 20)
    target:addMod(xi.mod.FOOD_DEFP, 20)
    target:addMod(xi.mod.FOOD_DEF_CAP, 145)
    target:addMod(xi.mod.SUBTLE_BLOW, 8)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 30)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.FIRE_MEVA, 20)
    target:delMod(xi.mod.FOOD_DEFP, 20)
    target:delMod(xi.mod.FOOD_DEF_CAP, 145)
    target:delMod(xi.mod.SUBTLE_BLOW, 8)
end

return itemObject
