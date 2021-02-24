-----------------------------------------
-- ID: 6175
-- Item: Yomi's Diagram
-- A meticulously drawn diagram Yomi made for Kagetora explaining how to construct certain ninja tools.
-- Adventurers note that reading it increases one's ninjutsu skill. 
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, tpz.skill.NINJUTSU)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, tpz.skill.NINJUTSU)
end

return item_object
