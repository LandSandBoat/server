-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Heruze-Moruze
-- Involved in Mission: 2-3 Windurst
-- !pos -56 -3 36 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if pNation == xi.nation.WINDURST then
        player:startEvent(554)
    elseif pNation == xi.nation.BASTOK then
        player:startEvent(578)
    elseif pNation == xi.nation.SANDORIA then
        player:startEvent(577)
    end
end

return entity
