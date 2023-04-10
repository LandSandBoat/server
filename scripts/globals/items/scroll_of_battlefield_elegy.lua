-----------------------------------
-- ID: 5029
-- Scroll of Battlefield Elegy
-- Teaches the song Battlefield Elegy
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(421)
end

itemObject.onItemUse = function(target)
    target:addSpell(421)
end

return itemObject
