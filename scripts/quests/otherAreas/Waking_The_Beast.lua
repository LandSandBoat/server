-----------------------------------
-- Waking the Beast
-----------------------------------
-- Log ID: 4, Quest ID: 32
-- ???: !pos -179 8 254
-----------------------------------
require('scripts/globals/common')
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.WAKING_THE_BEAST)

quest.reward =
{
    item = xi.items.CARBUNCLES_POLE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:hasSpell(xi.magic.spell.IFRIT) and
            player:hasSpell(xi.magic.spell.GARUDA) and
            player:hasSpell(xi.magic.spell.SHIVA) and
            player:hasSpell(xi.magic.spell.RAMUH) and
            player:hasSpell(xi.magic.spell.LEVIATHAN) and
            player:hasSpell(xi.magic.spell.TITAN)
        end,

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['qm3'] = quest:progressEvent(207),

            onEventFinish =
            {
                [207] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.RAINBOW_RESONATOR)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
            player:hasKeyItem(xi.ki.FADED_RUBY)
        end,

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['qm3'] = quest:progressEvent(208),

            onEventFinish =
            {
                [208] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setVar(player, 'Stage', getConquestTally())
                        player:delKeyItem(xi.ki.FADED_RUBY)

                        if quest:getVar(player, 'Option') == 0 then
                            player:addTitle(xi.title.DISTURBER_OF_SLUMBER)
                        else
                            player:addTitle(quest.reward.INTERRUPTOR_OF_DREAMS)
                        end
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
            quest:getVar(player, 'Stage') < getConquestTally()
        end,

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.FADED_RUBY) then
                        return quest:progressEvent(208)
                    elseif not player:hasKeyItem(xi.ki.RAINBOW_RESONATOR) then
                        return quest:progressEvent(207)
                    end
                end,
            },

            onEventFinish =
            {
                [207] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.RAINBOW_RESONATOR)
                end,

                [208] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setVar(player, 'Stage', getConquestTally())
                        player:delKeyItem(xi.ki.FADED_RUBY)

                        if quest:getVar(player, 'Option') == 0 then
                            player:addTitle(xi.title.DISTURBER_OF_SLUMBER)
                        else
                            player:addTitle(quest.reward.INTERRUPTOR_OF_DREAMS)
                        end
                    end
                end,
            },
        },
    },
}

return quest
