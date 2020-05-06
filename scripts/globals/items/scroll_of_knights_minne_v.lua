-----------------------------------------
-- ID: 5001
-- Scroll of Knights Minne V
-- Teaches the song Mages Ballad V
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(393)
end

function onItemUse(target)
    target:addSpell(393)
end
