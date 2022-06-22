-----------------------------------
-- ID: 4923
-- Scroll of Stonera II
-- Teaches the black magic Stonera II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.STONERA_II)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STONERA_II)
end

return item_object
