-----------------------------------
-- ID: 4976
-- Scroll of Foe Requiem
-- Teaches the song Foe Requiem
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FOE_REQUIEM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FOE_REQUIEM)
end

return itemObject
