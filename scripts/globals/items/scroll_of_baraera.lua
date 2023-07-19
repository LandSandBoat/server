-----------------------------------
-- ID: 4676
-- Scroll of Baraera
-- Teaches the white magic Baraera
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARAERA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARAERA)
end

return itemObject
