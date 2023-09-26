-----------------------------------
-- ID: 17615
-- Chicken Knife
-----------------------------------
require("scripts/globals/utils") -- For clamping function
-----------------------------------
local itemObject = {}

itemObject.onItemEquip = function(player, item)
    player:addListener("ATTACK", "CHICKEN_KNIFE_ATTACK", function(playerArg, mob)
        local dLvl = mob:getMainLvl() - playerArg:getMainLvl()
        if dLvl >= 1 then
            -- exponential approx to data points from retail capture
            local chance = utils.clamp(100 * 0.0096906 * math.exp(0.176839 * dLvl), 1.33, 33)
            if
                math.random(1, 100) <= chance and
                not playerArg:hasStatusEffect(xi.effect.FLEE)
            then
                playerArg:addStatusEffect(xi.effect.FLEE, 100, 0, 30)
            end
        end
    end)
end

itemObject.onItemUnequip = function(player, item)
    player:removeListener("CHICKEN_KNIFE_ATTACK")
end

return itemObject
