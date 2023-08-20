-----------------------------------------
-- ID: 6174
-- Item: Beaming Score
-- A musical score composed by Lewenhart.
-- Its notes symbolize the gently glowing beams of light that filter through the leaves of a deciduous tree in the late afternoon.
-- Adventurers note that reading it increases one's wind instrument skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.WIND_INSTRUMENT)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.WIND_INSTRUMENT)
end

return itemObject
