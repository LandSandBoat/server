-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ratihb
-- !pos 75.225 -6.000 -137.203 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getCharVar('AgainstAllOdds') == 2 and
        (
            player:getCharVar('AgainstAllOddsTimer') < os.time() or
            player:getCharVar('AgainstAllOddsTimer') == 0
        )
    then
        player:startEvent(604) -- reacquire life float, account for chars on quest previously without a var
    else
        player:startEvent(603)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 604 then
        npcUtil.giveKeyItem(player, xi.ki.LIFE_FLOAT)
        player:setCharVar('AgainstTimer', getMidnight())
    end
end

return entity
