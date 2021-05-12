-----------------------------------
-- A Pose By Any Other Name
-- Angelica !pos -64 -9.25 -9 238
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/titles')
-----------------------------------


local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.A_POSE_BY_ANY_OTHER_NAME)

quest.reward = {
    fame = 75,
    item = xi.items.COPY_OF_ANCIENT_BLOOD,
    title = xi.title.SUPER_MODEL,
    keyItem = xi.ki.ANGELICAS_AUTOGRAPH,
}

quest.sections = {

     {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:needToZone() == false
        end,

        [xi.zone.WINDURST_WATERS] = {
            ['Angelica'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(90)
                end
            },

            onEventFinish = {
                [90] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.WINDURST_WATERS] = {
            ['Angelica'] = {
                onTrigger = function(player, npc)
                    local gear = 0
                    local mjob = player:getMainJob()

                    if mjob == xi.job.WAR or mjob == xi.job.PLD or mjob == xi.job.DRK or mjob == xi.job.DRG or mjob == xi.job.COR then
                        gear = xi.items.BRONZE_HARNESS
                    elseif mjob == xi.job.MNK or mjob == xi.job.BRD or mjob == xi.job.BLU then
                        gear = xi.items.ROBE
                    elseif mjob == xi.job.THF or mjob == xi.job.BST or mjob == xi.job.RNG or mjob == xi.job.DNC then
                        gear = xi.items.LEATHER_VEST
                    elseif mjob == xi.job.WHM or mjob == xi.job.BLM or mjob == xi.job.SMN or mjob == xi.job.PUP or mjob == xi.job.SCH or mjob == xi.job.RDM then
                        gear = xi.items.TUNIC
                    elseif mjob == xi.job.SAM or mjob == xi.job.NIN then
                        gear = xi.items.KENPOGI
                    end

                    quest:setVar(player, 'Stage', os.time() + 300)
                    quest:setVar(player, 'Prog', gear)

                    return quest:progressEvent(92, {[2] = gear})
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog ~= 0
        end,

        [xi.zone.WINDURST_WATERS] = {
            ['Angelica'] = {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Stage') >= os.time() then
                        if player:getEquipID(xi.slot.BODY) == quest:getVar(player, 'Prog') then
                            return quest:progressEvent(96)
                        else
                            return quest:progressEvent(93, {[2] = quest:getVar(player, 'Prog')})
                        end
                    else
                        return quest:progressEvent(102)
                    end
                end,
            },

            onEventFinish = {
                [96] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
                [102] = function(player, csid, option, npc)
                    player:delQuest(WINDURST, A_POSE_BY_ANY_OTHER_NAME)
                    quest:setVar(player, 'Prog', 0)
                    quest:setVar(player, 'Stage', 0)
                    player:addTitle(xi.title.LOWER_THAN_THE_LOWEST_TUNNEL_WORM)
                    player:needToZone(true)
                end,
            },
        },
    },
}

return quest
