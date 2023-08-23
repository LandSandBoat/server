-----------------------------------
-- ID: 4980
-- Scroll of Foe Requiem V
-- Teaches the song Foe Requiem V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FOE_REQUIEM_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FOE_REQUIEM_V)
end

return itemObject
