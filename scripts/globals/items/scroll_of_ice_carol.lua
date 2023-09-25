-----------------------------------
-- ID: 5047
-- Scroll of Ice Carol
-- Teaches the song Ice Carol
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ICE_CAROL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ICE_CAROL)
end

return itemObject
