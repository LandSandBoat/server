-----------------------------------
-- ID: 4664
-- Scroll of Slow
-- Teaches the white magic Slow
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SLOW)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SLOW)
end

return itemObject
