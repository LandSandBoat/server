-----------------------------------------
-- ID: 4602
-- Item: warm_egg
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Health 18
-- Magic 18
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 4602)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 18)
    target:addMod(tpz.mod.MP, 18)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 18)
    target:delMod(tpz.mod.MP, 18)
end

return item_object
