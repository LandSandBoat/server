-----------------------------------
-- ID: 4663
-- Scroll of Aquaveil
-- Teaches the white magic Aquaveil
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.AQUAVEIL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AQUAVEIL)
end

return itemObject
