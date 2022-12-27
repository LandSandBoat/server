-----------------------------------
-- ID: 15324
-- Caitiff's Socks
-- Players have chance to be given flee effect when taken damage
-- while HP < 25 and TP < 1000
-- Lasts for 30 seconds. Proc rate requires more information
-----------------------------------
local itemObject = {}

itemObject.onItemDrop = function(player, item)
end

itemObject.onItemEquip = function(player, item)
    player:addListener("ATTACKED", "CAITIFF_SOCKS_FLEE", function(playerArg, mob)
        if
            playerArg:getHPP() < 25 and
            playerArg:getTP() < 1000 and
            math.random() <= .15
        then
            playerArg:delStatusEffect(xi.effect.FLEE)
            playerArg:addStatusEffect(xi.effect.FLEE, 100, 0, 30)
            playerArg:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.FLEE)
        end
    end)
end

itemObject.onItemUnequip = function(player, item)
    player:removeListener("CAITIFF_SOCKS_FLEE")
end

return itemObject
