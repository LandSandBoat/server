-----------------------------------
-- Dark Legacy
-----------------------------------
-- Log ID: 1, Quest ID: 57
-- Raibaht        : !pos -27 -10 -1 237
-- Mighty Fist    : !pos -47 2 -30 237
-- Cochal-Monchal : !pos -52 -6 110 238
-- Quu Bokye      : !pos -159 16 181 145
-- qm1            : !pos -58 0 -449 145
-----------------------------------
local giddeusID = zones[xi.zone.GIDDEUS]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_LEGACY)

quest.reward =
{
    fame     = 20,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.item.RAVEN_SCYTHE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.DRK and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL
        end,

        [xi.zone.METALWORKS] =
        {
            ['Raibaht'] = quest:progressEvent(751),

            onEventFinish =
            {
                [751] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Mighty_Fist'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(752)
                    elseif player:hasKeyItem(xi.ki.DARKSTEEL_FORMULA) then
                        return quest:event(754)
                    end
                end,
            },

            ['Raibaht'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.DARKSTEEL_FORMULA) then
                        return quest:progressEvent(755)
                    end
                end,
            },

            onEventFinish =
            {
                [752] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_THE_DARKSTEEL_FORGE)
                    quest:setVar(player, 'Prog', 1)
                end,

                [755] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.DARKSTEEL_FORMULA)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Cochal-Monchal'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:progressEvent(697)
                    elseif questProgress == 2 then
                        return quest:event(698)
                    elseif player:hasKeyItem(xi.ki.DARKSTEEL_FORMULA) then
                        return quest:event(699)
                    end
                end,
            },

            onEventFinish =
            {
                [697] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.LETTER_FROM_THE_DARKSTEEL_FORGE)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.GIDDEUS] =
        {
            ['qm1'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.YAGUDO_CHERRY) and
                        not GetMobByID(giddeusID.mob.VAA_HUJA_THE_ERUDITE):isSpawned() and
                        quest:getVar(player, 'Prog') == 2
                    then
                        player:confirmTrade()
                        SpawnMob(giddeusID.mob.VAA_HUJA_THE_ERUDITE):updateClaim(player)

                        return quest:messageSpecial(giddeusID.text.SENSE_OF_FOREBODING)
                    end
                end,

                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.DARKSTEEL_FORMULA) and
                        quest:getVar(player, 'Prog') == 3
                    then
                        return quest:keyItem(xi.ki.DARKSTEEL_FORMULA)
                    end
                end,
            },

            ['Quu_Bokye'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.YAGUDO_CHERRY) and
                        quest:getVar(player, 'Prog') == 2 and
                        quest:getVar(player, 'Option') == 0
                    then
                        return quest:progressEvent(62)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:event(61)
                    end
                end,
            },

            ['Vaa_Huja_the_Erudite'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 2 then
                        quest:setVar(player, 'Prog', 3)
                    end
                end,
            },

            onEventFinish =
            {
                [62] = function(player, csid, option, npc)
                    player:confirmTrade()

                    quest:setVar(player, 'Option', 1)
                end,
            },
        },
    },
}

return quest
