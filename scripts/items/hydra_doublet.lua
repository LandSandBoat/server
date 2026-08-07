-----------------------------------
-- ID: 14515
-- Item: Hydra Doublet
-- Item Effect: Refresh 3 MP/tick
-- Duration: 60 Seconds
-- Stacks with Refresh (spell)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.HYDRA_DOUBLET) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_DOUBLET)
        if effect then
            effect:resetStartTime()
            effect:setIcon(xi.effect.REFRESH)
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 60, icon = xi.effect.REFRESH, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.HYDRA_DOUBLET, flag = xi.effectFlag.NO_LOSS_MESSAGE })
        end

        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.REFRESH)
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.REFRESH, 3)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_DOUBLET)
end

itemObject.onEffectLose = function(target, effect)
    target:messageBasic(xi.msg.basic.STATUS_WEARS_OFF, xi.effect.REFRESH)
end

return itemObject
