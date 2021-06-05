-----------------------------------
-- Area: Yuhtunga Jungle
--  NPC: Cermet Headstone
-- Involved in Mission: ZM5 Headstone Pilgrimage (Fire Fragment)
-- !pos 491 20 301 123
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- WRATH OF THE OPO-OPOS
    if npcUtil.tradeHas(trade, 790) then
        if not player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.WRATH_OF_THE_OPO_OPOS) and (player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE) or player:hasKeyItem(xi.ki.FIRE_FRAGMENT)) then
            player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.WRATH_OF_THE_OPO_OPOS)
            player:startEvent(202, 790)
        else
            player:messageSpecial(ID.text.NOTHING_HAPPENS)
        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- WRATH OF THE OPO-OPOS
    if csid == 202 and npcUtil.completeQuest(player, OUTLANDS, xi.quest.id.outlands.WRATH_OF_THE_OPO_OPOS, {item=13143, title=xi.title.FRIEND_OF_THE_OPOOPOS}) then
        player:confirmTrade()
    end
end

return entity
