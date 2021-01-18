-----------------------------------
-- ID: 18402
-- Item: mana_wand
-- Item Effect: MPHEAL +2
-- Duration: 30 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 18402 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 1800, 18402)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MPHEAL, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MPHEAL, 2)
end

return item_object
