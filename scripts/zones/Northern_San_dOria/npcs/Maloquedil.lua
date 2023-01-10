-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Maloquedil
-- Involved in Quest : Warding Vampires, Riding on the Clouds, Lure of the Wildcat (San d'Oria)
-- !pos 35 0.1 60 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES) ~= QUEST_AVAILABLE then
        if trade:hasItemQty(1018, 2) and trade:getItemCount() == 2 then -- Trade Shaman Garlic
            player:startEvent(23)
        end
    end
end

entity.onTrigger = function(player, npc)
    local warding = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES)
    local wildcatSandy = player:getCharVar("WildcatSandy")

    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 7)
    then
        player:startEvent(807)
    elseif
        warding == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 3
    then
        -- Quest available for fame superior or equal to 3
        player:startEvent(24)
    elseif warding == QUEST_ACCEPTED then --Quest accepted, and he just tell me where to get item.
        player:startEvent(22)
    elseif warding == QUEST_COMPLETED then --Since the quest is repeatable, he tells me where to find (again) the items.
        player:startEvent(22)
    else
        player:startEvent(21)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 24 and option == 1 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES)
    elseif csid == 23 then
        player:tradeComplete()
        player:addTitle(xi.title.VAMPIRE_HUNTER_D_MINUS)
        npcUtil.giveCurrency(player, 'gil', 900)
        if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES) == QUEST_ACCEPTED then
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES)
        else
            player:addFame(xi.quest.fame_area.SANDORIA, 5)
        end
    elseif csid == 807 then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 7, true))
    end
end

return entity
