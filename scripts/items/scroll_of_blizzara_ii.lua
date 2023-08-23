-----------------------------------
-- ID: 4919
-- Scroll of Blizzara II
-- Teaches the black magic Blizzara II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BLIZZARA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIZZARA_II)
end

return itemObject
