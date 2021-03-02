-----------------------------------------
-- ID: 6154
-- Item: Clash of Titans
-- An article detailing the duel between Yrvaulair S Cousseraux
-- and Alphonimile M Aurchiat that became all the rage in San d'Oria after appearing in a popular newspaper.
-- Adventurers note that reading it increases one's polearm skill.  
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, tpz.skill.POLEARM)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, tpz.skill.POLEARM)
end

return item_object
