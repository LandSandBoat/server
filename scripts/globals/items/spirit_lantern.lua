-----------------------------------
-- ID: 18240
-- Item: Spirit Lantern
-- Item Effect: Magic Damage +10%
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 18240 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 18240)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MAGIC_DAMAGE, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MAGIC_DAMAGE, 10)
end

return item_object
