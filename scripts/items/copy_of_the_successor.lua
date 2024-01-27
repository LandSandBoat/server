-----------------------------------
-- ID: 6164
-- Item: The Successor
-- An essay authored by Cerane I Virgaut,
-- mainly concerning the night Perseus bequeathed unto her an exemplary shield.
-- Adventurers note that reading it increases one's shield skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.SHIELD)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.SHIELD)
end

return itemObject
