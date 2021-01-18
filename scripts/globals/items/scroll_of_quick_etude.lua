-----------------------------------
-- ID: 5035
-- Scroll of Quick Etude
-- Teaches the song Quick Etude
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(427)
end

item_object.onItemUse = function(target)
    target:addSpell(427)
end

return item_object
