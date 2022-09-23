-----------------------------------
-- ID: 15486
-- Item: Breath Mantle
-- Item Effect: HP+18 / Enmity+3
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if (effect ~= nil) then
        if (effect:getSubType() == 15486) then
            target:delStatusEffect(xi.effect.ENCHANTMENT)
        end
    end
    return 0
end

item_object.onItemUse = function(target)
    if (target:hasStatusEffect(xi.effect.ENCHANTMENT) == true) then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 15486)
    else
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 15486)
    end
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 18)
    target:addMod(xi.mod.ENMITY, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 18)
    target:delMod(xi.mod.ENMITY, 3)
end

return item_object
