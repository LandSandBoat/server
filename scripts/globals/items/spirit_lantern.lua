-----------------------------------
-- ID: 18240
-- Item: Spirit Lantern
-- Item Effect: Magic Damage +10%
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getItemSourceID() == xi.items.SPIRIT_LANTERN then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.SPIRIT_LANTERN)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MAGIC_DAMAGE, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MAGIC_DAMAGE, 10)
end

return itemObject
