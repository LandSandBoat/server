-----------------------------------
-- ID: 5045
-- Scroll of Bewitching Etude
-- Teaches the song Bewitching Etude
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(437)
end

item_object.onItemUse = function(target)
    target:addSpell(437)
end

return item_object
