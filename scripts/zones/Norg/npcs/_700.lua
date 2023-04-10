-----------------------------------
-- Area: Norg
--  NPC: Oaken door (Gilgamesh's room)
-- !pos 97 -7 -12 252
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCharVar('ApocalypseNigh') == 6 and
        os.time() < player:getCharVar("Apoc_Nigh_Reward")
    then
        player:startEvent(235)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
