-----------------------------------
-- ID: 4927
-- Scroll of Watera II
-- Teaches the black magic Watera II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WATERA_II)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATERA_II)
end

return item_object
