-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Ornate Gate
-- !pos -95 -24 60 27
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getCurrentMission(COP) == xi.mission.id.cop.DISTANT_BELIEFS and player:getCharVar("PromathiaStatus") == 2) then
        player:startEvent(36)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_HERE)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 36) then
        player:setCharVar("PromathiaStatus", 3)
    end

end

return entity
