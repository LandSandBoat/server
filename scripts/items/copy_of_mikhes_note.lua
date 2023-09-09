-----------------------------------
-- ID: 6162
-- Item: Mikhe's Note
-- A memo scrawled by Mikhe Aryohcha that matter-of-factly states,
-- "Just throw your guard up and it'll all work out."
-- Adventurers note that reading it increases one's guarding skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.GUARD)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.GUARD)
end

return itemObject
