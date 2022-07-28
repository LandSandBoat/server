-----------------------------------
-- ID: 4925
-- Scroll of Thundara II
-- Teaches the black magic Thundara II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.THUNDARA_II)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDARA_II)
end

return item_object
