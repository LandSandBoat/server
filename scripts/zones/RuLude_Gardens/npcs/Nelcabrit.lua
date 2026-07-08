-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Nelcabrit
-- Involved in Mission: San d'Oria 3-3, 4-1
-- !pos -32 9 -49 243
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if pNation == xi.nation.SANDORIA then
        if player:hasKeyItem(xi.ki.MESSAGE_TO_JEUNO_SANDORIA) then
            player:startEvent(56)
        else
            player:startEvent(102)
        end
    elseif pNation == xi.nation.WINDURST then
        player:startEvent(47)
    elseif pNation == xi.nation.BASTOK then
        player:startEvent(46)
    end
end

return entity
