-----------------------------------------
-- ID: 5919
-- Item: Choco-ligar
-- Food Effect: 3 Min, All Races
-----------------------------------------
-- Vitality 1
-- Speed 12.5%
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 180, 5919)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.MOVE, 13)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.MOVE, 13)
end

return item_object
