-----------------------------------
-- ID: 5106
-- Scroll of Inundation
-- Teaches the white Inundation
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INUNDATION)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INUNDATION)
end

return item_object
