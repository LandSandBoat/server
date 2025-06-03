-----------------------------------
-- Area: Norg
--  NPC: Fouvia
-- Type: Wyvern Name Changer
-- !pos -84.066 -6.414 47.826 252
-----------------------------------
local ID = zones[xi.zone.NORG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getMainJob() ~= xi.job.DRG then
        player:showText(npc, ID.text.FOUIVA_DIALOG) -- Oi 'av naw business wi' de likes av you.
    elseif player:getGil() < 9800 then
        player:showText(npc, ID.text.FOUIVA_DIALOG + 9) -- You don't 'av enough gil.  Come back when you do.
    else
        player:startEvent(130, 0, 0, 0, 0, 0, 0, player:getCharVar('ChangedWyvernName'))
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 130 and
        option ~= utils.EVENT_CANCELLED_OPTION
    then
        player:delGil(9800)
        player:setCharVar('ChangedWyvernName', 1)
        player:setPetName(xi.petType.WYVERN, option + 1)
    end
end

return entity
