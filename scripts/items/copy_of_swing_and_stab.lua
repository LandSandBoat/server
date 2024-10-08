-----------------------------------
-- ID: 6149
-- Item: Swing and Stab
-- Ulla wrote this guide on sword wielding
-- from how to grip the hilt to tips on footwork
-- so others could follow in her footsteps.
-- Adventurers note that reading it increases one's sword skill.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.skillBookCheck(target, xi.skill.SWORD)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.SWORD)
end

return itemObject
