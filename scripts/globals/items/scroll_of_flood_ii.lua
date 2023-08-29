-----------------------------------
-- ID: 4823
-- Scroll of Flood II
-- Teaches the black magic Flood II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FLOOD_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FLOOD_II)
end

return itemObject
