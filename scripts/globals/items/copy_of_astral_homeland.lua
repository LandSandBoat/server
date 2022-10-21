-----------------------------------------
-- ID: 6176
-- Item: Astral Homeland
-- A specious work written by an unknown individual that both reads and feels like an illusion from the ancient past.
-- It discusses the world avatars inhabit, but seems too absurd to be true.
-- Adventurers note that reading it increases one's summoning magic skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.SUMMONING_MAGIC)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.SUMMONING_MAGIC)
end

return itemObject
