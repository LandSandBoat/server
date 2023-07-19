-----------------------------------
-- ID: 4965
-- Scroll of Aisha: Ichi
-- Teaches the ninjutsu Aisha: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.AISHA_ICHI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AISHA_ICHI)
end

return itemObject
