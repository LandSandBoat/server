-----------------------------------
-- Area: Pso'Xja
--  NPC: Stone Gate
--  Doors automatically open and close every 10 seconds
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTimeTrigger = function(npc, triggerID)
    local timer = npc:getLocalVar("timer")

    if npc:getAnimation() == 8 and os.time() >= timer then
        npc:setAnimation(9)
        npc:setLocalVar("timer", os.time() + 10)
    elseif os.time() >= timer then
        npc:setAnimation(8)
        npc:setLocalVar("timer", os.time() + 10)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
