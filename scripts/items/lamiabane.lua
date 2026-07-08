-----------------------------------
-- ID: 18693
-- Item: Lamiabane
-- Description : Adds 1/tick auto-refresh effect. Duration : 60 Minutes. Only able to be used in Mamook, Arrapago Reef, or Halvung. Effect lost upon zoning.
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
    if target:hasEquipped(xi.item.LAMIABANE) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 3600, origin = user, flag = xi.effectFlag.ON_ZONE, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.LAMIABANE })
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.REFRESH, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
