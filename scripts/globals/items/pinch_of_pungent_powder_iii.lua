-----------------------------------
-- ID: 6537
-- Pungent Powder III
-- Enchantment: 60Min, Costume -
-- Baby Adamantoise (2925)
-- Baby Behemoth (2937)
-- Baby Fafnir (2944)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}
local costumes = {2925, 2937, 2944}

itemObject.onItemCheck = function(target)
    if not target:canUseMisc(xi.zoneMisc.COSTUME) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    end

    return 0
end

itemObject.onItemUse = function(target)
    local randomCostume = costumes[math.random(1, #costumes)]
    target:addStatusEffect(xi.effect.COSTUME, randomCostume, 0, 3600)
end

return itemObject
