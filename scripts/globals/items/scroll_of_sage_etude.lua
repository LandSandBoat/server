-----------------------------------
-- ID: 5043
-- Scroll of Sage Etude
-- Teaches the song Sage Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(435)
end

itemObject.onItemUse = function(target)
    target:addSpell(435)
end

return itemObject
