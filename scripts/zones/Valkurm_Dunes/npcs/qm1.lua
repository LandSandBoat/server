-----------------------------------
-- Area: Valkurm Dunes
--  NPC: qm1 (???)
-- !pos 238.524 2.661 -148.784 103
-----------------------------------
local ID = zones[xi.zone.VALKURM_DUNES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- NOTE: The NPC is despawned when weather is not up, we do NOT need to check weather.
    if player:getLocalVar('[qm1]mustZone') == 1 then
        player:messageSpecial(ID.text.JUST_A_PILE_OF_SAND)
    elseif npcUtil.giveItem(player, xi.item.PINCH_OF_VALKURM_SUNSAND) then
        player:setLocalVar('[qm1]mustZone', 1)
    end
end

return entity
