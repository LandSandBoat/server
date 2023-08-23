-----------------------------------
-- ID: 5425
-- Item: Joyous Serinette
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
            member:changeMusic(0, 214) -- Eternal Oath
            member:changeMusic(1, 214) -- Eternal Oath
        end
    end
end

return itemObject
