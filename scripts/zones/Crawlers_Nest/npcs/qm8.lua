-----------------------------------
-- Area: Crawlers Nest
-- NPC: ???
-- Finishes Quest: Enveloped in Darkness
-- !pos 59 0.1 66 197
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Crawlers_Nest/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Enveloped in Darkness
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.ENVELOPED_IN_DARKNESS) == QUEST_ACCEPTED then
        local timeout = player:getCharVar("envelopedInDarkness_timer")
        if player:hasKeyItem(tpz.ki.CRAWLER_BLOOD) and player:hasKeyItem(tpz.ki.OLD_BOOTS) then
            player:startEvent(4) -- Ask to take key items
        elseif (timeout ~= 0 and timeout > os.time()) then
            player:messageSpecial(ID.text.EQUIPMENT_NOT_PURIFIED) -- Stagger quest retrieval
        elseif (timeout ~= 0 and timeout <= os.time()) then
            player:startEvent(5) -- Finish quest
        else
            player:messageSpecial(ID.text.SOMEONE_HAS_BEEN_DIGGING_HERE) -- Player misses key item(s)
        end
    -- Default
    else
        player:messageSpecial(ID.text.SOMEONE_HAS_BEEN_DIGGING_HERE)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 4 and option == 1) then
        player:delKeyItem(tpz.ki.CRAWLER_BLOOD)
        player:delKeyItem(tpz.ki.OLD_BOOTS)
        player:setCharVar("envelopedInDarkness_timer", os.time() + math.random(10,40)) -- Set timer
        player:messageSpecial(ID.text.YOU_BURY_THE, tpz.ki.OLD_BOOTS, tpz.ki.CRAWLER_BLOOD)
    elseif (csid == 5) then
        npcUtil.completeQuest(player, SANDORIA, tpz.quest.id.sandoria.ENVELOPED_IN_DARKNESS, {
            item = 14093, -- Warlock's Boots
            fame = 40,
            var = {"envelopedInDarkness_timer", "needs_crawler_blood"}
        })
    end
end