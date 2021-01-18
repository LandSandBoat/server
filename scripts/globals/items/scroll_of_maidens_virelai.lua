-----------------------------------
-- ID: 5074
-- Scroll of Maiden's Virelai
-- Teaches the song Maiden's Virelai
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(466)
end

item_object.onItemUse = function(target)
    target:addSpell(466)
end

return item_object
