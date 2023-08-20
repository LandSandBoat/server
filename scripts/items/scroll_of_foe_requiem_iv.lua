-----------------------------------
-- ID: 4979
-- Scroll of Foe Requiem IV
-- Teaches the song Foe Requiem IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FOE_REQUIEM_IV)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FOE_REQUIEM_IV)
end

return itemObject
