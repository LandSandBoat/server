-----------------------------------
-- ID: 5048
-- Scroll of Wind Carol
-- Teaches the song Wind Carol
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WIND_CAROL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WIND_CAROL)
end

return itemObject
