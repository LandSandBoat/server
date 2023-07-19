-----------------------------------
-- ID: 4877
-- Scroll of Absorb-AGI
-- Teaches the black magic Absorb-AGI
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ABSORB_AGI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ABSORB_AGI)
end

return itemObject
