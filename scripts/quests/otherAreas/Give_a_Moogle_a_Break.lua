-----------------------------------
-- Give a Moogle a Break
-----------------------------------
-- Log ID: 4, Quest ID: 100
-- Moogle : (Mog House, Home Nation)
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.GIVE_A_MOOGLE_A_BREAK)

quest.reward =
{
    title = xi.title.MOGS_KIND_MASTER,
}

-- Since there are so many zones with interactions:
quest.sections = {}

quest.sections[1] = {}
quest.sections[1].check = function(player, status, vars)
    local bedPlacedTime = quest:getVar(player, 'bedPlacedTime')

    return status == QUEST_AVAILABLE and
        xi.moghouse.isInMogHouseInHomeNation(player) and
        player:getFameLevel(player:getNation()) >= 3 and
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
            return quest:progressEvent(30005, 0, 0, 0, 5, 0, xi.item.POWER_BOW, xi.item.BEETLE_RING)
        end,
    },

    onEventFinish =
    {
        [30005] = function(player, csid, option, npc)
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
            if npcUtil.tradeHasExactly(trade, { xi.item.POWER_BOW, xi.item.BEETLE_RING }) then
                return quest:progressEvent(30007)
            end
        end,

        onTrigger = function(player, npc)
            local questProgress = quest:getVar(player, 'Prog')
            local questSeen = quest:getLocalVar(player, 'questSeen')

            if questSeen ~= 0 then
                return nil
            end

            if questProgress == 0 then
                return quest:progressEvent(30006, 0, 0, 0, 0, 0, xi.item.POWER_BOW, xi.item.BEETLE_RING)
            elseif
                questProgress == 1 and
                quest:getVar(player, 'Timer') < os.time()
            then
                return quest:progressEvent(30008)
            end
        end,
    },

    onEventFinish =
    {
        [30006] = function(player, csid, option, npc)
            quest:setLocalVar(player, 'questSeen', 1)
        end,

        [30007] = function(player, csid, option, npc)
            player:confirmTrade()
            quest:setVar(player, 'Prog', 1)
            quest:setVar(player, 'Timer', os.time() + 60)
        end,

        [30008] = function(player, csid, option, npc)
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
