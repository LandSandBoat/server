-----------------------------------
-- Area: Port San d'Oria
--  NPC: Miene
-- NPC for Quest "The Pickpocket"
-- !pos 0.750 -4.000 -81.438 232
-----------------------------------
require("scripts/quests/flyers_for_regine")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 2) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    local thePickpocket = player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.THE_PICKPOCKET)
    local thePickpocketStat = player:getCharVar("thePickpocket")

    -- THE PICKPOCKET
    if thePickpocket == QUEST_AVAILABLE and thePickpocketStat == 0 then
        player:startEvent(502)
    elseif thePickpocket == QUEST_AVAILABLE and thePickpocketStat == 1 then
        player:startEvent(554)
    elseif thePickpocket == QUEST_ACCEPTED and player:getCharVar("thePickpocketEagleButton") == 0 then
        player:startEvent(549)
        player:setCharVar("thePickpocketEagleButton", 1)
    elseif thePickpocket == QUEST_ACCEPTED and player:getCharVar("thePickpocketEagleButton") == 1 and not player:hasItem(578) then
        player:startEvent(611)

    -- STANDARD DIALOG
    else
        player:startEvent(553)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- THE PICKPOCKET
    if csid == 502 then
        player:setCharVar("thePickpocket", 1)
    elseif csid == 549 or csid == 611 then
        if not npcUtil.giveItem(player, 578) then
            player:startEvent(552)
        end
    end
end

return entity
