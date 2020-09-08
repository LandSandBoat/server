
local ID = require("scripts/zones/Mog_Garden/IDs")
require("scripts/globals/moghouse")
require("scripts/globals/shop")
-----------------------------------

local BRONZE_PIECE_ITEMID = 2184

function onTrade(player, npc, trade)
    moogleTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(1016)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 1016 and option == 0xFFF00FF) then -- Show the Mog House menu..
        -- Print the expire time for mog locker if exists..
        local lockerLease = getMogLockerExpiryTimestamp(player)
        if (lockerLease ~= nil) then
            if (lockerLease == -1) then -- Lease expired..
                player:messageSpecial(ID.text.MOGLOCKER_MESSAGE_OFFSET + 2, BRONZE_PIECE_ITEMID)
            else
                player:messageSpecial(ID.text.MOGLOCKER_MESSAGE_OFFSET + 1, lockerLease)
            end
        end

        -- Show the mog house menu..
        player:sendMenu(1)

    elseif (csid == 1016 and option == 0xFFE00FF) then -- Buy/Sell Things
        local stock =
        {
            573, 280,    -- Vegetable Seeds
            574, 320,    -- Fruit Seeds
            575, 280,    -- Grain Seeds
            572, 280,    -- Herb Seeds
            1236, 1685,  -- Cactus Stems
            2235, 320,   -- Wildgrass Seeds

            3986, 1111,  -- Chestnut Tree Sap (11th Anniversary Campaign)
            3985, 1111,  -- Monarch Beetle Saliva (11th Anniversary Campaign)
            3984, 1111,  -- Golden Seed Pouch (11th Anniversary Campaign)
        }
        tpz.shop.general(player, stock)

    elseif (csid == 1016 and option == 0xFFB00FF) then -- Leave this Mog Garden -> Whence I Came
        player:warp() -- Workaround for now, the last zone seems to get messed up due to mog house issues.

    end
end
