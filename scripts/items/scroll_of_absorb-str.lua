-----------------------------------
-- ID: 4874
-- Scroll of Absorb-STR
-- Teaches the black magic Absorb-STR
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ABSORB_STR)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ABSORB_STR)
end

return itemObject
