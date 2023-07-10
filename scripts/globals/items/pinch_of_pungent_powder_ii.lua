-----------------------------------
-- ID: 6535
-- Pungent Powder II
-- Enchantment: 60Min, Costume -
-- Baby Sheep (2914)
-- Baby Cockatrice (2916)
-- Porxie (2928) QoL
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

local costumes = { 2914, 2916, 2928 }

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
