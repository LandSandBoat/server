-----------------------------------
-- Area: Port Jeuno
--  NPC: Joachim
-- !pos -52.844 0.000 -9.978 246
-- CS/Event ID's:
-- 324 = on zoning in
-- 325 = 1st chat, get 1st stone,
-- completes "A Journey Begins"
-- 326 = Limited Menu
-- 327 = CS after "The Truth Beckons" completed.
-- 328 = Full Menu
-- 331 = CS after "Dawn of Death" completed.
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/abyssea")
local ID = require("scripts/zones/Port_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local availableStones = player:getAvailableTraverserStones()
    local numTraverserHeld = xi.abyssea.getHeldTraverserStones(player)
    local maxTraverserCanHold = xi.abyssea.getTraverserCap(player)
    local messageType = availableStones > 0 and 0 or 2

    -- messageType parameter determines what is displayed to the player depending
    -- on other values: 0 = Eligible for Stone, 1 = Holding maximum stones, and
    -- 2 = No stones available

    if numTraverserHeld >= maxTraverserCanHold then
        messageType = 1
    end

    if player:getQuestStatus(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH) >= QUEST_ACCEPTED then
        player:startEvent(328, 0, availableStones, numTraverserHeld, messageType, 1, 1, 1, 3) -- Post "The Truth Beckons" Menu
    -- elseif
        -- player:startEvent(332)
    end
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 328 then
        if option == 3 then
            -- The following values calculates the amount of time remaining for a stone by working backwards from current time.
            -- Recharge interval is the adjusted value in hours, and remaining is in seconds initially.  Retail will display
            -- the result as a minute value to the player.

            local rechargeInterval = 20 - xi.abyssea.getAbyssiteTotal(player, xi.abyssea.abyssiteType.CELERITY)
            local lastStoneClaimedTime = os.time() - player:getTraverserEpoch() - rechargeInterval * 3600 * player:getClaimedTraverserStones()
            local rechargeRemaining = rechargeInterval * 60 - lastStoneClaimedTime / 60

            player:updateEvent(0, 0, 0, 0, rechargeRemaining)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 328 and option == 6 then
        local availableStones = player:getAvailableTraverserStones()
        local numTraverserHeld = xi.abyssea.getHeldTraverserStones(player)
        local requestedStones = xi.abyssea.getTraverserCap(player) - numTraverserHeld

        -- Make sure we don't hand out stones if the player doesn't have them in reserve
        if requestedStones > availableStones then
            requestedStones = availableStones
        end

        player:addClaimedTraverserStones(requestedStones)

        local startKeyItem = xi.ki.TRAVERSER_STONE1 + numTraverserHeld - 1
        for keyItem = startKeyItem, startKeyItem + requestedStones do
            player:addKeyItem(keyItem)
        end

        local kiMessage = requestedStones > 1 and ID.text.OBTAINED_NUM_KEYITEMS or ID.text.OBTAINED_NUM_KEYITEM
        player:messageSpecial(kiMessage, xi.ki.TRAVERSER_STONE1, requestedStones)
    end
end

return entity
