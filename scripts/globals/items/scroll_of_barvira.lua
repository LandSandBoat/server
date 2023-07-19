-----------------------------------
-- ID: 4700
-- Scroll of Barvira
-- Teaches the white magic Barvira
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARVIRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARVIRA)
end

return itemObject
