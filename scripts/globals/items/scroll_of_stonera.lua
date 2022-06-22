-----------------------------------
-- ID: 4922
-- Scroll of Stonera
-- Teaches the black magic Stonera
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.STONERA)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STONERA)
end

return item_object
