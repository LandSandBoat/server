-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Aurege
-- Type: Quest Giver NPC
-- Starts Quest: Exit the Gambler
-- !pos -156.253 11.999 253.691 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local exitTheGambler = player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.EXIT_THE_GAMBLER)
    local exitTheGamblerStat = player:getCharVar("exitTheGamblerStat")
    local pickpocketMask = player:getCharVar("thePickpocketSkipNPC")

    if player:getCharVar("thePickpocket") == 1 and not utils.mask.getBit(pickpocketMask, 2) then
        player:showText(npc, ID.text.PICKPOCKET_AUREGE)
        player:setCharVar("thePickpocketSkipNPC", utils.mask.setBit(pickpocketMask, 2, true))
    elseif exitTheGambler < QUEST_COMPLETED and exitTheGamblerStat == 0 then
        player:startEvent(521)
    elseif exitTheGambler == QUEST_ACCEPTED and exitTheGamblerStat == 1 then
        player:startEvent(516)
    else
        player:startEvent(514)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 521 and player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.EXIT_THE_GAMBLER) == QUEST_AVAILABLE then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.EXIT_THE_GAMBLER)
    elseif csid == 516 then
        npcUtil.completeQuest(player, SANDORIA, tpz.quest.id.sandoria.EXIT_THE_GAMBLER, {ki = tpz.ki.MAP_OF_KING_RANPERRES_TOMB, title = tpz.title.DAYBREAK_GAMBLER, xp = 2000})
    end
end
