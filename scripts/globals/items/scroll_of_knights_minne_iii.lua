-----------------------------------------
-- ID: 4999
-- Scroll of Knights Minne III
-- Teaches the song Mages Ballad III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(391)
end

function onItemUse(target)
    target:addSpell(391)
end
