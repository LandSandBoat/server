-----------------------------------
-- ID: 5088
-- Scroll of Gain-DEX
-- Teaches the white magic Gain-DEX
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.GAIN_DEX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.GAIN_DEX)
end

return itemObject
