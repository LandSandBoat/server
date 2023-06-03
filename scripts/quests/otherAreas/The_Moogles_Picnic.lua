-----------------------------------
-- The Moogle's Picnic!
-----------------------------------
-- Log ID: 4, Quest ID: 101
-- Moogle : (Mog House, Home Nation)
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/moghouse')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_MOOGLE_PICNIC)

quest.reward =
{
    title = xi.title.MOGS_EXCEPTIONALLY_KIND_MASTER,
}

-- Since there are so many zones with interactions:
quest.sections = {}

quest.sections[1] = {}
quest.sections[1].check = function(player, status, vars)
    local bedPlacedTime = quest:getVar(player, 'bedPlacedTime')

    return status == QUEST_AVAILABLE and
        player:hasCompletedQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.GIVE_A_MOOGLE_A_BREAK) and
        xi.moghouse.isInMogHouseInHomeNation(player) and
        player:getFameLevel(player:getNation()) >= 5 and
        not quest:getMustZone(player) and
        quest:getLocalVar(player, 'questSeen') == 0 and
        bedPlacedTime ~= 0 and
        os.time() > bedPlacedTime + 60
end

local questAvailable =
{
    ['Moogle'] =
    {
        onTrigger = function(player, npc)
            return quest:progressEvent(30009, 0, 0, 0, 4, 0, xi.items.SHRIMP_LURE, xi.items.STICK_OF_SELBINA_BUTTER)
        end,
    },

    onEventFinish =
    {
        [30009] = function(player, csid, option, npc)
            quest:setLocalVar(player, 'questSeen', 1)

            if option == 1 then
                quest:begin(player)
            end
        end,
    },
}

quest.sections[2] = {}
quest.sections[2].check = function(player, status, vars)
    return status == QUEST_ACCEPTED
end

local questAccepted =
{
    ['Moogle'] =
    {
        onTrade = function(player, npc, trade)
            if npcUtil.tradeHasExactly(trade, { xi.items.SHRIMP_LURE, xi.items.STICK_OF_SELBINA_BUTTER }) then
                return quest:progressEvent(30011)
            end
        end,

        onTrigger = function(player, npc)
            local questProgress = quest:getVar(player, 'Prog')
            local questSeen = quest:getLocalVar(player, 'questSeen')

            if questSeen ~= 0 then
                return nil
            end

            if questProgress == 0 then
                return quest:progressEvent(30010, 0, 0, 0, 0, 0, xi.items.SHRIMP_LURE, xi.items.STICK_OF_SELBINA_BUTTER)
            elseif
                questProgress == 1 and
                quest:getVar(player, 'Timer') < os.time()
            then
                return quest:progressEvent(30012)
            end
        end,
    },

    onEventFinish =
    {
        [30010] = function(player, csid, option, npc)
            quest:setLocalVar(player, 'questSeen', 1)
        end,

        [30011] = function(player, csid, option, npc)
            player:confirmTrade()
            quest:setVar(player, 'Prog', 1)
            quest:setVar(player, 'Timer', os.time() + 60)
        end,

        [30012] = function(player, csid, option, npc)
            if quest:complete(player) then
                player:changeContainerSize(xi.inv.MOGSAFE, 10)
                player:changeContainerSize(xi.inv.MOGSAFE2, 10)
            end
        end,
    },
}

for _, zoneId in ipairs(xi.moghouse.moghouseZones) do
    quest.sections[1][zoneId] = questAvailable
    quest.sections[2][zoneId] = questAccepted
end

return quest
