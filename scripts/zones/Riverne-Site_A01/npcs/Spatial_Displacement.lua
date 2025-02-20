-----------------------------------
-- Area: Riverne Site #A01
--  NPC: Spacial Displacement
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_A01]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.DISPLACEMENT_OFFSET
    if offset >= 0 and offset <= 2 then
        player:startOptionalCutscene(offset + 2)
    elseif offset >= 7 and offset <= 39 then
        player:startOptionalCutscene(offset)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 35 and option == 1 then
        player:setPos(12.527, 0.345, -539.602, 127, 31) -- to Monarch Linn (Retail confirmed)
    elseif csid == 10 and option == 1 then
        player:setPos(-538.526, -29.5, 359.219, 255, 25) -- back to Misareaux Coast (Retail confirmed)
    end
end

return entity
