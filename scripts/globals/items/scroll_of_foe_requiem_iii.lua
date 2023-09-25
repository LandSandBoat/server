-----------------------------------
-- ID: 4978
-- Scroll of Foe Requiem III
-- Teaches the song Foe Requiem III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FOE_REQUIEM_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FOE_REQUIEM_III)
end

return itemObject
