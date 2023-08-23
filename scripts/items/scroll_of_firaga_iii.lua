-----------------------------------
-- ID: 4784
-- Scroll of Firaga III
-- Teaches the black magic Firaga III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FIRAGA_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRAGA_III)
end

return itemObject
