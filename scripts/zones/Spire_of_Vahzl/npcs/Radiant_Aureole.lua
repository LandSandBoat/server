-----------------------------------
-- Area: Spire of Vahzl
--  NPC: Radiant Aureole
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(15)
end

entity.onEventUpdate = function(player, csid, option)
    -- printf("onUpdate CSID: %u", csid)
    -- printf("onUpdate RESULT: %u", option)
end

entity.onEventFinish = function(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)

    if (csid == 15 and option == 1) then
        player:setPos(-379.947, 48.045, 334.059, 192, 9) -- To Pso'Xja {R}
    end

end

return entity
