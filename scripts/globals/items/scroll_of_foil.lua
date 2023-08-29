-----------------------------------
-- ID: 5102
-- Scroll of Foil
-- Teaches the white magic Foil
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FOIL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FOIL)
end

return itemObject
