-----------------------------------
-- Area: Caedarva Mire
--  NPC: Nahshib
-- Type: Assault
-- !pos -274.334 -9.287 -64.255 79
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local toauMission = player:getCurrentMission(xi.mission.log_id.TOAU)

    -- ASSAULT
    if toauMission >= xi.mission.id.toau.PRESIDENT_SALAHEEM then
        local IPpoint = player:getCurrency('imperial_standing')
        if
            player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_ORDERS) and
            not player:hasKeyItem(xi.ki.ASSAULT_ARMBAND)
        then
            player:startEvent(148, 50, IPpoint)
        else
            player:startEvent(7)
            -- player:delKeyItem(xi.ki.ASSAULT_ARMBAND)
        end

    -- DEFAULT DIALOG
    else
        player:startEvent(4)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- ASSAULT
    if csid == 148 and option == 1 then
        player:delCurrency('imperial_standing', 50)
        npcUtil.giveKeyItem(player, xi.ki.ASSAULT_ARMBAND)
    end
end

return entity
