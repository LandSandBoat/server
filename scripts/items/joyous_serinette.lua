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
    local alliance = target:getAlliance()
    for i, member in pairs(alliance) do
        if member:getZoneID() == target:getZoneID() then
            member:changeMusic(xi.musicSlot.ZONE_DAY, 214)   -- Eternal Oath
            member:changeMusic(xi.musicSlot.ZONE_NIGHT, 214) -- Eternal Oath
        end
    end
end

return itemObject
