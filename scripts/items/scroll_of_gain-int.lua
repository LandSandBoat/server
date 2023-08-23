-----------------------------------
-- ID: 5091
-- Scroll of Gain-INT
-- Teaches the white magic Gain-INT
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.GAIN_INT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.GAIN_INT)
end

return itemObject
