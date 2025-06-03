-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Old casket
-- Obtaining 'Paintbrush of Souls'
-- !pos 61 0 17 159
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.OLD_RUSTY_KEY) then
        player:startEvent(64, xi.ki.OLD_RUSTY_KEY)
    elseif player:hasKeyItem(xi.ki.PAINTBRUSH_OF_SOULS) then
        player:messageSpecial(ID.text.NO_REASON_TO_INVESTIGATE)
    else
        player:messageSpecial(ID.text.THE_BOX_IS_LOCKED)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 64 and option == 1 then
        player:delKeyItem(xi.ki.OLD_RUSTY_KEY)
        npcUtil.giveKeyItem(player, xi.ki.PAINTBRUSH_OF_SOULS)
    end
end

return entity
