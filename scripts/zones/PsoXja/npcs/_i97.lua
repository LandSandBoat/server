-----------------------------------
-- Area: Pso'Xja
--  NPC: Stone Gate
-----------------------------------
local ID = zones[xi.zone.PSOXJA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local posZ = player:getZPos()
    if player:hasKeyItem(xi.ki.PSOXJA_PASS) and posZ >= 25 then
        player:startOptionalCutscene(14, { cs_option = 0, canSkip = true })
    elseif posZ < 25 then
        player:startOptionalCutscene(17, { cs_option = 0, canSkip = true })
    else
        player:messageSpecial(ID.text.DOOR_LOCKED)
    end
end

return entity
