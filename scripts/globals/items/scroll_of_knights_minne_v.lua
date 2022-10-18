-----------------------------------
-- ID: 5001
-- Scroll of Knights Minne V
-- Teaches the song Mages Ballad V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(393)
end

itemObject.onItemUse = function(target)
    target:addSpell(393)
end

return itemObject
