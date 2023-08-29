-----------------------------------
-- ID: 4620
-- Scroll of Raise
-- Teaches the white magic Raise
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.RAISE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RAISE)
end

return itemObject
