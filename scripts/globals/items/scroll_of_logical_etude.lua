-----------------------------------------
-- ID: 5044
-- Scroll of Logical Etude
-- Teaches the song Logical Etude
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(436)
end

function onItemUse(target)
    target:addSpell(436)
end
