-----------------------------------
-- ID: 14788
-- Item: Gamushara Earring
-- Item Effect: Attack +22
-- Duration: 3 Minutes
-- https://wiki.ffo.jp/html/10068.html
-- TODO: Capture Icon
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.GAMUSHARA_EARRING) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.GAMUSHARA_EARRING)
        if effect then
            effect:resetStartTime()
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 180, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.GAMUSHARA_EARRING })
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.ATT, 22)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.GAMUSHARA_EARRING)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
