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
    local queue = GetServerVariable("[Looking_Glass]Queue")

    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS) == QUEST_ACCEPTED and
        (GetMobByID(ID.mob.NAMORODO):isSpawned() or
        triggerFellow == 1 or queue > os.time())
    then
        player:messageSpecial(ID.text.NOT_TIME_TO_SEARCH)
    elseif
        -- Gating party Size to 3 since fellows count against party limit
        #player:getParty() > 3
    then
        player:messageSpecial(ID.text.NOT_TIME_TO_SEARCH)
    elseif
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS) == QUEST_ACCEPTED and
        (lookingGlass == 2 or
        lookingGlass == 3)
    then
        SetServerVariable("[Looking_Glass]Queue", os.time() + 180)
        for _, v in ipairs(player:getParty()) do
            if
                v:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS) == QUEST_ACCEPTED and
                (v:getCharVar("[Quest]Looking_Glass") == 2 or
                v:getCharVar("[Quest]Looking_Glass") == 3) and
                player:getZoneID() == v:getZoneID() and
                player:checkDistance(v) <= 50
            then
                local fellowParam = xi.fellow_utils.getFellowParam(v)
                v:startEvent(65, 195, 0, 0, 0, 0, 0, 0, fellowParam)
                v:setCharVar("[Quest]Looking_Glass", 2)
            end
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 65 then
        local offset = 0
        for _, v in ipairs(player:getParty()) do
            local mobID = ID.mob.NAMORODO + offset
            SpawnMob(mobID)
            v:setLocalVar("FellowAttack", 1) -- fellow cannot sync attack
            v:setLocalVar("FellowDisengage", 1) -- fellow cannot sync disengage
            v:setLocalVar("triggerFellow", 1) -- must talk to fellow(alive) after fight to proceed
            v:spawnFellow(v:getFellowValue("fellowid"))
            v:getFellow():setPos(-259, 0, 141.5 + (offset * 4), 139)
            v:fellowAttack(GetMobByID(mobID))
            offset = offset + 1
        end

        SetServerVariable("[Looking_Glass]Queue", 0)
    end
end

return entity
