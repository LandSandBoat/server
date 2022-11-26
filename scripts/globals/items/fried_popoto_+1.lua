-----------------------------------
-- ID: 6273
-- Item: fried_popoto_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP +35
-- VIT +3
-- Fire resistance +21
-- DEF +21% (cap 150)
-- Subtle Blow +9
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 6273)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 35)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.FIRE_MEVA, 21)
    target:addMod(xi.mod.FOOD_DEFP, 21)
    target:addMod(xi.mod.FOOD_DEF_CAP, 150)
    target:addMod(xi.mod.SUBTLE_BLOW, 9)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 35)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.FIRE_MEVA, 21)
    target:delMod(xi.mod.FOOD_DEFP, 21)
    target:delMod(xi.mod.FOOD_DEF_CAP, 150)
    target:delMod(xi.mod.SUBTLE_BLOW, 9)
end

return itemObject
