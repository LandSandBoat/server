-----------------------------------
-- ID: 5089
-- Scroll of Gain-VIT
-- Teaches the white magic Gain-VIT
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.GAIN_VIT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.GAIN_VIT)
end

return itemObject
