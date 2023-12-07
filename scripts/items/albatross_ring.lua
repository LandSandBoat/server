-----------------------------------
-- ID: 15552 and 15555
-- Albatross Ring
--  Enchantment: Increases stamina while fishing
-----------------------------------
local itemObject = {}

local itemMod = xi.mod.ALBATROSS_RING_EFFECT

itemObject.onItemCheck = function(target)
    if target:getMod(itemMod) > 0 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end

    return 0
end

itemObject.onItemUse = function(target, player, item)
    local effectType = xi.effect.ENCHANTMENT
    local itemId = item:getID()
    -- will not overwrite other enchantments due to effect and power being 0
    target:addStatusEffectEx(effectType, effectType, 0, 0, 1200, 0, itemId)
    for _, effect in pairs(target:getStatusEffects()) do
        if
            effect:getEffectType() == effectType and
            effect:getSubPower() == itemId
        then
            effect:addEffectFlag(xi.effectFlag.ON_ZONE)
            -- gives the player the mod, and stacks the mod to the effect so it is removed when the effect wears off
            effect:addMod(itemMod, 1)
            target:addMod(itemMod, 1)
        end
    end
end

itemObject.onItemUnequip = function(target, item)
    local effectType = xi.effect.ENCHANTMENT
    local itemId = item:getID()
    for _, effect in pairs(target:getStatusEffects()) do
        if
            effect:getEffectType() == effectType and
            effect:getSubPower() == itemId
        then
            effect:setDuration(1)
        end
    end
end

return itemObject
