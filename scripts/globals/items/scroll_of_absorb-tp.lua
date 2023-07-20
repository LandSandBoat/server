-----------------------------------
-- ID: 4883
-- Scroll of Absorb-TP
-- Teaches the black magic Absorb-TP
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ABSORB_TP)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ABSORB_TP)
end

return itemObject
