-----------------------------------
-- ID: 17031
-- Shell Scepter
-- Enchantment: 60Min, Costume - Goblin
-- Goblin Golden (686)
-- Goblin Freelance (997)
-- Goblin Dynamis (1090)
-- Goblin on Chocobo (1249)
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}
local costumes = { 686, 997, 1090, 1249 }

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
