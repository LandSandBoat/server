-----------------------------------
-- Area: Hall of the Gods
--  NPC: Shimmering Circle
-- Lifts players up to the sky!
-- !pos 0 -20 147 251
-----------------------------------
local ID = require("scripts/zones/Hall_of_the_Gods/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local roz = player:getCurrentMission(ZILART)
    local rozStat = player:getMissionStatus(xi.mission.log_id.ZILART)

    if player:getZPos() < 200 then
        if
            roz ~= xi.mission.id.zilart.NONE and
            (
                roz > xi.mission.id.zilart.THE_GATE_OF_THE_GODS or
                (
                    roz == xi.mission.id.zilart.THE_GATE_OF_THE_GODS and
                    rozStat > 0
                )
            )
        then
            player:startEvent(10)
        else
            player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
        end
    else
        player:startEvent(11)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
