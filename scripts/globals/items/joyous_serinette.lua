-----------------------------------
-- ID: 5425
-- Item: Joyous Serinette
-- Item Effect: Change Music
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local alliance = target:getAlliance()
    for i, member in pairs(alliance) do
        if member:getZoneID() == target:getZoneID() then
            member:ChangeMusic(0, 214) -- Eternal Oath
            member:ChangeMusic(1, 214) -- Eternal Oath
        end
    end
end

return item_object
