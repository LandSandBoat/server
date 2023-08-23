-----------------------------------
-- Blade of Evil
-----------------------------------
-- Log ID: 1, Quest ID: 59
-- qm1 : !pos 84 -79 77 157
-----------------------------------
local middleDelkfuttsID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_EVIL)

quest.reward =
{
    fame     = 60,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.item.CHAOS_BURGEONET,
    title    = xi.title.PARAGON_OF_DARK_KNIGHT_EXCELLENCE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_PUPPET) and
                player:getMainJob() == xi.job.DRK
        end,

        [xi.zone.BEADEAUX] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.PASHHOW_MARSHLANDS then
                        return 122
                    end
                end,
            },

            onEventFinish =
            {
                [122] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MIDDLE_DELKFUTTS_TOWER] =
        {
            ['qm1'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.VIAL_OF_QUADAV_MAGE_BLOOD) and
                        quest:getVar(player, 'Prog') == 0 and
                        not GetMobByID(middleDelkfuttsID.mob.BLADE_OF_EVIL_MOB_OFFSET + 0):isSpawned() and
                        not GetMobByID(middleDelkfuttsID.mob.BLADE_OF_EVIL_MOB_OFFSET + 1):isSpawned() and
                        not GetMobByID(middleDelkfuttsID.mob.BLADE_OF_EVIL_MOB_OFFSET + 2):isSpawned()
                    then
                        player:confirmTrade()

                        SpawnMob(middleDelkfuttsID.mob.BLADE_OF_EVIL_MOB_OFFSET + 0):updateClaim(player)
                        SpawnMob(middleDelkfuttsID.mob.BLADE_OF_EVIL_MOB_OFFSET + 1):updateClaim(player)
                        SpawnMob(middleDelkfuttsID.mob.BLADE_OF_EVIL_MOB_OFFSET + 2):updateClaim(player)

                        -- TODO: Determine if a message is displayed on spawn here.
                        return quest:noAction()
                    end
                end,
            },

            ['Gerwitzs_Scythe'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },

            onTriggerAreaEnter =
            {
                [8] = function(player, triggerArea)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(14)
                    end
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:complete(player)
                    end
                end,
            },
        },
    },
}

return quest
