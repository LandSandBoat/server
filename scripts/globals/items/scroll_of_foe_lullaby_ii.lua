-----------------------------------
-- ID: 5079
-- Scroll of Foe Lullaby II
-- Teaches the song Foe Lullaby II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FOE_LULLABY_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FOE_LULLABY_II)
end

return itemObject
