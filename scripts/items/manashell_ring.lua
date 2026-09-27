-----------------------------------
-- ID: 15782
-- Item: Manashell Ring
-- Item Effect: MP +9
-- Duration: 30 Minutes
-- https://wiki.ffo.jp/html/9657.html
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user, item, action, equipSlotID)
    if equipSlotID then
        local effect = target:getStatusEffect(xi.effect.ENCHANTMENT, equipSlotID)

        if
            effect and
            effect:getSourceType() == xi.effectSourceType.EQUIPPED_ITEM and
            effect:getSourceTypeParam() == xi.item.MANASHELL_RING
        then
            effect:resetStartTime()
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 1800, origin = user, subType = equipSlotID, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.MANASHELL_RING })
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MP, 9)
end

itemObject.onItemUnequip = function(target, item, equipSlotID)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT, equipSlotID)

    if
        effect and
        effect:getSourceType() == xi.effectSourceType.EQUIPPED_ITEM and
        effect:getSourceTypeParam() == xi.item.MANASHELL_RING
    then
        target:delStatusEffect(xi.effect.ENCHANTMENT, equipSlotID)
    end
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
