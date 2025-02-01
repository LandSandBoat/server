-----------------------------------
-- Area: Windurst Walls
--  NPC: Shinchai-Tocchai
-- !pos -220.551 0.999 -116.916 239
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Caps: 505, 0, 3, 1, 300, 2600, 1543, 1411472642, 128
    player:startEvent(505, player:getNation()) -- , 3, 1, 300, 2600, 1543, 1411472642, 128)
end

entity.onEventFinish = function(player, csid, option)
    if player:getPartySize() < 2 then
        return
    end

    if option < 1 or option > 6 or option > player:getPartySize() then
        return
    end

    local party = player:getParty()
    table.sort(party, function(a, b)
        return a:getID() < b:getID()
    end)

    local visitTarget = party[option]
    if visitTarget == nil then
        return
    end

    player:gotoPlayer(visitTarget:getName())
end

return entity
