-----------------------------------
-- ID: 5007
-- Scroll of Sword Madrigal
-- Teaches the song Sword Madrigal
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SWORD_MADRIGAL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SWORD_MADRIGAL)
end

return itemObject
