-----------------------------------
-- ID: 5052
-- Scroll of Light Carol
-- Teaches the song Light Carol
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.LIGHT_CAROL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.LIGHT_CAROL)
end

return itemObject
