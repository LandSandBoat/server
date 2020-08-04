-----------------------------------------
-- ID: 5826
-- Item: Lucid Potion III
-- Item Effect: Restores 2000 HP
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")

function onItemCheck(target)
    if target:getHP() == target:getMaxHP() then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end
    return 0
end

function onItemUse(target)
    target:messageBasic(tpz.msg.basic.RECOVERS_HP, 0, target:addHP(2000*ITEM_POWER))
end
