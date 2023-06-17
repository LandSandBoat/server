-----------------------------------
-- Area: Windurst Waters
--  NPC: Gantineux
-- Starts Quest: Acting in Good Faith
-- !pos -83 -9 3 238
-----------------------------------
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local actingInGoodFaith = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ACTING_IN_GOOD_FAITH)

    if
        actingInGoodFaith == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.WINDURST) >= 4 and
        player:getMainLvl() >= 10
    then
        player:startEvent(10019) -- Start quest "Acting in Good Faith"
    elseif actingInGoodFaith == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.SPIRIT_INCENSE) then
            player:startEvent(10020) -- During quest "Acting in Good Faith" (with Spirit Incense KI)
        elseif player:hasKeyItem(xi.ki.GANTINEUXS_LETTER) then
            player:startEvent(10022) --  During quest "Acting in Good Faith" (with Gantineux's Letter)
        else
            player:startEvent(10021) -- During quest "Acting in Good Faith" (before Gantineux's Letter)
        end
    elseif actingInGoodFaith == QUEST_COMPLETED then
        player:startEvent(10023) -- New standard dialog after "Acting in Good Faith"
    else
        player:startEvent(10018) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10019 and option == 0 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ACTING_IN_GOOD_FAITH)
        player:addKeyItem(xi.ki.SPIRIT_INCENSE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SPIRIT_INCENSE)
    elseif csid == 10021 then
        player:addKeyItem(xi.ki.GANTINEUXS_LETTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.GANTINEUXS_LETTER)
    end
end

return entity
