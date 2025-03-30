-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Pulloie
-- !pos 132.847 -0.199 -2.627 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- TODO:
    -- if player:getNation() == 0 then
    --     player:startEvent(595)
    -- else
    --     player:startEvent(598)
    -- end

    xi.moghouse.visitationNPCOnTrigger(player, npc, 838)
end

entity.onEventFinish = function(player, csid, option)
    xi.moghouse.visitationNPCOnEventFinish(player, csid, option, 838)
end

return entity
