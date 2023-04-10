-----------------------------------
-- Soultrapper (18721)
-----------------------------------
require("scripts/globals/znm")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, user)
    return xi.znm.soultrapper.onItemCheck(target, user)
end

itemObject.onItemUse = function(target, user, item)
    xi.znm.soultrapper.onItemUse(target, user, item)
end

return itemObject
