-----------------------------------
-- Area: Southern San d'Oria
--  NPC: The Picture ??? in Vemalpeau's house
-- Involved in Quests: Under Oath
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('UnderOathCS') == 4 then  -- Quest: Under Oath - PLD AF3
        player:startEvent(41)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 41 and option == 1 then
        npcUtil.giveKeyItem(player, xi.ki.STRANGE_SHEET_OF_PAPER)
    end
end

return entity
