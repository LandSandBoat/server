-----------------------------------
-- Area: West Ronfaure
--  NPC: Esca
-- Involved in Quest "The Pickpocket"
-- !pos -624.231 -51.499 278.369 100
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.THE_PICKPOCKET) == QUEST_ACCEPTED and player:getCharVar("thePickpocket") == 1 and npcUtil.tradeHas(trade, 578) then
        player:startEvent(121)
    end
end

function onTrigger(player, npc)
    local thePickpocketStat = player:getCharVar("thePickpocket")
    local chasingQuotasStat = player:getCharVar("ChasingQuotas_Progress")

    -- CHASING QUOTAS
    if chasingQuotasStat == 4 then
        player:startEvent(137) -- My earring!  I stole the last dragoon's armor.  Chosen option does not matter.
    elseif chasingQuotasStat == 5 then
        player:startEvent(138) -- Reminder for finding the armor.

    -- THE PICKPOCKET
    elseif thePickpocketStat == 1 then
        player:startEvent(120)
    elseif thePickpocketStat == 2 and not player:hasItem(579) then
        player:startEvent(128)
    elseif thePickpocketStat == 2 then
        player:startEvent(123)

    -- STANDARD DIALOG
    else
        player:startEvent(119)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- THE PICKPOCKET
    if csid == 121 and npcUtil.giveItem(player, 579) then
        player:setCharVar("thePickpocket", 2)
        player:confirmTrade()

    -- CHASING QUOTAS
    elseif csid == 137 then
        player:setCharVar("ChasingQuotas_Progress", 5)
        player:delKeyItem(tpz.ki.SHINY_EARRING)
    end
end
