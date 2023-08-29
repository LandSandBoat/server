-----------------------------------
-- ID: 5028
-- Scroll of Victory March
-- Teaches the song Victory March
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.VICTORY_MARCH)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.VICTORY_MARCH)
end

return itemObject
