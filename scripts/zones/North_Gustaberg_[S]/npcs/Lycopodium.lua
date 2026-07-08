-----------------------------------
-- Area: North Gustaberg [S]
--  NPC: Lycopodium
-- !pos -275.953 12.333 262.368 88
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.LYCOPODIUM_ENTRANCED)

    if not utils.mask.getBit(player:getCharVar('LycopodiumTeleport_Mask'), 2) then
        player:startEvent(113)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 113 then
        player:setCharVar('LycopodiumTeleport_Mask', utils.mask.setBit(player:getCharVar('LycopodiumTeleport_Mask'), 2, true))
    end
end

return entity
