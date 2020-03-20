-----------------------------------------
-- ID: 4672
-- Scroll of Barthunder
-- Teaches the white magic Barthunder
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(64)
end

function onItemUse(target)
    target:addSpell(64)
end
