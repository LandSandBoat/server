-----------------------------------
-- ID: 18694
-- Item: Trollbane
-- Item Effect: Enchantment: VIT +10
-- Duration: 60 Minutes
-- Only usable in Arrapago Reef, Halvung, or Mamook. Effect lost upon zoning or unequipping.
-- https://wiki.ffo.jp/html/4400.html
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    local zoneId = target:getZoneID()

    if
        zoneId == xi.zone.ARRAPAGO_REEF or
        zoneId == xi.zone.HALVUNG or
        zoneId == xi.zone.MAMOOK
    then
        return 0
    else
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    end
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.TROLLBANE) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 3600, origin = user, flag = xi.effectFlag.ON_ZONE, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.TROLLBANE })
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.VIT, 10)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.TROLLBANE)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
