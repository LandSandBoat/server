-----------------------------------
-- ID: 5093
-- Scroll of Gain-CHR
-- Teaches the white magic Gain-CHR
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.GAIN_CHR)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.GAIN_CHR)
end

return itemObject
