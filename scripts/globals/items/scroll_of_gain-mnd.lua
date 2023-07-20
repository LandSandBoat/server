-----------------------------------
-- ID: 5092
-- Scroll of Gain-MND
-- Teaches the white magic Gain-MND
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.GAIN_MND)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.GAIN_MND)
end

return itemObject
