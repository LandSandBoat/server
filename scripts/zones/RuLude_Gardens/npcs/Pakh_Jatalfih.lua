-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Pakh Jatalfih
-- Involved in Mission: Windurst 3-3, 4-1
-- !pos 34 8 -35 243
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if pNation == xi.nation.WINDURST then
        if player:hasKeyItem(xi.ki.MESSAGE_TO_JEUNO_WINDURST) then
            player:startEvent(57)
        else
            player:startEvent(103)
        end
    elseif pNation == xi.nation.SANDORIA then
        player:startEvent(52)
    elseif pNation == xi.nation.BASTOK then
        player:startEvent(51)
    end
end

return entity
