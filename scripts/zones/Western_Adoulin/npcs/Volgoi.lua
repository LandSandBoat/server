-----------------------------------
-- Area: Western Adoulin
--  NPC: Volgoi
-- !pos -154 4 -22 256
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local soaMission = player:getCurrentMission(xi.mission.log_id.SOA)

    if
        soaMission >= xi.mission.id.soa.BEAUTY_AND_THE_BEAST and
        soaMission <= xi.mission.id.soa.SALVATION
    then
        -- Speech while Arciela is 'kidnapped'
        player:startEvent(151)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
