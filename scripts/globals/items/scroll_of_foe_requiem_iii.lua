-----------------------------------
-- ID: 4978
-- Scroll of Foe Requiem III
-- Teaches the song Foe Requiem III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(370)
end

itemObject.onItemUse = function(target)
    target:addSpell(370)
end

return itemObject
