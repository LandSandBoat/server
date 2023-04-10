-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Halver
-- Involved in Mission 2-3, 3-3, 5-1, 5-2, 8-1
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos 2 0.1 0.1 233
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()
    local wildcatSandy = player:getCharVar("WildcatSandy")

    -- Lure of the Wildcat San d'Oria
    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 16)
    then
        player:startEvent(558)
    -- Blackmail quest
    elseif
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACKMAIL) == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.SUSPICIOUS_ENVELOPE)
    then
        player:startEvent(549)
        player:setCharVar("BlackMailQuest", 1)
        player:delKeyItem(xi.ki.SUSPICIOUS_ENVELOPE)
    elseif pNation == xi.nation.SANDORIA then
        -- Rank 10 default dialogue
        if player:getRank(player:getNation()) == 10 then
            player:startEvent(31)
        -- Default dialogue
        else
            player:startEvent(577)
        end
    elseif pNation == xi.nation.BASTOK then
        player:showText(npc, ID.text.HALVER_OFFSET + 1092)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 558 then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 16, true))
    end
end

return entity
