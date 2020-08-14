-----------------------------------------
-- ID: 5041
-- Scroll of Vital Etude
-- Teaches the song Vital Etude
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(433)
end

function onItemUse(target)
    target:addSpell(433)
end
