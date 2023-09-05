-----------------------------------
-- Area: Port Jeuno
--  NPC: Zedduva
-- !pos -61 7 -54 246
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("Quest[0][67]Stage") > os.time() then
        player:startEvent(40)
    else
        if
            player:hasKeyItem(xi.ki.AIRSHIP_PASS) and
            player:getGil() >= 200
        then
            player:startEvent(36)
        else
            player:startEvent(44)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 36 then
        local zPos = player:getZPos()

        if zPos >= -61 and zPos <= -58 then
            player:delGil(200)
        end
    end
end

return entity
