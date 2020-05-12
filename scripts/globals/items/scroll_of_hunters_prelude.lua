-----------------------------------------
-- ID: 5009
-- Scroll of Hunters Prelude
-- Teaches the song Hunters Prelude
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(401)
end

function onItemUse(target)
    target:addSpell(401)
end
