-----------------------------------
-- ID: 6148
-- Item: Dagger enchiridion
-- A guide to the finer points of wielding a dagger,
-- written by an anonymous individual.
-- Adventurers note that reading it increases one's dagger skill.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.skillBookCheck(target, xi.skill.DAGGER)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.DAGGER)
end

return itemObject
