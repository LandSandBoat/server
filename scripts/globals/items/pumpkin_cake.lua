-----------------------------------------
-- ID: 5631
-- Item: Pumpkin Cake
-- Food Effect: 3 Hrs, All Races
-----------------------------------------
-- TODO: Group Effect
-- HP Recovered while healing +2
-- MP Recovered while healing +5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5631)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HPHEAL, 2)
    target:addMod(tpz.mod.MPHEAL, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HPHEAL, 2)
    target:delMod(tpz.mod.MPHEAL, 5)
end

return item_object
