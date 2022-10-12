-----------------------------------
-- Area: Bastok Mines
--  NPC: Deidogg
-- Starts and Finishes Quest: The Talekeeper's Gift (start)
-- !pos -13 7 29 234
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getCharVar("theTalekeeperGiftCS") == 2 then
        if trade:hasItemQty(4394, 1) and trade:getItemCount() == 1 then -- Trade Ginger Cookie
            player:startEvent(172)
        end
    end
end

entity.onTrigger = function(player, npc)
    local wait1DayForAF3       = player:getCharVar("DeidoggWait1DayForAF3")

    if
        player:needToZone() == false and
        VanadielDayOfTheYear() ~= wait1DayForAF3 and
        wait1DayForAF3 ~= 0 and
        player:getCharVar("theTalekeeperGiftCS") == 0 and
        player:getMainJob() == xi.job.WAR
    then
        player:startEvent(170)
        player:setCharVar("theTalekeeperGiftCS", 1)
        player:setCharVar("DeidoggWait1DayForAF3", 0)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 172 then
        player:tradeComplete()
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPER_S_GIFT)
        player:setCharVar("theTalekeeperGiftCS", 3)
    end
end

return entity
