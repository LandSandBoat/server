-----------------------------------
-- ID: 5090
-- Scroll of Gain-AGI
-- Teaches the white magic Gain-AGI
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.GAIN_AGI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.GAIN_AGI)
end

return itemObject
