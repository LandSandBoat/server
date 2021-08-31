-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Cacaroon
-- Standard Info NPC
-- !pos -72.026 0.000 -82.337 50
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getCurrentMission(TOAU) == xi.mission.id.toau.KNIGHT_OF_GOLD and player:getCharVar("AhtUrganStatus") == 1 then
        if npcUtil.tradeHas(trade, {{"gil", 1000}}) or npcUtil.tradeHas(trade, 2184) then
            player:startEvent(3022, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(TOAU) == xi.mission.id.toau.KNIGHT_OF_GOLD and player:getCharVar("AhtUrganStatus") == 0 then
        player:startEvent(3035, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif player:getCharVar("AhtUrganStatus") == 1 then
        player:startEvent(3036, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    else
        player:startEvent(248)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 3035 and option == 1 then
        player:setCharVar("AhtUrganStatus", 1)
    elseif csid == 3022 then
        player:confirmTrade()
        player:setCharVar("AhtUrganStatus", 2)
    end
end

return entity
