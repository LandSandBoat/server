-----------------------------------
-- ID: 6597
-- Item: Maat's Concoction
-- Grants 50 Job Points to the current job
-- https://www.bg-wiki.com/ffxi/Maat%27s_Concoction
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.jobPointItemOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.jobPointItemOnItemUse(target, 50)
end

return itemObject
