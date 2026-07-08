-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Banishing Gate #1
-- !pos -201.000 -2.994 220 200
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == xi.animation.CLOSE_DOOR then
        if player:hasKeyItem(xi.ki.POUCH_OF_WEIGHTED_STONES) then
            -- Only the left side displays a message when interacting.
            if player:getXPos() < -201 then
                player:messageSpecial(ID.text.THE_GATE_OPENS_FOR_YOU, xi.ki.POUCH_OF_WEIGHTED_STONES)
            end

            -- Door opens from both sides. There's a short delay.
            npc:timer(1500, function(npcArg)
                npcArg:openDoor(15)
            end)
        else
            -- Left side regular interaction.
            if player:getXPos() < -201 then
                player:messageSpecial(ID.text.YOU_COULD_OPEN_THE_GATE, xi.ki.POUCH_OF_WEIGHTED_STONES)
            end
        end
    end
end

return entity
