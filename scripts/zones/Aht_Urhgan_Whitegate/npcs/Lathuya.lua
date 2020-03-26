-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Lathuya
-- Standard Info NPC
-- Involved in quests: Omens
-- !pos -95.081 -6.000 31.638 50
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local omensProgress = player:getCharVar("OmensProgress")
    local omens = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.OMENS)

    -- OMENS
    if omens >= QUEST_ACCEPTED then
        if omensProgress == 3 then
            player:startEvent(714) -- Tells Master location
        elseif omensProgress == 4 then
            player:startEvent(715) -- Reminder of master location
        elseif omensProgress == 5 then
            player:startEvent(716) -- Master spoken to
        elseif omens == QUEST_COMPLETED then
            player:startEvent(771) -- Default dialog
        end

    -- DEFAULT DIALOG
    else
        player:startEvent(770)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local omensProgress = player:getCharVar("OmensProgress")

    -- OMENS
    if csid == 714 and omensProgress == 3 then
        player:setCharVar("OmensProgress", 4)
    elseif csid == 716 and omensProgress == 5 then
        npcUtil.completeQuest(player, AHT_URHGAN, tpz.quest.id.ahtUrhgan.OMENS, {
            item = 15684,
            title = tpz.title.IMMORTAL_LION,
            var = { OmensProgress }
        })
        player:delKeyItem(tpz.ki.SEALED_IMMORTAL_ENVELOPE)
    end
end