-----------------------------------
-- ID: 4892
-- Scroll of Aeroja
-- Teaches the black magic Aeroja
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.AEROJA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AEROJA)
end

return itemObject
