-----------------------------------
-- ID: 4629
-- Scroll of Holy
-- Teaches the white magic Holy
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.HOLY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HOLY)
end

return itemObject
