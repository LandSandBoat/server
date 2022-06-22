-----------------------------------
-- ID: 4918
-- Scroll of Blizzara
-- Teaches the black magic Blizzara
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BLIZZARA)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIZZARA)
end

return item_object
