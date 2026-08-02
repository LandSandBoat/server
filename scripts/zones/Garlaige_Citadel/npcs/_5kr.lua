-----------------------------------
-- Area: Garlaige Citadel
--  NPC: _5kr (Crematory Hatch)
-- Type: Door
-- !pos 139 -6 127 200
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeMatches(trade, { { xi.item.GARLAIGE_KEY, 1 } }) then
        player:messageSpecial(ID.text.GARLAIGE_KEY_BROKE, 0, xi.item.GARLAIGE_KEY)
        player:startEvent(4) -- Open the door
    end
end

entity.onTrigger = function(player, npc)
    local xPos = player:getXPos()
    local zPos = player:getZPos()

    if xPos >= 135 and xPos <= 144 and zPos >= 128 and zPos <= 135 then
        player:startEvent(5)
    else
        player:messageSpecial(ID.text.OPEN_WITH_THE_RIGHT_KEY)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 4 then
        player:tradeComplete()
    end
end

return entity
