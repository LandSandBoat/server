-----------------------------------
-- Area: Bastok Markets
--  NPC: Rothais
-- Involved in Quest: Gourmet
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local vanatime = VanadielHour()

    if vanatime >= 18 or vanatime < 6 then
        player:startEvent(204)
    elseif vanatime >= 6 and vanatime < 12 then
        player:startEvent(205)
    else
        player:startEvent(206)
    end
end

return entity
