-----------------------------------------
-- ID: 5036
-- Scroll of Learned Etude
-- Teaches the song Learned Etude
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(428)
end

function onItemUse(target)
    target:addSpell(428)
end
