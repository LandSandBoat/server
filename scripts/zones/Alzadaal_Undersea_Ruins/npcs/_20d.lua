-----------------------------------
-- Area: Alzadaal Undersea Ruins
-- Door: Gilded Doors (South)
-- !pos 180 0 -39 62 72
-----------------------------------
local ID = zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:checkDistance(npc) < 3 then
        if player:getZPos() > -40 then
            player:messageSpecial(ID.text.STAGING_GATE_NYZUL)
            player:messageSpecial(ID.text.STAGING_GATE_INTERACT)
            player:startOptionalCutscene(115, { cs_option = 0, canSkip = true })
        elseif not player:hasKeyItem(xi.ki.NYZUL_ISLE_ASSAULT_ORDERS) then
            player:messageSpecial(ID.text.STAGING_GATE_NYZUL)
            player:messageSpecial(ID.text.STAGING_GATE_INTERACT)
            player:startOptionalCutscene(114, { cs_option = 0, canSkip = true })
        else
            player:messageSpecial(ID.text.CANNOT_LEAVE, xi.ki.NYZUL_ISLE_ASSAULT_ORDERS)
        end
    else
        player:messageSpecial(ID.text.STAGING_GATE_CLOSER)
    end
end

return entity
