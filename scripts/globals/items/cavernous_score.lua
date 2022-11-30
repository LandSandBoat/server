-----------------------------------------
-- ID: 6173
-- Item: Cavernous Score
-- A musical score composed by Lewenhart.
-- Its notes symbolize the damp and musty air that stagnates within an underground cave.
-- Adventurers note that reading it increases one's string instrument skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.STRING_INSTRUMENT)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.STRING_INSTRUMENT)
end

return itemObject
