-----------------------------------
-- ID: 5035
-- Scroll of Quick Etude
-- Teaches the song Quick Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(427)
end

itemObject.onItemUse = function(target)
    target:addSpell(427)
end

return itemObject
