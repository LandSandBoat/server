-----------------------------------
-- Area: Selbina
--  NPC: Lucia
-- !pos 30.552 -2.558 -30.023 248
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Outside dock zone.
    if player:getZPos() >= -28.750 then
        player:startEvent(221, player:getGil(), 100)

    -- Inside dock zone.
    else
        player:startEvent(235)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 221 and player:getZPos() < -28.750 then -- This means they have crossed. Option returned is always 0.
        player:addKeyItem(xi.ki.FERRY_TICKET)
        player:delGil(100)
    end
end

return entity
