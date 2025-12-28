-----------------------------------
-- ID: 15861
-- Item: deductive_brocade_obi
-- Item Effect: MND+10
-- Duration: 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.MND_BOOST, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DEDUCTIVE_BROCADE_OBI) ~= nil then
        target:delStatusEffect(xi.effect.MND_BOOST, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DEDUCTIVE_BROCADE_OBI)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.DEDUCTIVE_BROCADE_OBI) then
        target:addStatusEffect(xi.effect.MND_BOOST, 0, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.DEDUCTIVE_BROCADE_OBI)
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MND, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
