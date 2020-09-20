-----------------------------------------
-- ID: 5204
-- Piece of Elvaan Mochi
-- Enchantment: 60Min, Costume - Elvaan Child (male)
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    if not target:canUseMisc(tpz.zoneMisc.COSTUME) then
        return tpz.msg.basic.CANT_BE_USED_IN_AREA
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.COSTUME, 154, 0, 3600)
end
