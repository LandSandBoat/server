-----------------------------------
-- ID: 4979
-- Scroll of Foe Requiem IV
-- Teaches the song Foe Requiem IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(371)
end

itemObject.onItemUse = function(target)
    target:addSpell(371)
end

return itemObject
