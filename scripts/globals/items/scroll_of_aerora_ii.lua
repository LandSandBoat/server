-----------------------------------
-- ID: 4921
-- Scroll of Aerora II
-- Teaches the black magic Aerora II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.AERA_II)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AERA_II)
end

return item_object
