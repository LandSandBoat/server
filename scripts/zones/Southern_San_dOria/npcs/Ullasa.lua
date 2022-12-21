-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ullasa
--  General Info NPC
-----------------------------------
require("scripts/globals/events/starlight_celebrations")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        if xi.events.starlightCelebration.npcGiftsNpcOnTrigger(player, 1) then
            return
        end
    end

    if player:getCharVar("UnderOathCS") == 2 then  -- Quest: Under Oath - PLD AF3
        player:startEvent(40)
    else
        player:startEvent(39)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 40 then
        player:setCharVar("UnderOathCS", 3) -- Quest: Under Oath - PLD AF3
    end
end

return entity
