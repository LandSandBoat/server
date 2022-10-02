-----------------------------------
-- ID: 4920
-- Scroll of Aerora
-- Teaches the black magic Aerora
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.AERA)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AERA)
end

return item_object
