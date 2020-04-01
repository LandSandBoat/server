-----------------------------------------
-- ID: 5105
-- Scroll of Flurry II
-- Teaches the white magic Flurry II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(846)
end

function onItemUse(target)
    target:addSpell(846)
end
