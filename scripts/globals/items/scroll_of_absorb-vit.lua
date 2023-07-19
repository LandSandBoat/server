-----------------------------------
-- ID: 4876
-- Scroll of Absorb-VIT
-- Teaches the black magic Absorb-VIT
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ABSORB_VIT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ABSORB_VIT)
end

return itemObject
