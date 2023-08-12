-----------------------------------
-- ID: 4685
-- Scroll of Barpetrify
-- Teaches the white magic Barpetrify
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARPETRIFY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARPETRIFY)
end

return itemObject
