-----------------------------------
-- Area: Mine_Shaft_2716
--  NPC: Shaft entrance
-----------------------------------
local entity = {}

require("scripts/globals/bcnm")
require("scripts/globals/missions")

entity.onTrade = function(player, npc, trade)
    if (player:getCurrentMission(COP) == xi.mission.id.cop.THREE_PATHS and ( player:getCharVar("COP_Louverance_s_Path") == 7 or player:getCharVar("COP_Louverance_s_Path") == 8 )) then
        if (trade:getItemCount() == 1 and trade:hasItemQty(1684, 1)) then
            player:startEvent(3)
        end
    else
        TradeBCNM(player, npc, trade)
    end
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(COP) == xi.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN and player:getCharVar("PromathiaStatus")==0) then
        player:startEvent(4)
    else
        EventTriggerBCNM(player, npc)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 3 then
        player:setCharVar("COP_Louverance_s_Path", 9)
        player:tradeComplete()
    elseif csid == 4 then
        player:setCharVar("PromathiaStatus", 1)
    else
        EventFinishBCNM(player, csid, option)
    end
end

return entity
