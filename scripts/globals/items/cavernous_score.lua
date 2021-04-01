-----------------------------------------
-- ID: 6173
-- Item: Cavernous Score
-- A musical score composed by Lewenhart.
-- Its notes symbolize the damp and musty air that stagnates within an underground cave.
-- Adventurers note that reading it increases one's string instrument skill.  
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, xi.skill.STRING_INSTRUMENT)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, xi.skill.STRING_INSTRUMENT)
end

return item_object
