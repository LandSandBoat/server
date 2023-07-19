-----------------------------------
-- ID: 4875
-- Scroll of Absorb-DEX
-- Teaches the black magic Absorb-DEX
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ABSORB_DEX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ABSORB_DEX)
end

return itemObject
