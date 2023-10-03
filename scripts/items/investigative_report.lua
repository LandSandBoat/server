-----------------------------------
-- ID: 6169
-- Item: Inv. Report
-- A collection of observations made by Rainemard on a particular exploration.
-- It goes into such detail on so much minutiae that many admit to never finishing it.
-- Adventurers note that reading it increases one's enfeebling magic skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.ENFEEBLING_MAGIC)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.ENFEEBLING_MAGIC)
end

return itemObject
