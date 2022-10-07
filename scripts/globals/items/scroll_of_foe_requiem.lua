-----------------------------------
-- ID: 4976
-- Scroll of Foe Requiem
-- Teaches the song Foe Requiem
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(368)
end

itemObject.onItemUse = function(target)
    target:addSpell(368)
end

return itemObject
