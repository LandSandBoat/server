-----------------------------------
-- ID: 4755
-- Scroll of Fire IV
-- Teaches the black magic Fire IV
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(147)
end

item_object.onItemUse = function(target)
    target:addSpell(147)
end

return item_object
