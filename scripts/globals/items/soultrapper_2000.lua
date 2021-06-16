-----------------------------------
-- Soultrapper (18721)
-----------------------------------
require("scripts/globals/znm")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target, user)
    return xi.znm.soultrapper.onItemCheck(target, user)
end

item_object.onItemUse = function(target, user)
    xi.znm.soultrapper.onItemUse(target, user)
end 

return item_object
