-----------------------------------
-- ID: 4919
-- Scroll of Blizzara II
-- Teaches the black magic Blizzara II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BLIZZARA_II)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIZZARA_II)
end

return item_object
