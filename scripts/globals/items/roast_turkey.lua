-----------------------------------
-- ID: 5620
-- Item: roast_turkey
-- Food Effect: 240Min, All Races
-----------------------------------
-- Strength 4
-- Vitality 4
-- hMP +2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5620)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 4)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.HPHEAL, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 4)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.HPHEAL, 2)
end

return item_object
