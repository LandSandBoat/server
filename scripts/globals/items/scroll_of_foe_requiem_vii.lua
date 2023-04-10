-----------------------------------
-- ID: 4982
-- Scroll of Foe Requiem VII
-- Teaches the song Foe Requiem VII
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(374)
end

itemObject.onItemUse = function(target)
    target:addSpell(374)
end

return itemObject
