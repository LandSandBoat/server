-----------------------------------
-- Area: Meriphataud Mountains [S]
--  NPC: Telepoint
-- !pos 305.989 -14.980 18.960 97
-----------------------------------
local ID = zones[xi.zone.MERIPHATAUD_MOUNTAINS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.MERIPHATAUD_GATE_CRYSTAL) then
        player:startEvent(1)
    else
        player:messageSpecial(ID.text.ALREADY_OBTAINED_TELE)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 1 then
        npcUtil.giveKeyItem(player, xi.ki.MERIPHATAUD_GATE_CRYSTAL)
    end
end

return entity
