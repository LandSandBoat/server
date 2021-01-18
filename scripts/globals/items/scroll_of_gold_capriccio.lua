-----------------------------------
-- ID: 5020
-- Scroll of Gold Capriccio
-- Teaches the song Gold Capriccio
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(412)
end

item_object.onItemUse = function(target)
    target:addSpell(412)
end

return item_object
