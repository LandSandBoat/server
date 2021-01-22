-----------------------------------
-- ID: 5718
-- Item: Cream Puff
-- Food Effect: 30 mintutes, All Races
-----------------------------------
-- Intelligence +7
-- HP -10
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
   target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5718)
end

item_object.onEffectGain = function(target, effect)
   target:addMod(tpz.mod.INT, 7)
   target:addMod(tpz.mod.HP, -10)
end

item_object.onEffectLose = function(target, effect)
   target:delMod(tpz.mod.INT, 7)
   target:delMod(tpz.mod.HP, -10)
end

return item_object
