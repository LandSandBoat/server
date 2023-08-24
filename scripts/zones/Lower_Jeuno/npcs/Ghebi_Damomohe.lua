-----------------------------------
-- Area: Lower Jeuno
--  NPC: Ghebi Damomohe
-- Type: Standard Merchant
-- Starts and Finishes Quest: Tenshodo Membership
-- !pos 16 0 -5 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local astralCovenantCD = player:getCharVar("[ENM]AstralCovenant")

    if
        npcUtil.tradeHas(trade, xi.items.FLORID_STONE) and
        player:hasKeyItem(xi.ki.PSOXJA_PASS) and
        astralCovenantCD < VanadielTime()
    then
        player:startEvent(10047, 1782)
        player:confirmTrade()

    elseif
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.TENSHODO_MEMBERSHIP) ~= QUEST_COMPLETED and
        npcUtil.tradeHas(trade, xi.items.TENSHODO_INVITE)
    then
        player:startEvent(108)
        player:tradeComplete(false)
    end
end

entity.onTrigger = function(player, npc)
    local astralCovenantCD = player:getCharVar("[ENM]AstralCovenant")

    if
        player:hasKeyItem(xi.ki.PSOXJA_PASS) and
        astralCovenantCD < VanadielTime()
    then
        player:startEvent(106, 4, 1, 1782, 604)
    elseif
        player:hasKeyItem(xi.ki.PSOXJA_PASS) and
        astralCovenantCD >= VanadielTime()
    then
        player:startEvent(106, 4, 2, 675, astralCovenantCD)
    elseif player:hasKeyItem(xi.ki.ASTRAL_COVENANT) then
        player:startEvent(106, 4)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 106 and option == 0 then
        local stock =
        {
            4405,  144, -- Rice Ball
            4457, 2700, -- Eel Kabob
            4467,    3, -- Garlic Cracker
        }

        xi.shop.general(player, stock, xi.quest.fame_area.NORG)

    elseif csid == 108 then
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.TENSHODO_MEMBERSHIP)
        npcUtil.giveKeyItem(player, xi.ki.TENSHODO_MEMBERS_CARD)
        player:setTitle(xi.title.TENSHODO_MEMBER)

    elseif csid == 10047 then
        player:setCharVar("[ENM]AstralCovenant", VanadielTime() + (xi.settings.main.ENM_COOLDOWN * 3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ASTRAL_COVENANT)
        player:addKeyItem(xi.ki.ASTRAL_COVENANT)
    end
end

return entity
