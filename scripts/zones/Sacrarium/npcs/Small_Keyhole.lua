-----------------------------------
--  NPC: Small Keyhole
-- Area: Sacrarium
-- !pos 99.772 -1.614 51.545 28
-- NOTE:
--   Old event call 100 ran too fast,
--   used messages instead
-----------------------------------
local ID = require("scripts/zones/Sacrarium/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.TEMPLE_KNIGHT_KEY) then
        GetNPCByID(npc:getID() - 3):openDoor(15)
    else
        player:messageSpecial(ID.text.SMALL_KEYHOLE_DESCRIPTION)
    end
end

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.items.CORAL_CREST_KEY) then
        if npc:getLocalVar("canTradeSecondKey") == 0 then
            npc:setLocalVar("canTradeSecondKey", 1)
            -- Opens lock visually to indicate to other players when to trade next key
            GetNPCByID(ID.npc.SMALL_KEYHOLE - 2):openDoor(18)
            local speed = player:getSpeed()
            player:setSpeed(0)
            --player:startEvent(100)

            player:timer(2000, function(playerArg)
                playerArg:messageSpecial(ID.text.HOLDING_THE_LOCK)
                playerArg:timer(10000, function(playerArg1)
                    playerArg1:messageSpecial(ID.text.HAND_GROWN_NUMB)

                    playerArg1:timer(5000, function(playerArg2)
                        playerArg2:messageSpecial(ID.text.CORAL_KEY_BREAKS, 0, xi.items.CORAL_CREST_KEY)
                        npc:setLocalVar("canTradeSecondKey", 0)
                        player:setSpeed(speed)
                        playerArg2:confirmTrade()
                    end)
                end)
            end)
        else
            player:messageSpecial(ID.text.CANNOT_TRADE_NOW)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
