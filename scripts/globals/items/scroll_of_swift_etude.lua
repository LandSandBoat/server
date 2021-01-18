-----------------------------------
-- ID: 5042
-- Scroll of Swift Etude
-- Teaches the song Swift Etude
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(434)
end

item_object.onItemUse = function(target)
    target:addSpell(434)
end

return item_object
