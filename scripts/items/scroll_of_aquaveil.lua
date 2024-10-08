-----------------------------------
-- ID: 4663
-- Scroll of Aquaveil
-- Teaches the white magic Aquaveil
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.AQUAVEIL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AQUAVEIL)
end

return itemObject
