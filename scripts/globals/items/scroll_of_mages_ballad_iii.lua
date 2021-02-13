-----------------------------------
-- ID: 4996
-- Scroll of Mages Ballad III
-- Teaches the song Mages Ballad III
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(388)
end

item_object.onItemUse = function(target)
    target:addSpell(388)
end

return item_object
