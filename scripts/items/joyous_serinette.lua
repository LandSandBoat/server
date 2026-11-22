-----------------------------------
-- ID: 5425
-- Item: Joyous Serinette
-- Item Effect: Change Music
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local zoneId = target:getZoneID()
    local eternalOath = 214

    for _, member in ipairs(target:getAlliance()) do
        if member:getZoneID() == zoneId then
            member:changeMusic(xi.musicSlot.ZONE_DAY, eternalOath)
            member:changeMusic(xi.musicSlot.ZONE_NIGHT, eternalOath)
            member:changeMusic(xi.musicSlot.COMBAT_SOLO, eternalOath)
            member:changeMusic(xi.musicSlot.COMBAT_PARTY, eternalOath)
        end
    end
end

return itemObject
