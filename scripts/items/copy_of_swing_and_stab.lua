-----------------------------------------
-- ID: 6149
-- Item: Swing and Stab
-- Ulla wrote this guide on sword wielding
-- from how to grip the hilt to tips on footwork
-- so others could follow in her footsteps.
-- Adventurers note that reading it increases one's sword skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.SWORD)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.SWORD)
end

return itemObject
