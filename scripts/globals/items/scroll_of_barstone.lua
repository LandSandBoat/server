-----------------------------------
-- ID: 4671
-- Scroll of Barstone
-- Teaches the white magic Barstone
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARSTONE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARSTONE)
end

return itemObject
