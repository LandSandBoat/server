-----------------------------------------
-- ID: 6158
-- Item: K-P's Memoirs
-- Memoirs penned by Kayeel-Payeel. 
-- They describe in particular detail the time he received Claustrum from the Warlock Warlord Robel-Akbel. 
-- Adventurers note that reading them increases one's staff skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, tpz.skill.STAFF)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, tpz.skill.STAFF)
end

return item_object
