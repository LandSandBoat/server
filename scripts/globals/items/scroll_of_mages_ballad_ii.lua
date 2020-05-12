-----------------------------------------
-- ID: 4995
-- Scroll of Mages Ballad II
-- Teaches the song Mages Ballad II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(387)
end

function onItemUse(target)
    target:addSpell(387)
end
