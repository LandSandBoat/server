-----------------------------------
-- ID: 6171
-- Item: Dark Deeds
-- A guide to the finer points of insidious dark magic, as compiled by Azima.
-- Proceeds from this tome have gone to fund her various purchases dealing with alchemical research.
-- Adventurers note that reading it increases one's dark magic skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.DARK_MAGIC)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.DARK_MAGIC)
end

return itemObject
