-----------------------------------
-- ID: 18216
-- Item: twicer
-- Item Effect: DOUBLE_ATTACK 100%
-- Duration: 30 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.TWICER) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.TWICER)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.TWICER) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 30, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.TWICER)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DOUBLE_ATTACK, 100)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DOUBLE_ATTACK, 100)
end

return itemObject
