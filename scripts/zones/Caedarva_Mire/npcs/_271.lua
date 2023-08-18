-----------------------------------
-- Area: Caedarva Mire
-- Door: Heavy Iron Gate
-- !pos -299 -6 -80 79
-----------------------------------
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:checkDistance(npc) < 3 then
        if player:getZPos() < -78 then
            player:messageSpecial(ID.text.STAGING_GATE_DVUCCA)
            player:messageSpecial(ID.text.STAGING_GATE_INTERACT)
            player:startEvent(122)
        elseif not player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_ORDERS) then
            player:messageSpecial(ID.text.STAGING_GATE_DVUCCA)
            player:messageSpecial(ID.text.STAGING_GATE_INTERACT)
            player:startEvent(123)
        else
            player:messageSpecial(ID.text.CANNOT_LEAVE, xi.ki.PERIQIA_ASSAULT_ORDERS)
        end
    else
        player:messageSpecial(ID.text.STAGING_GATE_CLOSER)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
