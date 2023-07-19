-----------------------------------
-- ID: 5087
-- Scroll of Gain-STR
-- Teaches the white magic Gain-STR
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.GAIN_STR)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.GAIN_STR)
end

return itemObject
