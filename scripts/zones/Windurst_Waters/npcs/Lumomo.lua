-----------------------------------
-- Area: Windurst Waters
--  NPC: Lumomo
-- Type: Quest NPC - Involved in Eco-Warrior (Windurst)
-- !pos -55.770 -5.499 18.914 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local ecoStatus = player:getCharVar("EcoStatus")

    if ecoStatus == 0 and player:getFameLevel(WINDURST) >= 1 and player:getCharVar("EcoReset") ~= getConquestTally() then
        player:startEvent(818) -- Offer Eco-Warrior quest
    elseif ecoStatus == 201 then
        player:startEvent(820) -- Reminder dialogue to talk to Ahko
    elseif ecoStatus == 203 and player:hasKeyItem(tpz.ki.INDIGESTED_MEAT) then
        player:startEvent(822) -- Complete quest
    elseif ecoStatus ~= 0 and ecoStatus < 200 then
        player:startEvent(823) -- Already on a different nation's Eco-Warrior
    else
        player:startEvent(821) -- Default dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 818 and option == 1 then
        if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.ECO_WARRIOR) == QUEST_AVAILABLE then
            player:addQuest(WINDURST, tpz.quest.id.windurst.ECO_WARRIOR)
        end
        player:setCharVar("EcoStatus", 201) -- EcoStatus var:  1 to 3 for sandy // 101 to 103 for bastok // 201 to 203 for windurst
    elseif csid == 822 and npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.ECO_WARRIOR, {
        gil = 5000,
        item = 4198,
        title = tpz.title.EMERALD_EXTERMINATOR,
        fame = 80,
        var = "EcoStatus"
    }) then
        player:delKeyItem(tpz.ki.INDIGESTED_MEAT)
        player:setCharVar("EcoReset", getConquestTally())
    end
end
