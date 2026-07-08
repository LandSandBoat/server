-----------------------------------
-- Area: Batallia Downs [S]
--  NPC: Lycopodium
-- !pos -366.425 -22.127 324.666 84
-----------------------------------
local ID = zones[xi.zone.BATALLIA_DOWNS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.LYCOPODIUM_ENTRANCED)

    if not utils.mask.getBit(player:getCharVar('LycopodiumTeleport_Mask'), 1) then
        player:startEvent(202)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 202 then
        player:setCharVar('LycopodiumTeleport_Mask', utils.mask.setBit(player:getCharVar('LycopodiumTeleport_Mask'), 1, true))
    end
end

return entity
