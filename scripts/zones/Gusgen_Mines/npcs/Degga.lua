-----------------------------------
-- Area: Gusgen Mines
--  NPC: Degga
-- !pos 40 -68 -259
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('EcoStatus') == 101 then
        if not player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
            player:startEvent(13) -- Apply ointment option
        else
            player:startEvent(15) -- Remove ointment option
        end
    elseif player:hasKeyItem(xi.ki.INDIGESTED_ORE) then
        player:startEvent(16) -- After receiving KI, Degga sends the player to Raifa
    else
        player:startEvent(12) -- Default dialogue
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 13 and option == 1 then
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 25, 0, 0)
    elseif csid == 16 then
        player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
        player:setCharVar('EcoStatus', 103)
    elseif csid == 15 and option == 0 then
        player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
    end
end

return entity
