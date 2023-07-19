-----------------------------------
-- ID: 4686
-- Scroll of Barvirus
-- Teaches the white magic Barvirus
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARVIRUS)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARVIRUS)
end

return itemObject
