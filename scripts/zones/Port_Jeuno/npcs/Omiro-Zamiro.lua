-----------------------------------
-- Area: Port Jeuno
--  NPC: Omiro-Zamiro
-- !pos 3 7 -54 246
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:hasKeyItem(xi.ki.AIRSHIP_PASS) and
        player:getGil() >= 200
    then
        player:startEvent(39)
    else
        player:startEvent(47)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 39 then
        local zPos = player:getZPos()

        if zPos >= -61 and zPos <= -58 then
            player:delGil(200)
        end
    end
end

return entity
