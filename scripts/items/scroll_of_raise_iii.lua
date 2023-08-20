-----------------------------------
-- ID: 4748
-- Scroll of Raise II
-- Teaches the white magic Raise III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.RAISE_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RAISE_III)
end

return itemObject
