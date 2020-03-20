-----------------------------------------
-- ID: 4667
-- Scroll of Silence
-- Teaches the white magic Silence
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(59)
end

function onItemUse(target)
    target:addSpell(59)
end
