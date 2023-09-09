-----------------------------------
-- ID: 6167
-- Item: Coveffe Musings
-- A collection of thoughts scribbled out by Ferreous Coffin on his visit to Coveffe Barrows.
-- Adventurers note that reading it increases one's healing magic skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.HEALING_MAGIC)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.HEALING_MAGIC)
end

return itemObject
