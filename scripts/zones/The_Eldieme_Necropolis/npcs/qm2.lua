-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: ???
-- Involved in Quests: Girl In The Looking Glass
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
require("scripts/globals/pets/fellow")
require("scripts/globals/fellow_utils")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local triggerFellow = player:getLocalVar("triggerFellow")
    local lookingGlass = player:getCharVar("[Quest]Looking_Glass")
    local fellowParam = xi.fellow_utils.getFellowParam(player)
    local queue = GetServerVariable("[Looking_Glass]Queue")

    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS) == QUEST_ACCEPTED and
        (GetMobByID(ID.mob.NAMORODO):isSpawned() or
        triggerFellow == 1 or queue > os.time())
    then
        player:messageSpecial(ID.text.NOT_TIME_TO_SEARCH)
    elseif
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS) == QUEST_ACCEPTED and
        (lookingGlass == 2 or
        lookingGlass == 3)
    then
        player:startEvent(65, 195, 0, 0, 0, 0, 0, 0, fellowParam)
        player:setCharVar("[Quest]Looking_Glass", 2)
        SetServerVariable("[Looking_Glass]Queue", os.time() + 180)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 65 then
        SpawnMob(ID.mob.NAMORODO)
        player:setLocalVar("FellowAttack", 1) -- fellow cannot sync attack
        player:setLocalVar("FellowDisengage", 1) -- fellow cannot sync disengage
        player:setLocalVar("triggerFellow", 1) -- must talk to fellow(alive) after fight to proceed
        player:spawnFellow(player:getFellowValue("fellowid"))
        player:getFellow():setPos(-259, 0, 144.5, 146)
        player:fellowAttack(GetMobByID(ID.mob.NAMORODO))
        SetServerVariable("[Looking_Glass]Queue", 0)
    end
end

return entity
