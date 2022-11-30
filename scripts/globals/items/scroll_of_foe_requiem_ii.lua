-----------------------------------
-- ID: 4977
-- Scroll of Foe Requiem II
-- Teaches the song Foe Requiem II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(369)
end

itemObject.onItemUse = function(target)
    target:addSpell(369)
end

return itemObject
