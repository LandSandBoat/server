-----------------------------------
-- ID: 4878
-- Scroll of Absorb-INT
-- Teaches the black magic Absorb-INT
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ABSORB_INT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ABSORB_INT)
end

return itemObject
