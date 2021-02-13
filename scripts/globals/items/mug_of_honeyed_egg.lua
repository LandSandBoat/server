-----------------------------------
-- ID: 5739
-- Item: mug_of_honeyed_egg
-- Food Effect: 30Min, All Races
-----------------------------------
-- MP 8
-- Intelligence 1
-- MP recovered while healing 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5739)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MP, 8)
    target:addMod(tpz.mod.INT, 1)
    target:addMod(tpz.mod.MPHEAL, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MP, 8)
    target:delMod(tpz.mod.INT, 1)
    target:delMod(tpz.mod.MPHEAL, 1)
end

return item_object
