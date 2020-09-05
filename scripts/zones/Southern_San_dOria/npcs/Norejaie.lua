-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Norejaie
-- Type: Quest NPC - Involved in Eco-Warrior (San d'Oria)
-- !pos 83.924 1 110.54 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local ecoStatus = player:getCharVar("EcoStatus")

    if ecoStatus == 0 and player:getFameLevel(SANDORIA) >= 1 and player:getCharVar("EcoReset") ~= getConquestTally() then
        player:startEvent(677) -- Offer Eco-Warrior quest
    elseif ecoStatus == 1 then
        player:startEvent(679) -- Reminder dialogue to talk to Rojaireaut
    elseif ecoStatus == 3 and player:hasKeyItem(tpz.ki.INDIGESTED_ORE) then
        player:startEvent(681) -- Complete quest
    elseif ecoStatus > 100 then
        player:startEvent(682) -- Already on a different nation's Eco-Warrior
    else
        player:startEvent(680) -- Default dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 677 and option == 1 then
        if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.ECO_WARRIOR) == QUEST_AVAILABLE then
            player:addQuest(SANDORIA, tpz.quest.id.sandoria.ECO_WARRIOR)
        end
        player:setCharVar("EcoStatus", 1) -- EcoStatus var:  1 to 3 for sandy // 101 to 103 for bastok // 201 to 203 for windurst
    elseif csid == 681 and npcUtil.completeQuest(player, SANDORIA, tpz.quest.id.sandoria.ECO_WARRIOR, {
        gil = 5000,
        item = 4198,
        title = tpz.title.VERMILLION_VENTURER,
        fame = 80,
        var = "EcoStatus"
    }) then
        player:delKeyItem(tpz.ki.INDIGESTED_ORE)
        player:setCharVar("EcoReset", getConquestTally())
    end
end
