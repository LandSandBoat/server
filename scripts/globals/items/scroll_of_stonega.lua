-----------------------------------
-- ID: 4797
-- Scroll of Stonega
-- Teaches the black magic Stonega
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(189)
end

item_object.onItemUse = function(target)
    target:addSpell(189)
end

return item_object
