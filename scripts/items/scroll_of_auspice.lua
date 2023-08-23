-----------------------------------
-- ID: 4704
-- Scroll of Auspice
-- Teaches the white magic Auspice
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.AUSPICE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AUSPICE)
end

return itemObject
