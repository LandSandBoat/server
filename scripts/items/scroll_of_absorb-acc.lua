-----------------------------------
-- ID: 4886
-- Scroll of Absorb-ACC
-- Teaches the black magic Absorb-ACC
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ABSORB_ACC)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ABSORB_ACC)
end

return itemObject
