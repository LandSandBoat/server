-----------------------------------
-- Area: Uleguerand Range
--  NPC: Fissure
--  Teleports players from underground to surface
-- !pos 380.267 34.859 -179.655 5
-- !pos 460.339 -29.137 220.311 5
-- !pos 180.207 -77.147 500.276 5
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local z = player:getZPos()

    if player:hasKeyItem(xi.ki.MYSTIC_ICE) then
        if z > -200 and z < -150 then                -- southern Fissure (J-9)
            player:startEvent(2, xi.ki.MYSTIC_ICE)
        elseif z > 200 and z < 250 then            -- middle Fissure (K-7)
            player:startEvent(3, xi.ki.MYSTIC_ICE)
        elseif z > 450 then                        -- northern Fissure (I-6)
            player:startEvent(4, xi.ki.MYSTIC_ICE)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if (csid == 2 or csid == 3 or csid == 4) and option == 2 then
        player:delKeyItem(xi.ki.MYSTIC_ICE)
    end
end

return entity
