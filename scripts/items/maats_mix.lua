-----------------------------------
-- ID: 6598
-- Item: Maat's Mix
-- Grants 10 Job Points to the current job
-- https://www.bg-wiki.com/ffxi/Maat%27s_Mix
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.jobPointItemOnItemCheck(target)
end

itemObject.onItemUse = function(target, user, item, action)
    return xi.itemUtils.jobPointItemOnItemUse(target, 10, action)
end

return itemObject
