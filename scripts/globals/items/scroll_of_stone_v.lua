-----------------------------------
-- ID: 4771
-- Scroll of Stone V
-- Teaches the black magic Stone V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.STONE_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STONE_V)
end

return itemObject
