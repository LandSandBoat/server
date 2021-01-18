-----------------------------------
-- ID: 5629
-- Item: Orange Cake
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP Recovered while healing +3
-- MP Recovered while healing +4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5629)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HPHEAL, 3)
    target:addMod(tpz.mod.MPHEAL, 4)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HPHEAL, 3)
    target:delMod(tpz.mod.MPHEAL, 4)
end

return item_object
