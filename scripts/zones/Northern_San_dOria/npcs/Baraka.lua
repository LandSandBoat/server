-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Baraka
-- Involved in Missions 2-3
-- !pos 36 -2 -2 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if pNation == xi.nation.SANDORIA then
        player:startEvent(580)
    elseif pNation == xi.nation.WINDURST then
        player:startEvent(579)
    else
        player:startEvent(539)
    end
end

return entity
