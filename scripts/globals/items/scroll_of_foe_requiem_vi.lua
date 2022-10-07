-----------------------------------
-- ID: 4981
-- Scroll of Foe Requiem VI
-- Teaches the song Foe Requiem VI
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(373)
end

itemObject.onItemUse = function(target)
    target:addSpell(373)
end

return itemObject
