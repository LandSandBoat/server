-----------------------------------
-- ID: 5008
-- Scroll of Blade Madrigal
-- Teaches the song Blade Madrigal
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BLADE_MADRIGAL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLADE_MADRIGAL)
end

return itemObject
