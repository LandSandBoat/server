-----------------------------------
-- ID: 15486
-- Item: Breath Mantle
-- Item Effect: HP+18 / Enmity+3
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil then
        if effect:getItemSourceID() == xi.items.BREATH_MANTLE then
            target:delStatusEffect(xi.effect.ENCHANTMENT)
        end
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasStatusEffect(xi.effect.ENCHANTMENT) then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.items.BREATH_MANTLE)
    else
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.items.BREATH_MANTLE)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 18)
    target:addMod(xi.mod.ENMITY, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 18)
    target:delMod(xi.mod.ENMITY, 3)
end

return itemObject
