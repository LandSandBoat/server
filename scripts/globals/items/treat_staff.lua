-----------------------------------
-- ID: 17566
-- Treat Staff
-- Players have a chance to be warped while attacking depeding on the following conditions:
--  1) If the Harvest Festival active, while HP <= 75% and TP < 1000
--  2) Under Full/New Moon, while HP <= 75% and TP < 1000
-- Based on FFXIclopedia in 2005
-- https://ffxiclopedia.fandom.com/wiki/Treat_Staff?direction=next&oldid=24549
-- Proc Rate requires more testing (Currently Set to 20%)
-----------------------------------
local itemObject = {}

itemObject.onItemDrop = function(player, item)
end

itemObject.onItemEquip = function(player, item)
    player:addListener("ATTACK", "TRICK_STAFF_WARP", function(playerArg, mob)
        if
            xi.events.harvest.enabledCheck() or
            IsMoonFull() or
            IsMoonNew()
        then
            if
                playerArg:getTP() < 1000 and
                playerArg:getHPP() <= 75 and
                math.random() <= .2
            then
                playerArg:warp()
            end
        end
    end)
end

itemObject.onItemUnequip = function(player, item)
    player:removeListener("TRICK_STAFF_WARP")
end

return itemObject
