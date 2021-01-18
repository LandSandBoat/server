-----------------------------------
-- ID: 4995
-- Scroll of Mages Ballad II
-- Teaches the song Mages Ballad II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(387)
end

item_object.onItemUse = function(target)
    target:addSpell(387)
end

return item_object
