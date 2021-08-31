-----------------------------------
-- Area: La Theine Plateau
--  NPC: ??? (qm2)
--  Involved in Quest: HITTING_THE_MARQUISATE (THF AF3)
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/settings/main")
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    local hittingTheMarquisateNanaaCS = player:getCharVar("hittingTheMarquisateNanaaCS")

    if (trade:hasItemQty(605, 1) and trade:getItemCount() == 1) then -- Trade pickaxe
        if (hittingTheMarquisateNanaaCS == 1) then
            player:startEvent(119, 0, 0, 0, 605)
        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 119) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 14094)
        else
        player:addItem(14094)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 14094)
        player:tradeComplete()
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.HITTING_THE_MARQUISATE)
        player:addTitle(xi.title.PARAGON_OF_THIEF_EXCELLENCE)
        player:setCharVar("hittingTheMarquisateNanaaCS", 0)
        player:delKeyItem(xi.ki.CAT_BURGLARS_NOTE)
        end
    end
end

return entity
