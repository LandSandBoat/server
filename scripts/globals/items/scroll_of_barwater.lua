-----------------------------------
-- ID: 4673
-- Scroll of Barwater
-- Teaches the white magic Barwater
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARWATER)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARWATER)
end

return itemObject
