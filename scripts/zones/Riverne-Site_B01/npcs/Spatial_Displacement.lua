-----------------------------------
-- Area: Riverne Site #B01
--  NPC: Spacial Displacement
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/teleports")
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
    elseif csid == 32003 then
        xi.bcnm.onEventFinish(player, csid, option)
        if xi.settings.main.ENABLE_COP_ZONE_CAP == 1 and option == 4 then
            player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 50, 0, 0)
        end
    elseif csid >= 2 and csid <= 41 then
        xi.teleport.clearEnmityList(player)
    end
end

return entity
