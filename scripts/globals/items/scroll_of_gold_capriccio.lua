-----------------------------------------
-- ID: 5020
-- Scroll of Gold Capriccio
-- Teaches the song Gold Capriccio
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(412)
end

function onItemUse(target)
    target:addSpell(412)
end
