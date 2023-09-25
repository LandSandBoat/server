-----------------------------------
-- ID: 4754
-- Scroll of Fire III
-- Teaches the black magic Fire III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FIRE_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRE_III)
end

return itemObject
