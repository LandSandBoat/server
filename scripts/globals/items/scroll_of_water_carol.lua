-----------------------------------
-- ID: 5051
-- Scroll of Water Carol
-- Teaches the song Water Carol
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WATER_CAROL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATER_CAROL)
end

return itemObject
