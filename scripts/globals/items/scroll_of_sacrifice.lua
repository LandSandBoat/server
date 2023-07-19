-----------------------------------
-- ID: 4702
-- Scroll of Sacrifice
-- Teaches the white magic Sacrifice
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SACRIFICE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SACRIFICE)
end

return itemObject
