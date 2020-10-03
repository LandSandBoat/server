-----------------------------------
-- Area: West Ronfaure
--  NPC: Aaveleon
-- Involved in Quest: A Sentry's Peril
-- !pos -431 -45 343 100
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 600) then -- Ointment
        player:startEvent(100) -- He accepts the ointment and gives the player the empty case to return to his wife.
    elseif player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.A_SENTRY_S_PERIL) < QUEST_COMPLETED then
        player:startEvent(106) -- "What's this? I can't accept gifts from strangers."  He stops saying this after quest complete.
    end
end

function onTrigger(player, npc)
    local sentrysPerilStatus = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.A_SENTRY_S_PERIL)
    local tradeFinished = player:getCharVar("SentrysPerilTraded")

    if sentrysPerilStatus < QUEST_COMPLETED and tradeFinished ~= 1 then
        player:startEvent(101) -- "Ow! Ouch! Gah... If only I'd remembered that ointment!"
    elseif tradeFinished == 1 and not player:hasItem(601) then
        player:startEvent(126, 601) -- "Did you lose it?"
    else
        player:messageSpecial(ID.text.AAVELEON_HEALED) -- "My wounds are healed, thanks to you!"
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 100 and npcUtil.giveItem(player, 601) then
        player:confirmTrade()
        player:setCharVar("SentrysPerilTraded", 1)
    elseif csid == 126 and option == 1 then
        npcUtil.giveItem(player, 601)
    end
end
