-----------------------------------
-- Area: Caedarva Mire
-- Door: Heavy Iron Gate
-- !pos 540 -18 -441 79
-----------------------------------
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:checkDistance(npc) < 3 then
        if player:getZPos() > -438 then
            player:messageSpecial(ID.text.STAGING_GATE_AZOUPH)
            player:messageSpecial(ID.text.STAGING_GATE_INTERACT)
            player:startOptionalCutscene(120)
        elseif not player:hasKeyItem(xi.ki.LEUJAOAM_ASSAULT_ORDERS) then
            player:messageSpecial(ID.text.STAGING_GATE_AZOUPH)
            player:messageSpecial(ID.text.STAGING_GATE_INTERACT)
            player:startEvent(121)
        else
            player:messageSpecial(ID.text.CANNOT_LEAVE, xi.ki.LEUJAOAM_ASSAULT_ORDERS)
        end
    else
        player:messageSpecial(ID.text.STAGING_GATE_CLOSER)
    end
end

return entity
