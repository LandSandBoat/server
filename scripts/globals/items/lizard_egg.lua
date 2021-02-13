-----------------------------------
-- ID: 4362
-- Item: lizard_egg
-- Food Effect: 5Min, All Races
-----------------------------------
-- Health 5
-- Magic 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 4362)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 5)
    target:addMod(tpz.mod.MP, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 5)
    target:delMod(tpz.mod.MP, 5)
end

return item_object
