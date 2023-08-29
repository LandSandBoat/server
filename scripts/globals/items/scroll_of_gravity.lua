-----------------------------------
-- ID: 4824
-- Scroll of Gravity
-- Teaches the black magic Gravity
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.GRAVITY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.GRAVITY)
end

return itemObject
