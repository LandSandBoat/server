-----------------------------------
-- Area: Crawlers Nest
--  NPC: ???
-- Used In Quest: A Boy's Dream
-- !pos -18 -8 124 197
-----------------------------------
local ID = zones[xi.zone.CRAWLERS_NEST]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_BOY_S_DREAM) == QUEST_ACCEPTED and
        VanadielDayOfTheYear() ~= player:getCharVar('DreadbugNM_Day')
    then
        if
            os.time() > player:getCharVar('DreadbugNM_Timer') + 30 and
            npcUtil.popFromQM(player, npc, ID.mob.DREADBUG, { claim = true, hide = 0 })
        then
            player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
            player:setCharVar('DreadbugNM_Timer', os.time() + 180)
            player:setCharVar('DreadbugNM_Day', VanadielDayOfTheYear())
        else
            player:messageSpecial(ID.text.NOTHING_SEEMS_TO_HAPPEN)
        end
    else
        player:messageSpecial(ID.text.NOTHING_WILL_HAPPEN_YET)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
