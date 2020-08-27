-----------------------------------
-- Area: Bastok Markets
--  NPC: Salimah
-- Notes: Start & Finishes Quest: Gourmet
-- !pos -31.687 -6.824 -73.282 235
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/titles")
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)

    local Gourmet = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.GOURMET)

    if (Gourmet ~= QUEST_AVAILABLE and player:needToZone() == false) then
        local count = trade:getItemCount()
        local hasSleepshroom = trade:hasItemQty(4374, 1)
        local hasTreantBulb = trade:hasItemQty(953, 1)
        local hasWildOnion = trade:hasItemQty(4387, 1)

        if (hasSleepshroom or hasTreantBulb or hasWildOnion) then
            if (count == 1) then
                local vanatime = VanadielHour()
                local item = 0
                local event = 203

                if (hasSleepshroom) then
                    item = 4374
                    if (vanatime>=18 or vanatime<6) then
                        event = 201
                    end
                elseif (hasTreantBulb) then
                    item = 953
                    if (vanatime>=6 and vanatime<12) then
                        event = 201
                    end
                elseif (hasWildOnion) then
                    item = 4387
                    if (vanatime>=12 and vanatime<18) then
                        event = 202
                    end
                end

                player:startEvent(event, item)
            end
        end
    end
end

function onTrigger(player, npc)

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.GOURMET) ~= QUEST_AVAILABLE and player:needToZone()) then
        player:startEvent(121)
    else
        player:startEvent(200)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    local Gourmet = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.GOURMET)

    if (csid == 200) then
        if (Gourmet == QUEST_AVAILABLE) then
            player:addQuest(BASTOK, tpz.quest.id.bastok.GOURMET)
        end
    elseif (csid ~= 121) then
        player:tradeComplete()
        if (Gourmet == QUEST_ACCEPTED) then
            player:completeQuest(BASTOK, tpz.quest.id.bastok.GOURMET)
        end

        local gil=350
        local fame=120
        if (csid == 201) then
            gil=200
        elseif (csid == 203) then
            gil=100
            fame=60
        end

        player:addGil(gil*GIL_RATE)
        player:messageSpecial(ID.text.GIL_OBTAINED, gil*GIL_RATE)
        player:addFame(BASTOK, fame)
        player:addTitle(tpz.title.MOMMYS_HELPER)
        player:needToZone(true)
    end
end
