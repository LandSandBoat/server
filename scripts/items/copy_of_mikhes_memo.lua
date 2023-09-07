-----------------------------------
-- ID: 6147
-- Item: Mikhe's Memo
-- A memo scrawled by Mikhe Aryohcha that matter-of-factly states,
-- "Just throw your fist at your opponent and it'll all work out."
-- Adventurers say that their hand-to-hand skill increases after reading this note.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.HAND_TO_HAND)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.HAND_TO_HAND)
end

return itemObject
