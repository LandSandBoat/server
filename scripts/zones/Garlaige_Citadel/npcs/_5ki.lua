-----------------------------------
-- Area: Garlaige Citadel
--  NPC: _5ki (Banishing Gate #3)
-- !pos -100 -3.008 359 200
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.POUCH_OF_WEIGHTED_STONES) then
        -- Door opens from both sides.
        GetNPCByID(npc:getID()):openDoor(30)

        -- NOTE: In retail, this door doesn't display any messages.
        -- "Better than retail" case, considering how the other 2 gates behave.

        -- Only the south side SHOULD display a message when interacting.
        if player:getZPos() < 359 then
            player:messageSpecial(ID.text.THE_GATE_OPENS_FOR_YOU, xi.ki.POUCH_OF_WEIGHTED_STONES)
        end
    else
        -- South side EXPECTED regular interaction.
        if player:getZPos() < 359 then
            player:messageSpecial(ID.text.YOU_COULD_OPEN_THE_GATE, xi.ki.POUCH_OF_WEIGHTED_STONES)
        end
    end
end

return entity
