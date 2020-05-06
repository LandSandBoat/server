-----------------------------------------
-- ID: 5043
-- Scroll of Sage Etude
-- Teaches the song Sage Etude
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(435)
end

function onItemUse(target)
    target:addSpell(435)
end
