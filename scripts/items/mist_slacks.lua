-----------------------------------
-- ID: 14324
-- Item: Mist Slacks
-- Item Effect: Evasion Boost
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.EVASION_BOOST, xi.effectSourceType.EQUIPPED_ITEM, xi.item.MIST_SLACKS) ~= nil then
        target:delStatusEffect(xi.effect.EVASION_BOOST, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.MIST_SLACKS)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.MIST_SLACKS) then
        if not target:hasStatusEffect(xi.effect.EVASION_BOOST) then
            target:addStatusEffect(xi.effect.EVASION_BOOST, 0, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.MIST_SLACKS)
        else
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.EVA, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
