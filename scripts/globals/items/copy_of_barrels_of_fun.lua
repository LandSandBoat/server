-----------------------------------------
-- ID: 6160
-- Item: Barrels of Fun
-- An educational text authored by Elivira Gogol.
-- It discusses how to dismantle, clean, and reconstruct firearms in careful detail.
-- Adventurers note that reading it increases one's marksmanship skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.MARKSMANSHIP)
end

item_object.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.MARKSMANSHIP)
end

return item_object
