-----------------------------------
-- Area: Heaven's Tower
--  NPC: Starway Stairway
-- !pos -10 0.1 30 242
-----------------------------------
local ID = zones[xi.zone.HEAVENS_TOWER]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getNation() == 2 then
        if player:hasKeyItem(xi.ki.STARWAY_STAIRWAY_BAUBLE) then
            if player:getXPos() < -14 then
                player:startEvent(106)
            else
                player:startEvent(105)
            end
        else
            player:messageSpecial(ID.text.STAIRWAY_LOCKED)
        end
    else
        player:messageSpecial(ID.text.STAIRWAY_ONLY_CITIZENS)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
