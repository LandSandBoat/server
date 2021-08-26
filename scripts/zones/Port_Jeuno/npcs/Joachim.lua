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
    local numTraverserHeld = xi.abyssea.getTravStonesTotal(player)
    local maxTraverserCanHold = xi.abyssea.getMaxTravStones(player)
    local isCap = availableStones > 0 and 0 or 2

    if numTraverserHeld >= maxTraverserCanHold then
        isCap = 1
    end

    if player:getQuestStatus(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH) >= QUEST_ACCEPTED then
        player:startEvent(328, 0, availableStones, numTraverserHeld, isCap, 1, 1, 1, 3) -- Post "The Truth Beckons" Menu
    -- elseif
        -- player:startEvent(332)
    end
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 328 then
        if option == 3 then
            local rechargeInterval = 20 - xi.abyssea.getAbyssiteTotal(player, xi.abyssea.abyssiteType.CELERITY)
            local rechargeRemaining = rechargeInterval * 60 - (os.time() - player:getTraverserEpoch() - rechargeInterval * 3600 * player:getClaimedTraverserStones()) / 60

            player:updateEvent(0, 0, 0, 0, rechargeRemaining)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 328 and option == 6 then
        local availableStones = player:getAvailableTraverserStones()
        local numTraverserHeld = xi.abyssea.getTravStonesTotal(player)
        local requestedStones = xi.abyssea.getMaxTravStones(player) - numTraverserHeld

        -- Make sure we don't hand out stones if the player doesn't have them in reserve
        if requestedStones > availableStones then
            requestedStones = availableStones
        end

        local startKeyItem = xi.ki.TRAVERSER_STONE1 + numTraverserHeld - 1
        for keyItem = startKeyItem, startKeyItem + requestedStones do
            player:addKeyItem(keyItem)
        end

        print(requestedStones)

        local kiMessage = requestedStones > 1 and ID.text.OBTAINED_NUM_KEYITEMS or ID.text.OBTAINED_NUM_KEYITEM
        player:messageSpecial(kiMessage, xi.ki.TRAVERSER_STONE1, requestedStones)
    end
end

return entity
