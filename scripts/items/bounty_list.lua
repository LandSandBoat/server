-----------------------------------
-- ID: 6170
-- Item: Bounty List
-- A simple list of known criminals who are better off dead.
-- Every single name is crossed out in Azima's handwriting.
-- Adventurers note that reading it increases one's elemental magic skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.ELEMENTAL_MAGIC)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.ELEMENTAL_MAGIC)
end

return itemObject
