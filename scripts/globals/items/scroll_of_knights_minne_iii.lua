-----------------------------------
-- ID: 4999
-- Scroll of Knights Minne III
-- Teaches the song Mages Ballad III
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(391)
end

item_object.onItemUse = function(target)
    target:addSpell(391)
end

return item_object
