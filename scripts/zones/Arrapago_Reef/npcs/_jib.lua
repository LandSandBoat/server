-----------------------------------
-- Area: Arrapago Reef
-- Door: Heavy Iron Gate
-- !pos 5 -9 579 54
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REEF]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:checkDistance(npc) < 3 then
        if player:getXPos() < 8 then
            player:messageSpecial(ID.text.STAGING_GATE_ILRUSI)
            player:messageSpecial(ID.text.STAGING_GATE_INTERACT)
            player:startOptionalCutscene(106)
        elseif not player:hasKeyItem(xi.ki.ILRUSI_ASSAULT_ORDERS) then
            player:messageSpecial(ID.text.STAGING_GATE_ILRUSI)
            player:messageSpecial(ID.text.STAGING_GATE_INTERACT)
            player:startEvent(107)
        else
            player:messageSpecial(ID.text.CANNOT_LEAVE, xi.ki.ILRUSI_ASSAULT_ORDERS)
        end
    else
        player:messageSpecial(ID.text.STAGING_GATE_CLOSER)
    end
end

return entity
