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
            { xi.item.BAG_OF_VEGETABLE_SEEDS,  280 },
            { xi.item.BAG_OF_FRUIT_SEEDS,      320 },
            { xi.item.BAG_OF_GRAIN_SEEDS,      280 },
            { xi.item.BAG_OF_HERB_SEEDS,       280 },
            { xi.item.BAG_OF_CACTUS_STEMS,    1685 },
            { xi.item.BAG_OF_WILDGRASS_SEEDS,  320 },
            { xi.item.CHESTNUT_TREE_SAP,      1111 }, -- (11th Anniversary Campaign)
            { xi.item.MONARCH_BEETLE_SALIVA,  1111 }, -- (11th Anniversary Campaign)
            { xi.item.GOLDEN_SEED_POUCH,      1111 }, -- (11th Anniversary Campaign)
        }
        xi.shop.general(player, stock)

    elseif csid == 1016 and option == 0xFFB00FF then -- Leave this Mog Garden -> Whence I Came
        player:warp() -- Workaround for now, the last zone seems to get messed up due to mog house issues.
    end
end

return entity
