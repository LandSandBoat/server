-----------------------------------
-- ID: 4524
-- Item: pot_of_royal_tea
-- Food Effect: 240Min, All Races
-----------------------------------
-- Vitality -1
-- Charisma 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4524)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.CHR, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.CHR, 3)
end

return item_object
