-----------------------------------------
--  ID: 4265
--  Item: Black Drop
--  Transports the user to their Home Point
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    if (target:hasStatusEffect(tpz.effect.MEDICINE)) then
        return tpz.msg.basic.ITEM_NO_USE_MEDICATED
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 3600)
    target:warp()
end
