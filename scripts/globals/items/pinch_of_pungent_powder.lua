-----------------------------------
-- ID: 5724
-- Pungent Powder
-- Enchantment: 60Min, Costume -
-- Baby Buffalo (2920)
-- Baby Coeurl (2921)
-- Baby Bugard (2927)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

local costumes = {2920, 2921, 2927}

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
