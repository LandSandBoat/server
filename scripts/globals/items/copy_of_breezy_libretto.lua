-----------------------------------------
-- ID: 6172
-- Item: Breezy Libretto
-- A musical score composed by Lewenhart.
-- Its notes symbolize a fragrant, early morning summer breeze.
-- Adventurers note that reading it increases one's singing skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.SINGING)
end

item_object.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.SINGING)
end

return item_object
