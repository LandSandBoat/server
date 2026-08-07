-----------------------------------
-- ID: 14516
-- Item: Hydra Harness
-- Item Effect: Attack +25, Ranged Attack +25
-- Duration: 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.HYDRA_HARNESS) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_HARNESS)
        if effect then
            effect:resetStartTime()
            effect:setIcon(xi.effect.ATTACK_BOOST)
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 180, icon = xi.effect.ATTACK_BOOST, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.HYDRA_HARNESS, flag = xi.effectFlag.NO_LOSS_MESSAGE })
        end

        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.ATTACK_BOOST)
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.ATT, 25)
    effect:addMod(xi.mod.RATT, 25)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HYDRA_HARNESS)
end

itemObject.onEffectLose = function(target, effect)
    target:messageBasic(xi.msg.basic.STATUS_WEARS_OFF, xi.effect.ATTACK_BOOST)
end

return itemObject
