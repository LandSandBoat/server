-----------------------------------------
-- ID: 4997
-- Scroll of Knights Minne
-- Teaches the song Mages Ballad
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(389)
end

function onItemUse(target)
    target:addSpell(389)
end
