-----------------------------------
-- ID: 4977
-- Scroll of Foe Requiem II
-- Teaches the song Foe Requiem II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FOE_REQUIEM_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FOE_REQUIEM_II)
end

return itemObject
