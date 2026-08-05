-----------------------------------
-- ID: 15261
-- Item: Hydra Tiara
-- Item Effect: Crit Rate +7% **Needs validation**
-- Duration: 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.HYDRA_TIARA) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_TIARA)
        if effect then
            effect:resetStartTime()
            effect:setIcon(xi.effect.POTENCY)
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 180, icon = xi.effect.POTENCY, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.HYDRA_TIARA, flag = xi.effectFlag.NO_LOSS_MESSAGE })
        end

        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.POTENCY)
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.CRITHITRATE, 7)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_TIARA)
end

itemObject.onEffectLose = function(target, effect)
    target:messageBasic(xi.msg.basic.STATUS_WEARS_OFF, xi.effect.POTENCY)
end

return itemObject
