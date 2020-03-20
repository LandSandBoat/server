-----------------------------------------
-- ID: 4994
-- Scroll of Mages Ballad
-- Teaches the song Mages Ballad
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(386)
end

function onItemUse(target)
    target:addSpell(386)
end
