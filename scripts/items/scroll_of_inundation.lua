-----------------------------------
-- ID: 5106
-- Scroll of Inundation
-- Teaches the white Inundation
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INUNDATION)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INUNDATION)
end

return itemObject
