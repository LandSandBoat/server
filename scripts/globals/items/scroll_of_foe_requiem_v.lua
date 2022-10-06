-----------------------------------
-- ID: 4980
-- Scroll of Foe Requiem V
-- Teaches the song Foe Requiem V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(372)
end

itemObject.onItemUse = function(target)
    target:addSpell(372)
end

return itemObject
