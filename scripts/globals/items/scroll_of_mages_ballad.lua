-----------------------------------
-- ID: 4994
-- Scroll of Mages Ballad
-- Teaches the song Mages Ballad
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(386)
end

item_object.onItemUse = function(target)
    target:addSpell(386)
end

return item_object
