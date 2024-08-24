-----------------------------------
-- ID: 4673
-- Scroll of Barwater
-- Teaches the white magic Barwater
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BARWATER)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARWATER)
end

return itemObject
