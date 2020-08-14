-----------------------------------------
-- ID: 4803
-- Scroll of Thundaga II
-- Teaches the black magic Thundaga II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(195)
end

function onItemUse(target)
    target:addSpell(195)
end
