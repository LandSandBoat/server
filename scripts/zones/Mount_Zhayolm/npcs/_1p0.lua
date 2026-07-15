-----------------------------------
-- Area: Mount Zhayolm
-- Door: Heavy Iron Gate
-- !pos 660 -27 328 61
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:checkDistance(npc) < 3 then
        if player:getZPos() < 332 then
            player:messageSpecial(ID.text.STAGING_GATE_HALVUNG)
            player:messageSpecial(ID.text.STAGING_GATE_INTERACT)
            player:startOptionalCutscene(106, { cs_option = 0, canSkip = true })
        elseif not player:hasKeyItem(xi.ki.LEBROS_ASSAULT_ORDERS) then
            player:messageSpecial(ID.text.STAGING_GATE_HALVUNG)
            player:messageSpecial(ID.text.STAGING_GATE_INTERACT)
            player:startOptionalCutscene(107, { cs_option = 0, canSkip = true })
        else
            player:messageSpecial(ID.text.CANNOT_LEAVE, xi.ki.LEBROS_ASSAULT_ORDERS)
        end
    else
        player:messageSpecial(ID.text.STAGING_GATE_CLOSER)
    end
end

return entity
