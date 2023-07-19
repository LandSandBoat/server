-----------------------------------
-- ID: 4746
-- Scroll of Deodorize
-- Teaches the white magic Deodorize
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.DEODORIZE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DEODORIZE)
end

return itemObject
