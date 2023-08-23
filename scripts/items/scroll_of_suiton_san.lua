-----------------------------------
-- ID: 4945
-- Scroll of Suiton: San
-- Teaches the ninjutsu Suiton: San
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SUITON_SAN)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SUITON_SAN)
end

return itemObject
