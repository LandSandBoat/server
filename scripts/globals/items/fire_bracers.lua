-----------------------------------------
-- ID: 14991
-- Fire Bracers
--  Enchantment: "Enfire"
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effect = tpz.effect.ENFIRE
    doEnspell(target, target, nil, effect)
end
