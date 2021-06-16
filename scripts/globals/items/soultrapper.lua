-----------------------------------
-- Soultrapper (18724)
-----------------------------------
require("scripts/globals/znm")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target, user)
    return xi.znm.soultrapper.onItemCheck(target, user)
end

item_object.onItemUse = function(target, user, item)
    xi.znm.soultrapper.onItemUse(target, user, item)
end 

return item_object
