-----------------------------------
-- ID: 5027
-- Scroll of Advancing March
-- Teaches the song Advancing March
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ADVANCING_MARCH)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ADVANCING_MARCH)
end

return itemObject
