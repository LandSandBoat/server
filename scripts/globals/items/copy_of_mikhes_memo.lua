-----------------------------------------
-- ID: 6147
-- Item: Mikhe's Memo
-- A memo scrawled by Mikhe Aryohcha that matter-of-factly states,
-- "Just throw your fist at your opponent and it'll all work out."
-- Adventurers say that their hand-to-hand skill increases after reading this note.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.HAND_TO_HAND)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.HAND_TO_HAND)
end

return itemObject
