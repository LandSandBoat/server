-----------------------------------
-- ID: 4779
-- Scroll of Water III
-- Teaches the black magic Water III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WATER_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATER_III)
end

return itemObject
