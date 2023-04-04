-----------------------------------
-- ID: 15487
-- Item: High Breath Mantle
-- Item Effect: HP+38 / Enmity+5
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.HIGH_BREATH_MANTLE) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.HIGH_BREATH_MANTLE)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.HIGH_BREATH_MANTLE) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.items.HIGH_BREATH_MANTLE)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 38)
    target:addMod(xi.mod.ENMITY, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 38)
    target:delMod(xi.mod.ENMITY, 5)
end

return itemObject
