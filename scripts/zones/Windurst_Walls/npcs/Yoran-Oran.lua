-----------------------------------
-- Area: Windurst Walls
--  NPC: Yoran-Oran
-- !pos -109.987 -14 203.338 239
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD) ~= QUEST_AVAILABLE then
        if npcUtil.tradeHas(trade, 17344, true) then
            player:startEvent(251, xi.settings.main.GIL_RATE * 200)
        elseif npcUtil.tradeHas(trade, 934, true) then
            player:startEvent(252, xi.settings.main.GIL_RATE * 250)
        elseif npcUtil.tradeHas(trade, 1154, true) then
            player:startEvent(253, xi.settings.main.GIL_RATE * 1200)
        elseif npcUtil.tradeHas(trade, 4369, true) then
            player:startEvent(254, xi.settings.main.GIL_RATE * 120)
        elseif npcUtil.tradeHas(trade, 1150, true) then
            player:startEvent(255, xi.settings.main.GIL_RATE * 5500)
        else
            player:startEvent(250)
        end
    end
end

entity.onTrigger = function(player, npc)
    local mandragoraMad = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD)
    local turmoil = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)

    if mandragoraMad == QUEST_AVAILABLE then
        player:startEvent(249)
    elseif mandragoraMad == QUEST_ACCEPTED then
        player:startEvent(256)
    elseif turmoil == QUEST_ACCEPTED then
        player:startEvent(392)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 249 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD)

    -- TODO: This can easily be handled as a table, keyed by csid - 250 when in range
    elseif csid == 251 then
        npcUtil.completeQuest(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD, { fame = 10, fameArea = xi.quest.fame_area.WINDURST })
        player:addGil(xi.settings.main.GIL_RATE * 200)
        player:confirmTrade()
    elseif csid == 252 then
        npcUtil.completeQuest(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD, { fame = 25, fameArea = xi.quest.fame_area.WINDURST })
        player:addGil(xi.settings.main.GIL_RATE * 250)
        player:confirmTrade()
    elseif csid == 253 then
        npcUtil.completeQuest(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD, { fame = 50, fameArea = xi.quest.fame_area.WINDURST })
        player:addGil(xi.settings.main.GIL_RATE * 1200)
        player:confirmTrade()
    elseif csid == 254 then
        npcUtil.completeQuest(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD, { fame = 10, fameArea = xi.quest.fame_area.WINDURST })
        player:addGil(xi.settings.main.GIL_RATE * 120)
        player:confirmTrade()
    elseif csid == 255 then
        npcUtil.completeQuest(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD, { fame = 100, fameArea = xi.quest.fame_area.WINDURST })
        player:addGil(xi.settings.main.GIL_RATE * 5500)
        player:confirmTrade()
    end
end

return entity
