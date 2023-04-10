-----------------------------------
-- ID: 4997
-- Scroll of Knights Minne
-- Teaches the song Mages Ballad
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(389)
end

itemObject.onItemUse = function(target)
    target:addSpell(389)
end

return itemObject
