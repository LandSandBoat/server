-----------------------------------------
-- ID: 4998
-- Scroll of Knights Minne II
-- Teaches the song Mages Ballad II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(390)
end

function onItemUse(target)
    target:addSpell(390)
end
