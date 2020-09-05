-----------------------------------------
-- ID: 11788
-- Item: Jester's Hat
-- Item Effect: Casts Cure II
-----------------------------------------
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local hpHeal = 90
    local dif = target:getMaxHP() - target:getHP()
    if (hpHeal > dif) then
        hpHeal = dif
    end
    target:addHP(hpHeal)
    target:updateEnmityFromCure(target, hpHeal)
    target:messageBasic(tpz.msg.basic.RECOVERS_HP, 0, hpHeal)
end
