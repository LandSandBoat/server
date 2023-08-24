-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Banishing Gate #1
-- !pos -201.000 -2.994 220 200
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Forked servers may optionally wish to remove this tag / requirement
    if xi.settings.main.ENABLE_WOTG == 1 then
        if player:hasKeyItem(xi.ki.POUCH_OF_WEIGHTED_STONES) then
            -- Door opens from both sides.
            GetNPCByID(npc:getID()):openDoor(30)

            -- Only the left side displays a message when interacting.
            if player:getXPos() < -201 then
                player:messageSpecial(ID.text.THE_GATE_OPENS_FOR_YOU, xi.ki.POUCH_OF_WEIGHTED_STONES)
            end
        else
            -- Left side regular interaction.
            if player:getXPos() < -201 then
                player:messageSpecial(ID.text.YOU_COULD_OPEN_THE_GATE, xi.ki.POUCH_OF_WEIGHTED_STONES)
            end
        end
    else
        player:messageSpecial(ID.text.A_GATE_OF_STURDY_STEEL)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
