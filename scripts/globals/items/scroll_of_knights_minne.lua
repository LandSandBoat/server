-----------------------------------------
-- ID: 4997
-- Scroll of Knights Minne
-- Teaches the song Mages Ballad
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(389)
end

item_object.onItemUse = function(target)
    target:addSpell(389)
end

return item_object
