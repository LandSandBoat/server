-----------------------------------
-- ID: 4681
-- Scroll of Barpoison
-- Teaches the white magic Barpoison
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARPOISON)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARPOISON)
end

return itemObject
