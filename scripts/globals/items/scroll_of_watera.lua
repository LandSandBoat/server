-----------------------------------
-- ID: 4926
-- Scroll of Watera
-- Teaches the black magic Watera
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WATERA)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATERA)
end

return item_object
