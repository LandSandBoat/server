-----------------------------------
-- ID: 4863
-- Scroll of Break
-- Teaches the black magic Break
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BREAK)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BREAK)
end

return itemObject
