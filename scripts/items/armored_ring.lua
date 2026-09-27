-----------------------------------
-- ID: 15783
-- Item: Armored Ring
-- Item Effect: Defence +8
-- Duration 30 Minutes
-- https://wiki.ffo.jp/html/9580.html
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
            effect:getSourceTypeParam() == xi.item.ARMORED_RING
        then
            effect:resetStartTime()
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 1800, origin = user, subType = equipSlotID, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.ARMORED_RING })
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEF, 8)
end

itemObject.onItemUnequip = function(target, item, equipSlotID)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT, equipSlotID)

    if
        effect and
        effect:getSourceType() == xi.effectSourceType.EQUIPPED_ITEM and
        effect:getSourceTypeParam() == xi.item.ARMORED_RING
    then
        target:delStatusEffect(xi.effect.ENCHANTMENT, equipSlotID)
    end
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
