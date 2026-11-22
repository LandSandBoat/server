-----------------------------------
-- ID: 5424
-- Item: Serene Serinette
-- Item Effect: Change Music
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local zoneId = target:getZoneID()
    local prelude = 153

    for _, member in ipairs(target:getAlliance()) do
        if member:getZoneID() == zoneId then
            member:changeMusic(xi.musicSlot.ZONE_DAY, prelude)
            member:changeMusic(xi.musicSlot.ZONE_NIGHT, prelude)
            member:changeMusic(xi.musicSlot.COMBAT_SOLO, prelude)
            member:changeMusic(xi.musicSlot.COMBAT_PARTY, prelude)
        end
    end
end

return itemObject
