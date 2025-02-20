-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Banishing Gate #2
-- !pos -100 -2.949 81 200
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.POUCH_OF_WEIGHTED_STONES) then
        -- Door opens from both sides.
        GetNPCByID(npc:getID()):openDoor(30)

        -- Only the north side displays a message when interacting.
        if player:getZPos() > 80.5 then
            player:messageSpecial(ID.text.THE_GATE_OPENS_FOR_YOU, xi.ki.POUCH_OF_WEIGHTED_STONES)
        end
    else
        -- North side regular interaction.
        if player:getZPos() > 80.5 then
            player:messageSpecial(ID.text.YOU_COULD_OPEN_THE_GATE, xi.ki.POUCH_OF_WEIGHTED_STONES)
        end
    end
end

return entity
