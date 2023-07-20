-----------------------------------
-- ID: 10849
-- Yagudo Belt
-- Enchantment: 60Min, Costume - Yagudo (Various [S])
-----------------------------------
local itemObject = {}
local costumes = { 2085, 2114, 2115 }

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
