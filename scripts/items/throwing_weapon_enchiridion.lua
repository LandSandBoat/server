-----------------------------------
-- ID: 6161
-- Item: T.W. Enchiridion
-- A guide to the finer points of hurling projectile objects at opponents,
-- written by an anonymous individual.
-- Adventurers note that reading it increases one's throwing skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.THROWING)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.THROWING)
end

return itemObject
