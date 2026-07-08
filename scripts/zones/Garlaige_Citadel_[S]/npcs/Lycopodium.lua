-----------------------------------
-- Area: Garlaige Citadel [S]
--  NPC: Lycopodium
-- !pos -96.753 -1.000 -167.332 164
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.LYCOPODIUM_ENTRANCED)

    if not utils.mask.getBit(player:getCharVar('LycopodiumTeleport_Mask'), 0) then
        player:startEvent(30)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 30 then
        player:setCharVar('LycopodiumTeleport_Mask', utils.mask.setBit(player:getCharVar('LycopodiumTeleport_Mask'), 0, true))
    end
end

return entity
