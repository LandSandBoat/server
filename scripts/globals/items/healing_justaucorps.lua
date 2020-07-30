-----------------------------------------
-- ID: 14496
-- Item: Healing Justaucorps
-- Item Effect: Restores 150-175 HP
-----------------------------------------
require("scripts/globals/msg")

function onItemCheck(target)
    if (target:getHP() == target:getMaxHP()) then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end
    return 0
end

function onItemUse(target)
    local hpHeal = math.random(150, 175)
    local dif = target:getMaxHP() - target:getHP()
    if (hpHeal > dif) then
        hpHeal = dif
    end
    target:addHP(hpHeal)
    target:messageBasic(tpz.msg.basic.RECOVERS_HP, 0, hpHeal)
end
