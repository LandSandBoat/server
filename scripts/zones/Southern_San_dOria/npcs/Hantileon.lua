-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Hantileon
-- Type: VCS Chocobo Trainer
-- !pos -2.675 -1.1 -105.287 230
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)


    local chocoboOnTheLoose = player:getCharVar("ChocoboOnTheLoose")

    if (chocoboOnTheLoose == 3 or chocoboOnTheLoose == 4) then
        player:startEvent(821)
    elseif (chocoboOnTheLoose == 5) then
        player:startEvent(822)
    else
        player:startEvent(817)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 821) then
        player:setCharVar("ChocoboOnTheLoose", 5)
    elseif (csid == 822) then
        player:setCharVar("ChocoboOnTheLoose", 6)
    end
end

return entity
