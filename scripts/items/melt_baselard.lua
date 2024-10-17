-----------------------------------
-- ID: 18012
-- Item: Melt Baselard
-- Item Effect: DEFENSE DOWN
-- Duration:
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target)
    -- TODO: Implement https://discord.com/channels/443544205206355968/446400612582555658/1080960539519369329
    return 0
end

itemObject.onItemUse = function(target)
end

return itemObject
