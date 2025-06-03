-----------------------------------
-- Area: West Ronfaure
--  NPC: Esca
-- Involved in Quest "The Pickpocket"
-- !pos -624.231 -51.499 278.369 100
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local chasingQuotasStat = player:getCharVar('ChasingQuotas_Progress')

    -- CHASING QUOTAS
    if chasingQuotasStat == 4 then
        player:startEvent(137) -- My earring!  I stole the last dragoon's armor.  Chosen option does not matter.
    elseif chasingQuotasStat == 5 then
        player:startEvent(138) -- Reminder for finding the armor.

    -- STANDARD DIALOG
    else
        player:startEvent(119)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- CHASING QUOTAS
    if csid == 137 then
        player:setCharVar('ChasingQuotas_Progress', 5)
        player:delKeyItem(xi.ki.SHINY_EARRING)
    end
end

return entity
