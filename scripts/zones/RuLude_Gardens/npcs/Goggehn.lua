-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Goggehn
-- Involved in Mission: Bastok 3-3, 4-1
-- !pos 3 9 -76 243
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if pNation == xi.nation.BASTOK then
        if player:hasKeyItem(xi.ki.MESSAGE_TO_JEUNO_BASTOK) then
            player:startEvent(55)
        else
            player:startEvent(101)
        end
    elseif pNation == xi.nation.SANDORIA then
        player:startEvent(1)
    elseif pNation == xi.nation.WINDURST then
        player:startEvent(2)
    end
end

return entity
