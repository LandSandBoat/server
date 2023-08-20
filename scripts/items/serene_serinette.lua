-----------------------------------
-- ID: 5424
-- Item: Serene Serinette
-- Item Effect: Change Music
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local alliance = target:getAlliance()
    for i, member in pairs(alliance) do
        if member:getZoneID() == target:getZoneID() then
            member:changeMusic(0, 153) -- Prelude
            member:changeMusic(1, 153) -- Prelude
        end
    end
end

return itemObject
