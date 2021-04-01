-----------------------------------------
-- ID: 6176
-- Item: Astral Homeland
-- A specious work written by an unknown individual that both reads and feels like an illusion from the ancient past.
-- It discusses the world avatars inhabit, but seems too absurd to be true.
-- Adventurers note that reading it increases one's summoning magic skill. 
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, xi.skill.SUMMONING_MAGIC)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, xi.skill.SUMMONING_MAGIC)
end

return item_object
