-----------------------------------
-- ID: 4872
-- Scroll of Tractor
-- Teaches the black magic Tractor
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.TRACTOR)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.TRACTOR)
end

return itemObject
