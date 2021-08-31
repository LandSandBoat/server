-----------------------------------
-- ID: 5044
-- Scroll of Logical Etude
-- Teaches the song Logical Etude
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(436)
end

item_object.onItemUse = function(target)
    target:addSpell(436)
end

return item_object
