-----------------------------------
-- Area: Riverne Site #B01
--  NPC: Spacial Displacement
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.DISPLACEMENT_OFFSET
    if offset >= 0 and offset <= 31 then
        player:startOptionalCutscene(offset + 2)
    elseif offset == 34 then
        player:startOptionalCutscene(22)
    elseif offset == 35 then
        player:startOptionalCutscene(32003)
    elseif offset > 35 and offset <= 41 then
        player:startOptionalCutscene(offset)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 33 and option == 1 then
        player:setPos(12.527, 0.345, -539.602, 127, 31) -- to Monarch Linn (Retail confirmed)
    elseif csid == 10 and option == 1 then
        player:setPos(-538.526, -29.5, 359.219, 255, 25) -- back to Misareaux Coast (Retail confirmed)
    elseif csid == 17 and option == 0 then
        -- TODO: Go! Go! Gobmuffin quest. Player just ported to J-6 island
    elseif csid == 32003 then
        xi.bcnm.onEventFinish(player, csid, option)
    end
end

return entity
