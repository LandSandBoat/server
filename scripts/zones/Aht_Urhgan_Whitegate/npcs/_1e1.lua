-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Salaheem's Sentinels (Door)
-- !pos 23 -6 -63 50
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(TOAU) == tpz.mission.id.toau.PATH_OF_DARKNESS and player:getCharVar("AhtUrganStatus") > 0 then
        return
    end
    npc:openDoor()
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
