-----------------------------------
-- ID: 4369
-- Item: four-leaf_mandragora_bud
-- Food Effect: 60Min, All Races
-----------------------------------
-- Agility 3
-- Vitality -5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4369)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.VIT, -5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.VIT, -5)
end

return item_object
