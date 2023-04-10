-----------------------------------
-- ID: 5042
-- Scroll of Swift Etude
-- Teaches the song Swift Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(434)
end

itemObject.onItemUse = function(target)
    target:addSpell(434)
end

return itemObject
