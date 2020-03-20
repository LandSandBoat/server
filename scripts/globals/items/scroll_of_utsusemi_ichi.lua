-----------------------------------------
-- ID: 4946
-- Scroll of Utsusemi: Ichi
-- Teaches the ninjutsu Utsusemi: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(338)
end

function onItemUse(target)
    target:addSpell(338)
end
