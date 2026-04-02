-----------------------------------
-- Elementary, My Dear Sylvie
-- GEO AF Quest 2
-- !addquest 9 35
-- Sylvie   : !pos 78.094 32.000 135.725 256
-- Dabnorrin : !pos 357.753 -16.168 29.858 265
-- Primordial_Convergence : !pos 485.042 -16.886 269.984 265
-----------------------------------
local morimarID = zones[xi.zone.MORIMAR_BASALT_FIELDS]
-----------------------------------

local quest = Quest:new(xi.questLog.ADOULIN, xi.quest.id.adoulin.ELEMENTARY_MY_DEAR_SYLVIE)

quest.reward =
{
    fameArea = xi.fameArea.ADOULIN,
    bayld    = 3000,
    fame     = 30,
}

quest.sections =
{
    -- Section 1: Quest available after completing Dances with Luopans as GEO 66+
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.DANCES_WITH_LUOPANS) == xi.questStatus.QUEST_COMPLETED and
                player:getMainLvl() >= 66 and
                player:getMainJob() == xi.job.GEO
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Sylvie'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Sylvie: I sense a great disturbance in the geomantic flow...', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Sylvie: Please go to Morimar Basalt Fields and speak with Dabnorrin.', xi.msg.channel.NS_SAY)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section 2: Talk to Dabnorrin in Morimar Basalt Fields
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 0
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Sylvie'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Sylvie: Please speak with Dabnorrin at Bivouac #1 in Morimar Basalt Fields.', xi.msg.channel.NS_SAY)
                end,
            },
        },

        [xi.zone.MORIMAR_BASALT_FIELDS] =
        {
            ['Dabnorrin'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Dabnorrin: Ah, Sylvie sent you? The Primordial Convergence has been acting strangely.', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Dabnorrin: Take this vessel and investigate the convergence to the northeast.', xi.msg.channel.NS_SAY)
                    npcUtil.giveKeyItem(player, xi.ki.VESSEL_OF_SUMMONING)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Section 3: Examine Primordial Convergence to spawn NM
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 1
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Sylvie'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Sylvie: Investigate the Primordial Convergence in Morimar Basalt Fields.', xi.msg.channel.NS_SAY)
                end,
            },
        },

        [xi.zone.MORIMAR_BASALT_FIELDS] =
        {
            ['Primordial_Convergence'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.VESSEL_OF_SUMMONING) then
                        if npcUtil.popFromQM(player, npc, morimarID.mob.BURGEONING_FLAMES, { claim = true, look = true }) then
                            player:printToPlayer('The convergence pulses with energy... A flame elemental materializes!', xi.msg.channel.NS_SAY)
                            player:delKeyItem(xi.ki.VESSEL_OF_SUMMONING)
                        else
                            player:printToPlayer('The area is too dangerous right now. Try again later.', xi.msg.channel.NS_SAY)
                        end
                    end
                end,
            },

            ['Burgeoning_Flames'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 1 then
                        quest:setVar(player, 'Prog', 2)
                        player:printToPlayer('The flame dissipates... The convergence has stabilized.', xi.msg.channel.NS_SAY)
                    end
                end,
            },
        },
    },

    -- Section 4: Examine convergence again after defeating NM, then return to Sylvie
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 2
        end,

        [xi.zone.MORIMAR_BASALT_FIELDS] =
        {
            ['Primordial_Convergence'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('The convergence hums peacefully. You should report back to Sylvie.', xi.msg.channel.NS_SAY)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Sylvie'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Sylvie: Have you investigated the convergence?', xi.msg.channel.NS_SAY)
                end,
            },
        },
    },

    -- Section 5: Return to Sylvie to complete
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 3
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Sylvie'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Sylvie: You stabilized the convergence! The geomantic flow is restored!', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Sylvie: Your mastery of geomancy grows stronger.', xi.msg.channel.NS_SAY)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
