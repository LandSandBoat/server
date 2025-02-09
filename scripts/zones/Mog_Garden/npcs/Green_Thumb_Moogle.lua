-----------------------------------
-- Area: Mog Garden
--  NPC: Green Thumb Moogle
-----------------------------------
local ID = zones[xi.zone.MOG_GARDEN]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.moghouse.moogleTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(1016)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 1016 and option == 0xFFF00FF then -- Show the Mog House menu
        -- Print the expire time for mog locker if exists
        local lockerLease = xi.moghouse.getMogLockerExpiryTimestamp(player)
        if lockerLease ~= nil then
            if lockerLease == -1 then -- Lease expired..
                player:messageSpecial(ID.text.MOGLOCKER_MESSAGE_OFFSET + 2, xi.item.IMPERIAL_BRONZE_PIECE)
            else
                player:messageSpecial(ID.text.MOGLOCKER_MESSAGE_OFFSET + 1, lockerLease)
            end
        end

        -- Show the mog house menu
        player:sendMenu(xi.menuType.MOOGLE)

    elseif csid == 1016 and option == 0xFFE00FF then -- Buy/Sell Things
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
        xi.shop.general(player, stock)

    elseif csid == 1016 and option == 0xFFB00FF then -- Leave this Mog Garden -> Whence I Came
        player:warp() -- Workaround for now, the last zone seems to get messed up due to mog house issues.
    end
end

return entity
