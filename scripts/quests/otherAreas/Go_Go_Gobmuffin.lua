-----------------------------------
-- Go! Go! Gobmuffin!
-----------------------------------
-- Log ID: 4, Quest ID: 69
-- Epinolle             !pos 81.728 -33.970 66.351
-- Spatial Displasement !pos 386.340 52.400 692.492
-----------------------------------
local riverneID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.GO_GO_GOBMUFFIN)

quest.reward =
{
    exp     = 2000,
    gil     = 2000,
    keyItem = xi.ki.MAP_OF_CAPE_RIVERNE,
}

local nmBitTable =
{
    [riverneID.mob.SPELL_SPITTER_SPILUSPOK    ] = 0,
    [riverneID.mob.SPELL_SPITTER_SPILUSPOK + 1] = 1,
    [riverneID.mob.SPELL_SPITTER_SPILUSPOK + 2] = 2,
}

local nmStatus = function(player, mob)
    local nmBitmask = player:getLocalVar('GobmuffinNM')
    local bitNumber = nmBitTable[mob:getID()]
    nmBitmask       = utils.mask.setBit(nmBitmask, bitNumber, true)

    if nmBitmask == 7 then -- All 3 bits are true.
        quest:setVar(player, 'Prog', 1)
    else
        player:setLocalVar('GobmuffinNM', nmBitmask) -- Resets upon zoning causing the player to need to refight the NMs
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.SHELTERING_DOUBT)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Epinolle'] = quest:progressEvent(232),

            onEventFinish =
            {
                [232] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Epinolle'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(234)
                    else
                        return quest:event(233)
                    end
                end,
            },

            onEventFinish =
            {
                [234] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.RIVERNE_SITE_B01] =
        {
            ['Book_Browser_Bokabraq'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 0 then
                        nmStatus(player, mob)
                    end
                end,
            },

            ['Chemical_Cook_Chemachiq'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 0 then
                        nmStatus(player, mob)
                    end
                end,
            },

            ['Spell_Spitter_Spilospok'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 0 then
                        nmStatus(player, mob)
                    end
                end,
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        not GetMobByID(riverneID.mob.SPELL_SPITTER_SPILUSPOK):isSpawned() and
                        not GetMobByID(riverneID.mob.SPELL_SPITTER_SPILUSPOK + 1):isSpawned() and
                        not GetMobByID(riverneID.mob.SPELL_SPITTER_SPILUSPOK + 2):isSpawned()
                    then
                        for i = 0, 2 do
                            SpawnMob(riverneID.mob.SPELL_SPITTER_SPILUSPOK + i):updateClaim(player)
                        end
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Epinolle'] = quest:event(235):replaceDefault(),
        },
    },
}

return quest
