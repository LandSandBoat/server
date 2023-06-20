-----------------------------------
-- ID: 16183
-- Nomad Moogle Shield
-- Enchantment: 60Min, Costume - Moogle
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if not target:canUseMisc(xi.zoneMisc.COSTUME) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.COSTUME, 2308, 0, 3600)
end

return itemObject
