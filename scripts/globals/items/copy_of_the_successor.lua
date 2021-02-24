-----------------------------------------
-- ID: 6164
-- Item: The Successor
-- An essay authored by Cerane I Virgaut,
-- mainly concerning the night Perseus bequeathed unto her an exemplary shield.
-- Adventurers note that reading it increases one's shield skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, tpz.skill.SHIELD)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, tpz.skill.SHIELD)
end

return item_object
