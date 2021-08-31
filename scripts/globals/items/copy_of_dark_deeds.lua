-----------------------------------------
-- ID: 6171
-- Item: Dark Deeds
-- A guide to the finer points of insidious dark magic, as compiled by Azima.
-- Proceeds from this tome have gone to fund her various purchases dealing with alchemical research.
-- Adventurers note that reading it increases one's dark magic skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, xi.skill.DARK_MAGIC)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, xi.skill.DARK_MAGIC)
end

return item_object
