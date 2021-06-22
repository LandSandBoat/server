-----------------------------------
-- Area: Giddeus
--  NPC: Uu Zhoumo
-- Involved in Mission 2-3
-- !pos -179 16 155 145
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getCurrentMission(BASTOK) == xi.mission.id.bastok.THE_EMISSARY_WINDURST and trade:hasItemQty(16509, 1) and trade:getItemCount() == 1 then -- Trade Aspir Knife
        player:startEvent(41)
    end
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(BASTOK) == xi.mission.id.bastok.THE_EMISSARY_WINDURST then
        if player:hasKeyItem(xi.ki.DULL_SWORD) then
            player:startEvent(40)
        elseif player:getMissionStatus(player:getNation()) == 5 then
            player:startEvent(43)
        else
            player:startEvent(44)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 40 then
        player:setMissionStatus(player:getNation(), 5)
        player:delKeyItem(xi.ki.DULL_SWORD)
    elseif csid == 41 then
        player:tradeComplete()
        player:setMissionStatus(player:getNation(), 6)
    end
end

return entity
