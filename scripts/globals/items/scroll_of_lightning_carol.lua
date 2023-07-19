-----------------------------------
-- ID: 5050
-- Scroll of Lightning Carol
-- Teaches the song Lightning Carol
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.LIGHTNING_CAROL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.LIGHTNING_CAROL)
end

return itemObject
