-----------------------------------
-- ID: 14925
-- Item: Hydra Mittens
-- Item Effect: Accuracy +15, Ranged Accuracy +15
-- Duration: 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.HYDRA_MITTENS) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_MITTENS)
        if effect then
            effect:resetStartTime()
            effect:setIcon(xi.effect.ACCURACY_BOOST)
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 180, icon = xi.effect.ACCURACY_BOOST, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.HYDRA_MITTENS, flag = xi.effectFlag.NO_LOSS_MESSAGE })
        end

        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.ACCURACY_BOOST)
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.ACC, 15)
    effect:addMod(xi.mod.RACC, 15)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_MITTENS)
end

itemObject.onEffectLose = function(target, effect)
    target:messageBasic(xi.msg.basic.STATUS_WEARS_OFF, xi.effect.ACCURACY_BOOST)
end

return itemObject
