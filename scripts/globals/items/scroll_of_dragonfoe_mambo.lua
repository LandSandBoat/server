-----------------------------------
-- ID: 5012
-- Scroll of Dragonfoe Mambo
-- Teaches the song Dragonfoe Mambo
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.DRAGONFOE_MAMBO)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DRAGONFOE_MAMBO)
end

return itemObject
