-----------------------------------
-- ID: 5030
-- Scroll of Carnage Elegy
-- Teaches the song Carnage Elegy
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(422)
end

itemObject.onItemUse = function(target)
    target:addSpell(422)
end

return itemObject
