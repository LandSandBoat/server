-----------------------------------------
-- ID: 4996
-- Scroll of Mages Ballad III
-- Teaches the song Mages Ballad III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(388)
end

function onItemUse(target)
    target:addSpell(388)
end
