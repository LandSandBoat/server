-----------------------------------
-- Twenty in Pirate Years
-----------------------------------
-- Log ID: 5, Quest ID: 143
-- Kagetora: !pos -95 -2.3 28 236
-- qm2 Spiders: !pos 49 -7 400 114
-- Ryoma: !pos -24 .5 -8.4 252
-- Enetsu: !pos 33 -6 68 236
-----------------------------------
local eAltepaID = zones[xi.zone.EASTERN_ALTEPA_DESERT]
-----------------------------------
local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS)
local weaponsReward = { xi.item.ANJU,  xi.item.ZUSHIO }

quest.reward =
{
    fameArea = xi.fameArea.NORG,
    fame = 75,
    item = weaponsReward,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getMainJob() == xi.job.NIN and
            player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL
        end,

        [xi.zone.NORG] =
        {
            ['Ryoma'] = quest:progressEvent(133),

            onEventFinish =
            {
                [133] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORG] =
        {
            ['Ryoma'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.TRICK_BOX) then
                        return quest:progressEvent(134)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(804)
                    end
                end,
            },

            onEventFinish =
            {
                [134] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setLocalVar('Quest[5][144]mustZone', 1)
                        player:delKeyItem(xi.ki.TRICK_BOX)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Kagetora'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(261)
                    end
                end,
            },

            ['Ensetsu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(262)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:event(263)
                    end
                end,
            },

            onEventFinish =
            {
                [261] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [262] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.EASTERN_ALTEPA_DESERT] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        quest:getVar(player, 'nmKilled') == 0 and
                        quest:getLocalVar(player, 'nmPopped') == 0 and
                        npcUtil.popFromQM(player, npc, { eAltepaID.mob.TSUCHIGUMO_OFFSET,
                        eAltepaID.mob.TSUCHIGUMO_OFFSET + 1 }, { claim = false, hide = 0 })
                    then
                        quest:setLocalVar(player, 'nmPopped', 1) -- players can only pop once/zone
                        return quest:messageSpecial(eAltepaID.text.HOSTILE_GAZE)
                    elseif quest:getVar(player, 'nmKilled') == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.TRICK_BOX)
                        quest:setVar(player, 'nmKilled', 0)
                        quest:setVar(player, 'Prog', 3)
                        return quest:noAction()
                    end
                end,
            },

            ['Tsuchigumo'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        GetMobByID(eAltepaID.mob.TSUCHIGUMO_OFFSET):isDead() and
                        GetMobByID(eAltepaID.mob.TSUCHIGUMO_OFFSET + 1):isDead()
                    then
                        quest:setVar(player, 'nmKilled', 1) -- nm kill counts even after zone if didnt get KI
                    end
                end,
            },
        },
    },
}

return quest
