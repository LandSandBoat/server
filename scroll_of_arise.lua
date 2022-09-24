-----------------------------------
-- ID: 5101
-- Scroll of Arise
-- Teaches the white magic Arise
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ARISE)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ARISE)
end

return item_object
