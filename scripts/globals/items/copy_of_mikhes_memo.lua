-----------------------------------------
-- ID: 6147
-- Item: Mikhe's Memo
-- A memo scrawled by Mikhe Aryohcha that matter-of-factly states, 
-- "Just throw your fist at your opponent and it'll all work out."
-- Adventurers say that their hand-to-hand skill increases after reading this note. 
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, xi.skill.HAND_TO_HAND)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, xi.skill.HAND_TO_HAND)
end

return item_object
