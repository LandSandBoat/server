-----------------------------------------
-- ID: 5037
-- Scroll of Spirited Etude
-- Teaches the song Spirited Etude
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(429)
end

item_object.onItemUse = function(target)
    target:addSpell(429)
end

return item_object
