-----------------------------------------
-- ID: 5000
-- Scroll of Knights Minne IV
-- Teaches the song Mages Ballad IV
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(392)
end

function onItemUse(target)
    target:addSpell(392)
end
