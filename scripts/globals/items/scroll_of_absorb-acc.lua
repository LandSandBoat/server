-----------------------------------
-- ID: 4886
-- Scroll of Absorb-ACC
-- Teaches the black magic Absorb-ACC
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(242)
end

itemObject.onItemUse = function(target)
    target:addSpell(242)
end

return itemObject
