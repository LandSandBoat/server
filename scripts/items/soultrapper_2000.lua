-----------------------------------
-- Soultrapper (18721)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.znm.soultrapper.onItemCheck(target, item, param, caster)
end

itemObject.onItemUse = function(target, user, item, action)
    xi.znm.soultrapper.onItemUse(target, user, item)
end

return itemObject
