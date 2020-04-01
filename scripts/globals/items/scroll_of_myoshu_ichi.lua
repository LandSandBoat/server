-----------------------------------------
-- ID: 4966
-- Scroll of Myoshu: Ichi
-- Teaches the ninjutsu Myoshu: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(507)
end

function onItemUse(target)
    target:addSpell(507)
end
