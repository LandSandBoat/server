-----------------------------------------
-- ID: 5037
-- Scroll of Spirited Etude
-- Teaches the song Spirited Etude
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(429)
end

function onItemUse(target)
    target:addSpell(429)
end
