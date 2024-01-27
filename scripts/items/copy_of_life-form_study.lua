-----------------------------------
-- ID: 6177
-- Item: Life-form Study
-- A report written and filed by an anonymous individual.
-- It covers the behavioral patterns and diets of almost every known family of beasts in existence.
-- Adventurers note that reading it increases one's blue magic skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.BLUE_MAGIC)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.BLUE_MAGIC)
end

return itemObject
