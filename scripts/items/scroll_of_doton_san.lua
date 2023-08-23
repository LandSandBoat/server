-----------------------------------
-- ID: 4939
-- Scroll of Doton: San
-- Teaches the ninjutsu Doton: San
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.DOTON_SAN)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DOTON_SAN)
end

return itemObject
