-----------------------------------------
-- ID: 6148
-- Item: Dagger enchiridion
-- A guide to the finer points of wielding a dagger,
-- written by an anonymous individual.
-- Adventurers note that reading it increases one's dagger skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.DAGGER)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.DAGGER)
end

return itemObject
