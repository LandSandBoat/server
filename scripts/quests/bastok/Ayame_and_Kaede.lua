-----------------------------------
-- Ayame and Kaede
-----------------------------------
-- Log ID: 1, Quest ID: 60
-- Kaede    : !pos 48 -6 67 236
-- Kagetora : !pos -96 -2 29 236
-- Ensetsu  : !pos 33 -6 67 236
-- qm2      : !pos -208 -9 176 173
-- Ryoma    : !pos -23 0 -9 252
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local korrolokaID  = require('scripts/zones/Korroloka_Tunnel/IDs')
local portBastokID = require('scripts/zones/Port_Bastok/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.AYAME_AND_KAEDE)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    title    = xi.title.SHADOW_WALKER,
}

local function isNMSpawned()
    for nmId = korrolokaID.mob.KORROLOKA_LEECH, korrolokaID.mob.KORROLOKA_LEECH + 2 do
        if GetMobByID(nmId):isSpawned() then
            return true
        end
    end

    return false
end

local function isNMDefeated()
    for nmId = korrolokaID.mob.KORROLOKA_LEECH, korrolokaID.mob.KORROLOKA_LEECH + 2 do
        if GetMobByID(nmId):isDead() then
            return true
        end
    end

    return false
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Kaede'] = quest:progressEvent(240),

            onEventFinish =
            {
                [240] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.KORROLOKA_TUNNEL] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if
                        not isNMSpawned() and
                        quest:getVar(player, 'Prog') == 2
                    then
                        if quest:getLocalVar(player, 'nmDefeated') == 1 then
                            quest:setVar(player, 'Prog', 3)

                            if quest:getLocalVar(player, 'isActor') == 1 then
                                quest:setLocalVar(player, 'isActor', 0)
                                npc:hideNPC(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
                            end

                            return quest:keyItem(xi.ki.STRANGELY_SHAPED_CORAL)
                        else
                            quest:setLocalVar(player, 'isActor', 1)

                            for nmId = korrolokaID.mob.KORROLOKA_LEECH, korrolokaID.mob.KORROLOKA_LEECH + 2 do
                                SpawnMob(nmId)
                            end

                            return quest:messageSpecial(korrolokaID.text.SENSE_OF_FOREBODING)
                        end
                    end
                end,
            },

            ['Korroloka_Leech'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        isNMDefeated() and
                        quest:getVar(player, 'Prog') == 2
                    then
                        quest:setLocalVar(player, 'nmDefeated', 1)
                    end
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['Ryoma'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(95)
                    end
                end,
            },

            onEventFinish =
            {
                [95] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.SEALED_DAGGER)
                    player:delKeyItem(xi.ki.STRANGELY_SHAPED_CORAL)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Ensetsu'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress >= 1 and
                        questProgress <= 2
                    then
                        return quest:progressEvent(242)
                    elseif questProgress == 3 then
                        return quest:progressEvent(245)
                    elseif questProgress == 4 then
                        return quest:event(243)
                    elseif questProgress == 5 then
                        return quest:progressEvent(246, xi.ki.SEALED_DAGGER)
                    end
                end,
            },

            ['Kagetora'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(241)
                    elseif questProgress > 2 then
                        return quest:event(244)
                    end
                end,
            },

            onEventFinish =
            {
                [241] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [242] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [245] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [246] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:unlockJob(xi.job.NIN)
                        player:messageSpecial(portBastokID.text.UNLOCK_NINJA)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Kaede'] = quest:event(248):replaceDefault(),
        },
    },
}

return quest
