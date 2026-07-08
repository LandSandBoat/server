-----------------------------------
-- Area: Xarcabard [S]
--  NPC: Zvahl Portcullis
-- !pos 223 -13 -254 137
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- TODO: Verify if there is a minimum mission required to enter this zone.
    player:startEvent(29)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 29 and
        option == 1
    then
        player:setPos(412.024, -12, -20.047, 128, xi.zone.CASTLE_ZVAHL_BAILEYS_S)
    end
end

return entity
