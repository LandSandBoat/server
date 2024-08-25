-----------------------------------
-- ID: 4621
-- Scroll of Raise II
-- Teaches the white magic Raise II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.RAISE_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RAISE_II)
end

return itemObject
