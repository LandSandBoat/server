-----------------------------------
-- Area: Ordelle's Caves
--  NPC: Rojaireaut
-- !pos -91.781 -0.545 587.944 193
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('EcoStatus') == 1 then
        if not player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
            player:startEvent(51) -- Apply ointment option
        else
            player:startEvent(53) -- Remove ointment option
        end
    elseif player:hasKeyItem(xi.ki.INDIGESTED_STALAGMITE) then
        player:startEvent(54) -- After receiving KI, Rojaireaut sends the player to Norejaie
    else
        player:startEvent(50) -- Default dialogue
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 51 and option == 1 then
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 25, 0, 0)
    elseif csid == 54 then
        player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
        player:setCharVar('EcoStatus', 3)
    elseif csid == 53 and option == 0 then
        player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
    end
end

return entity
