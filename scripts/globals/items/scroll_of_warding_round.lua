-----------------------------------------
-- ID: 5022
-- Scroll of Warding Round
-- Teaches the song Warding Round
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(414)
end

function onItemUse(target)
    target:addSpell(414)
end
