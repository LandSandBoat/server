-----------------------------------------
-- ID: 5042
-- Scroll of Swift Etude
-- Teaches the song Swift Etude
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(434)
end

function onItemUse(target)
    target:addSpell(434)
end
