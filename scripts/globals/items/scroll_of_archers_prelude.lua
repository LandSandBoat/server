-----------------------------------
-- ID: 5010
-- Scroll of Archers Prelude
-- Teaches the song Archers Prelude
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(402)
end

item_object.onItemUse = function(target)
    target:addSpell(402)
end

return item_object
