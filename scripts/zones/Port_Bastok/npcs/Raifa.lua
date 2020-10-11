-----------------------------------
-- Area: Port Bastok
--  NPC: Raifa
-- Type: Quest NPC - Involved in Eco-Warrior (Bastok)
-- !pos -166.416 -8.48 7.153 236
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local ecoStatus = player:getCharVar("EcoStatus")

    if ecoStatus == 0 and player:getFameLevel(BASTOK) >= 1 and player:getCharVar("EcoReset") ~= getConquestTally() then
        player:startEvent(278) -- Offer Eco-Warrior quest
    elseif ecoStatus == 101 then
        player:startEvent(280) -- Reminder dialogue to talk to Degga
    elseif ecoStatus == 103 and player:hasKeyItem(tpz.ki.INDIGESTED_ORE) then
        player:startEvent(282) -- Complete quest
    elseif ecoStatus ~= 0 and (ecoStatus < 100 or ecoStatus > 200) then
        player:startEvent(283) -- Already on a different nation's Eco-Warrior
    else
        player:startEvent(281) -- Default dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 278 and option == 1 then
        if player:getQuestStatus(BASTOK, tpz.quest.id.bastok.ECO_WARRIOR) == QUEST_AVAILABLE then
            player:addQuest(BASTOK, tpz.quest.id.bastok.ECO_WARRIOR)
        end
        player:setCharVar("EcoStatus", 101) -- EcoStatus var:  1 to 3 for sandy // 101 to 103 for bastok // 201 to 203 for windurst
    elseif csid == 282 and npcUtil.completeQuest(player, BASTOK, tpz.quest.id.bastok.ECO_WARRIOR, {
        gil = 5000,
        item = 4198,
        title = tpz.title.CERULEAN_SOLDIER,
        fame = 80,
        var = "EcoStatus"
    }) then
        player:delKeyItem(tpz.ki.INDIGESTED_ORE)
        player:setCharVar("EcoReset", getConquestTally())
    end
end
