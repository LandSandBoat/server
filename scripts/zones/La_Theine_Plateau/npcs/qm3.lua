-----------------------------------
-- Area: La Theine Plateau
--  NPC:??? (qm3)
-- Involved in Quest: I Can Hear A Rainbow, Waking the Beast
-----------------------------------
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
require("scripts/globals/spell_data")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW) == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, 1125) and
        utils.mask.isFull(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), 7)
    then
        player:startEvent(124)
    end
end

entity.onTrigger = function(player, npc)
    if
        player:hasSpell(xi.magic.spell.IFRIT) and
        player:hasSpell(xi.magic.spell.GARUDA) and
        player:hasSpell(xi.magic.spell.SHIVA) and
        player:hasSpell(xi.magic.spell.RAMUH) and
        player:hasSpell(xi.magic.spell.LEVIATHAN) and
        player:hasSpell(xi.magic.spell.TITAN) and
        player:getCharVar("WTB_CONQUEST_WAIT") < os.time() and
        not player:hasKeyItem(xi.ki.RAINBOW_RESONATOR) and
        not player:hasKeyItem(xi.ki.FADED_RUBY)
    then
        player:startEvent(207)
    end

    if
        player:hasKeyItem(xi.ki.FADED_RUBY) and
        player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.WAKING_THE_BEAST) == QUEST_ACCEPTED
    then
        player:startEvent(208)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 124 then
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW)
        player:addTitle(xi.title.RAINBOW_WEAVER)
        player:unlockJob(xi.job.SMN)
        player:addSpell(296)
        player:messageSpecial(ID.text.UNLOCK_SUMMONER)
        player:messageSpecial(ID.text.UNLOCK_CARBUNCLE)
        player:setCharVar("I_CAN_HEAR_A_RAINBOW", 0)
        player:confirmTrade()

        local rainbow = GetNPCByID(ID.npc.RAINBOW)
        rainbow:setLocalVar('setRainbow', 1)

    elseif csid == 207 then
        player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.WAKING_THE_BEAST)
        player:addKeyItem(xi.ki.RAINBOW_RESONATOR)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.RAINBOW_RESONATOR)

    elseif csid == 208 then
        player:setCharVar("WTB_CONQUEST_WAIT", getConquestTally())
        player:completeQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.WAKING_THE_BEAST)
        player:delKeyItem(xi.ki.FADED_RUBY)

        player:addItem(xi.items.CARBUNCLES_POLE)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.CARBUNCLES_POLE)

        if player:getCharVar("WTB_TITLE") == 1 then
            player:addTitle(xi.title.DISTURBER_OF_SLUMBER)
        else
            player:addTitle(xi.title.INTERRUPTER_OF_DREAMS)
        end
    end
end

return entity
