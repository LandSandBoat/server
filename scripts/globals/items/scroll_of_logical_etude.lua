-----------------------------------
-- ID: 5044
-- Scroll of Logical Etude
-- Teaches the song Logical Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(436)
end

itemObject.onItemUse = function(target)
    target:addSpell(436)
end

return itemObject
