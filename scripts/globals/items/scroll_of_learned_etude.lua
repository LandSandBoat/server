-----------------------------------
-- ID: 5036
-- Scroll of Learned Etude
-- Teaches the song Learned Etude
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(428)
end

item_object.onItemUse = function(target)
    target:addSpell(428)
end

return item_object
