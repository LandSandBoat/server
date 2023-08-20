-----------------------------------
-- ID: 4696
-- Scroll of Barparalyzra
-- Teaches the white magic Barparalyzra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARPARALYZRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARPARALYZRA)
end

return itemObject
