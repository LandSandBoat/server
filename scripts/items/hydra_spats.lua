-----------------------------------
-- ID: 15681
-- Item: Hydra Spats
-- Item Effect: Evasion +15
-- Duration: 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.HYDRA_SPATS) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_SPATS)
        if effect then
            effect:resetStartTime()
            effect:setIcon(xi.effect.EVASION_BOOST)
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 180, icon = xi.effect.EVASION_BOOST, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.HYDRA_SPATS, flag = xi.effectFlag.NO_LOSS_MESSAGE })
        end

        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.EVASION_BOOST)
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.EVA, 15)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_SPATS)
end

itemObject.onEffectLose = function(target, effect)
    target:messageBasic(xi.msg.basic.STATUS_WEARS_OFF, xi.effect.EVASION_BOOST)
end

return itemObject
