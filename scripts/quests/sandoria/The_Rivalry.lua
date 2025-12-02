-----------------------------------
-- The Rivalry
-- Log ID: 0, Quest ID: 75
-- Gallijaux !pos -18 -2 -45 232
-----------------------------------
local portSandOriaID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.SANDORIA,
    item     = xi.item.LU_SHANGS_FISHING_ROD,
    keyitem  = xi.ki.TESTIMONIAL,
    title    = xi.title.CARP_DIEM,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Ufanne'] = quest:event(310),

            ['Gallijaux'] = quest:progressEvent(300, xi.item.MOAT_CARP, xi.item.FOREST_CARP),

            onEventFinish =
            {
                [300] = function(player, csid, option, npc)
                    if option == 700 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Gallijaux'] =
            {
                onTrigger = function(player, npc)
                    return quest:messageName(portSandOriaID.text.GALLIJAUX_CARP_STATUS, 0, player:getCharVar('carpsTraded'), 0, 0, true, false) -- TODO: The number that Gallijaux reports increases over time and eventually resets back to 0 before starting to tick back up.
                end,

                onTrade = function(player, npc, trade)
                    local count        = trade:getItemCount()
                    local moatCarp     = trade:getItemQty(xi.item.MOAT_CARP)
                    local forestCarp   = trade:getItemQty(xi.item.FOREST_CARP)
                    local fishCountVar = player:getCharVar('carpsTraded')
                    local totalFish    = moatCarp + forestCarp + fishCountVar

                    if moatCarp + forestCarp > 0 and moatCarp + forestCarp == count then
                        if totalFish >= 10000 then
                            player:setLocalVar('FishTraded', totalFish) -- Used to transfer the variable into oneventfinish
                            player:setLocalVar('GilToReward', moatCarp * 10 + forestCarp * 15) -- Forces the gil reward to happen AFTER the event like in captures
                            return quest:progressEvent(303)
                        else
                            player:setLocalVar('FishTraded', totalFish)
                            player:setLocalVar('GilToReward', moatCarp * 10 + forestCarp * 15) -- Forces the gil reward to happen AFTER the event like in captures
                            return quest:progressEvent(301)
                        end
                    end
                end,
            },

            ['Joulet'] = quest:messageName(portSandOriaID.text.JOULET_HELP_OTHER_BROTHER, 0, 0, 0, 0, true, false),

            ['Ufanne'] =
            {
                onTrigger = function(player, npc)
                    local fishCount = player:getCharVar('carpsTraded')
                    local cycle     = player:getLocalVar('Cycle')

                    -- NPC cycles dialogue
                    if cycle == 0 then
                        player:setLocalVar('Cycle', 1)
                        return quest:event(309, 0, 0, fishCount)
                    elseif cycle == 1 then
                        player:setLocalVar('Cycle', 0)
                        return quest:event(310)
                    end
                end,
            },

            onEventFinish =
            {
                [301] = function(player, csid, option, npc)
                    player:tradeComplete()
                    player:setCharVar('carpsTraded', player:getLocalVar('FishTraded'))  -- As per captures this char var persists for the life of the character
                    npcUtil.giveCurrency(player, 'gil', player:getLocalVar('GilToReward')) -- Ensures that gil is rewarded after the CS
                    player:addFame(xi.fameArea.SANDORIA, 30)
                end,

                [303] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        player:setCharVar('carpsTraded', player:getLocalVar('FishTraded'))  -- As per captures this char var persists for the life of the character
                        npcUtil.giveCurrency(player, 'gil', player:getLocalVar('GilToReward')) -- Ensures that gil is rewarded after the CS
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {

            -- The player may continue to trade carps to Gallijaux even after obtaining Lu Shang.
            ['Gallijaux'] =
            {
                onTrigger = function(player, npc)
                    return quest:messageName(portSandOriaID.text.GALLIJAUX_CARP_STATUS, 0, player:getCharVar('carpsTraded'), 0, 0, true, false) -- TODO: The number that Gallijaux reports increases over time and eventually resets back to 0 before starting to tick back up.
                end,

                onTrade = function(player, npc, trade)
                    local count        = trade:getItemCount()
                    local moatCarp     = trade:getItemQty(xi.item.MOAT_CARP)
                    local forestCarp   = trade:getItemQty(xi.item.FOREST_CARP)
                    local fishCountVar = player:getCharVar('carpsTraded')
                    local totalFish    = moatCarp + forestCarp + fishCountVar

                    if moatCarp + forestCarp > 0 and moatCarp + forestCarp == count then
                        player:setLocalVar('FishTraded', totalFish)
                        player:setLocalVar('GilToReward', moatCarp * 10 + forestCarp * 15) -- Forces the gil reward to happen AFTER the event like in captures
                        return quest:progressEvent(301)
                    end
                end,
            },

            ['Joulet'] = quest:messageName(portSandOriaID.text.JOULET_HELP_OTHER_BROTHER, 0, 0, 0, 0, true, false),

            ['Ufanne'] =
            {
                onTrigger = function(player, npc)
                    local fishCount = player:getCharVar('carpsTraded')
                    local cycle     = player:getLocalVar('Cycle')

                    -- NPC cycles dialogue
                    if cycle == 0 then
                        player:setLocalVar('Cycle', 1)
                        return quest:event(309, 0, 0, fishCount)
                    elseif cycle == 1 then
                        player:setLocalVar('Cycle', 0)
                        return quest:event(310)
                    end
                end,
            },

            onEventFinish =
            {
                [301] = function(player, csid, option, npc)
                    player:tradeComplete()
                    player:setCharVar('carpsTraded', player:getLocalVar('FishTraded'))  -- As per captures this char var persists for the life of the character
                    npcUtil.giveCurrency(player, 'gil', player:getLocalVar('GilToReward'))
                    player:addFame(xi.fameArea.SANDORIA, 30)
                end,
            },
        },
    },
}

return quest
