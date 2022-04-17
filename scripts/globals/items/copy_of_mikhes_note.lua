-----------------------------------------
-- ID: 6162
-- Item: Mikhe's Note
-- A memo scrawled by Mikhe Aryohcha that matter-of-factly states,
-- "Just throw your guard up and it'll all work out."
-- Adventurers note that reading it increases one's guarding skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.GUARD)
end

item_object.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.GUARD)
end

return item_object
