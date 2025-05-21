-----------------------------------
-- Area: Jugner Forest [S]
--  NPC: Telepoint
-- !pos -122.862 0.000 -163.154 82
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.JUGNER_GATE_CRYSTAL) then
        player:startEvent(1)
    else
        player:messageSpecial(ID.text.ALREADY_OBTAINED_TELE)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 1 then
        npcUtil.giveKeyItem(player, xi.ki.JUGNER_GATE_CRYSTAL)
    end
end

return entity
