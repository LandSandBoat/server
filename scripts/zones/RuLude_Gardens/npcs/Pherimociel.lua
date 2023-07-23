-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Pherimociel
-- !pos -31.627 1.002 67.956 243
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Removed pending confirmation
    -- local hrandom = math.random()

    -- if hrandom < 0.2 then
    --     player:startEvent(27) -- Observed while Three Paths is active
    -- else
    --     player:startEvent(29)
    -- end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
