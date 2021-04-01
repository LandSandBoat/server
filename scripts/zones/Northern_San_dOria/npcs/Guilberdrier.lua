-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Guilberdrier
-- Involved in Quests: Flyers for Regine, Exit the Gambler
-- !pos -159.082 12.000 253.794 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/quests/flyers_for_regine")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 6) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    local exitTheGambler = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.EXIT_THE_GAMBLER)
    local exitTheGamblerStat = player:getCharVar("exitTheGamblerStat")
    local pickpocketMask = player:getCharVar("thePickpocketSkipNPC")

    if player:getCharVar("thePickpocket") == 1 and not utils.mask.getBit(pickpocketMask, 4) then
        player:showText(npc, ID.text.PICKPOCKET_GUILBERDRIER)
        player:setCharVar("thePickpocketSkipNPC", utils.mask.setBit(pickpocketMask, 4, true))
    elseif exitTheGambler < QUEST_COMPLETED and exitTheGamblerStat == 0 then
        player:startEvent(522)
    elseif exitTheGambler == QUEST_ACCEPTED and exitTheGamblerStat == 1 then
        player:startEvent(518)
    else
        player:startEvent(514)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 522 and player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.EXIT_THE_GAMBLER) == QUEST_AVAILABLE then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.EXIT_THE_GAMBLER)
    elseif csid == 518 then
        npcUtil.completeQuest(player, SANDORIA, xi.quest.id.sandoria.EXIT_THE_GAMBLER, {ki = xi.ki.MAP_OF_KING_RANPERRES_TOMB, title = xi.title.DAYBREAK_GAMBLER, xp = 2000})
    end
end

return entity
