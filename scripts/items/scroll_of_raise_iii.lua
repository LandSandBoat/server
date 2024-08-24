-----------------------------------
-- ID: 4748
-- Scroll of Raise II
-- Teaches the white magic Raise III
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.RAISE_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RAISE_III)
end

return itemObject
