-----------------------------------
-- Area: Ordelle's Caves
--  NPC: Rojaireaut
-- Type: Standard NPC
-- !pos -91.781 -0.545 587.944 193
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("EcoStatus") == 1 then
        if not player:hasStatusEffect(tpz.effect.LEVEL_RESTRICTION) then
            player:startEvent(51) -- Apply ointment option
        else
            player:startEvent(53) -- Remove ointment option
        end
    elseif player:hasKeyItem(tpz.ki.INDIGESTED_STALAGMITE) then
        player:startEvent(54) -- After receiving KI, Rojaireaut sends the player to Norejaie     
    else
        player:startEvent(50) -- Default dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 51 and option == 1 then
        player:addStatusEffect(tpz.effect.LEVEL_RESTRICTION, 25, 0, 0)
    elseif csid == 54 then
        player:delStatusEffect(tpz.effect.LEVEL_RESTRICTION)
        player:setCharVar("EcoStatus", 3)
    elseif csid == 53 and option == 0 then
        player:delStatusEffect(tpz.effect.LEVEL_RESTRICTION)
    end
end
