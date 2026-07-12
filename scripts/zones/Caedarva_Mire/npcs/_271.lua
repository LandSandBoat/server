-----------------------------------
-- Area: Caedarva Mire
-- Door: Heavy Iron Gate
-- !pos -299 -6 -80 79
-----------------------------------
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:checkDistance(npc) < 3 then
        if player:getZPos() < -78 then
            player:messageSpecial(ID.text.STAGING_GATE_DVUCCA)
            player:messageSpecial(ID.text.STAGING_GATE_INTERACT)
            player:startOptionalCutscene(122, { cs_option = 0, canSkip = true })
        elseif not player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_ORDERS) then
            player:messageSpecial(ID.text.STAGING_GATE_DVUCCA)
            player:messageSpecial(ID.text.STAGING_GATE_INTERACT)
            player:startOptionalCutscene(123, { cs_option = 0, canSkip = true })
        else
            player:messageSpecial(ID.text.CANNOT_LEAVE, xi.ki.PERIQIA_ASSAULT_ORDERS)
        end
    else
        player:messageSpecial(ID.text.STAGING_GATE_CLOSER)
    end
end

return entity
