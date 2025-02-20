-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Sobane
-- Starts and Finishes Quest: Signed in Blood, Tea with a Tonberry
-- Involved in quest: Sharpening the Sword, Riding on the Clouds
-- !pos -190 -3 97 230
-- csid: 52  732  733  734  735  736  737  738  739  740  741
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- SHARPENING THE SWORD
    if player:getCharVar('sharpeningTheSwordCS') >= 2 then
        player:startEvent(52)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- SHARPENING THE SWORD
    if csid == 52 then
        player:setCharVar('sharpeningTheSwordCS', 3)
    end
end

return entity
