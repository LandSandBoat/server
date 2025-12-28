-----------------------------------
-- ID: 26517
-- Item: Shadow Lord Shirt
-- Teleports user to Castle Zvahl Keep
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    -- Need retail verification: Is having set foot in the zone a requirement?
    if not target:hasVisitedZone(xi.zone.CASTLE_ZVAHL_KEEP) then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end

    return result
end

itemObject.onItemUse = function(target)
    -- May need a retail capture to verify actual position
    -- https://ffxiclopedia.fandom.com/wiki/Shadow_Lord_Shirt states teleports next to HP#1
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.ZVAHL_KEEP, 0, 4)
end

return itemObject
