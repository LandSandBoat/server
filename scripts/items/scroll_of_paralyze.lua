-----------------------------------
-- ID: 4666
-- Scroll of Paralyze
-- Teaches the white magic Paralyze
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.PARALYZE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.PARALYZE)
end

return itemObject
