-----------------------------------------
-- ID: 4115
-- Item: Potion +3
-- Item Effect: Restores 100 HP
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")

function onItemCheck(target)
    if (target:getHP() == target:getMaxHP()) then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end
    return 0
end

function onItemUse(target)
    target:messageBasic(tpz.msg.basic.RECOVERS_HP, 0, target:addHP(100*ITEM_POWER))
end
