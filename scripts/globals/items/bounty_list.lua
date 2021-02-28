-----------------------------------------
-- ID: 6170
-- Item: Bounty List
-- A simple list of known criminals who are better off dead.
-- Every single name is crossed out in Azima's handwriting.
-- Adventurers note that reading it increases one's elemental magic skill. 
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, tpz.skill.ELEMENTAL_MAGIC)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, tpz.skill.ELEMENTAL_MAGIC)
end

return item_object
