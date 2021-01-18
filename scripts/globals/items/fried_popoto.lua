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
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6272)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 30)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.FIRERES, 20)
    target:addMod(tpz.mod.FOOD_DEFP, 20)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 145)
    target:addMod(tpz.mod.SUBTLE_BLOW, 8)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 30)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.FIRERES, 20)
    target:delMod(tpz.mod.FOOD_DEFP, 20)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 145)
    target:delMod(tpz.mod.SUBTLE_BLOW, 8)
end

return item_object
