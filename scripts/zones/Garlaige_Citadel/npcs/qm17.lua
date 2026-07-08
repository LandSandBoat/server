-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm17 (???)
-- Notes: Used to obtain Pouch of Weighted Stones
-- !pos -354 0 262 200
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.POUCH_OF_WEIGHTED_STONES) then
        player:startEvent(23) -- Key Item name hardcoded in the event.
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 23 and option == 1 then
        npcUtil.giveKeyItem(player, xi.ki.POUCH_OF_WEIGHTED_STONES)
    end
end

return entity
