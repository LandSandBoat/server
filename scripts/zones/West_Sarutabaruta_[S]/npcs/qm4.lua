-----------------------------------
-- Area: West Sarutabaruta [S]
--  NPC: qm4
-- Note: Involved in quest "The Tigress Stirs"
-- !pos 150 -39 331 95
-----------------------------------
local ID = require("scripts/zones/West_Sarutabaruta_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STIRS) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.SMALL_STARFRUIT) then
        player:addKeyItem(tpz.ki.SMALL_STARFRUIT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SMALL_STARFRUIT)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
