-----------------------------------------
-- ID: 4804
-- Scroll of Thundaga III
-- Teaches the black magic Thundaga III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(196)
end

function onItemUse(target)
    target:addSpell(196)
end
