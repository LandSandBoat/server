-----------------------------------
-- Area: Mhaura
--  NPC: Ekokoko
-- Gouvernor of Mhaura
-- Involved in Quest: Riding on the Clouds
-- !pos -78 -24 28 249
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- TODO: This is not a random sequence, but 51 is displayed on first interaction ever,
    -- 52 is displayed all subsequent times (tested against zone and logout).
    if math.random() > 0.5 then
        player:startEvent(51)
    else
        player:startEvent(52)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
