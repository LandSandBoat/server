-----------------------------------
-- ID: 12406
-- Item: Coated Shield
-- Item Effect: Shell
-- Duration : 3 Minutes
-- Stacks with Shell (Spell)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.COATED_SHIELD) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.COATED_SHIELD)
        if effect then
            effect:resetStartTime()
            effect:setIcon(xi.effect.SHELL)
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 180, icon = xi.effect.SHELL, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.COATED_SHIELD, flag = xi.effectFlag.NO_LOSS_MESSAGE })
        end

        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.SHELL)
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DMGMAGIC, -1055) -- Equivalent to Shell I
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.COATED_SHIELD)
end

itemObject.onEffectLose = function(target, effect)
    target:messageBasic(xi.msg.basic.STATUS_WEARS_OFF, xi.effect.SHELL)
end

return itemObject
