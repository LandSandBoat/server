-----------------------------------
--- Area: Navukgo Execution Chamber
-- Quest: Achieving True Power
-----------------------------------
local navukgoID = zones[xi.zone.NAVUKGO_EXECUTION_CHAMBER]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId        = xi.zone.NAVUKGO_EXECUTION_CHAMBER,
    battlefieldId = xi.battlefield.id.ACHIEVING_TRUE_POWER,
    canLoseExp    = false,
    maxPlayers    = 1,
    levelCap      = xi.settings.main.MAX_LEVEL,
    allowSubjob   = false,
    timeLimit     = utils.minutes(10),
    index         = 3,
    entryNpc      = '_1s0',
    exitNpcs      = { '_1s1', '_1s2', '_1s3' },
    requiredItems = { xi.item.PUPPETMASTERS_TESTIMONY, wearMessage = navukgoID.text.TESTIMONY_WEARS, wornMessage = navukgoID.text.TESTIMONY_IS_TORN },
    questArea     = xi.questLog.BASTOK,
    quest         = xi.quest.id.bastok.ACHIEVING_TRUE_POWER,
    requiredVar   = 'Quest[1][85]Prog',
    requiredValue = 1,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    local jobRequirement   = player:getMainJob() == xi.job.PUP
    local levelRequirement = player:getMainLvl() >= 66

    return jobRequirement and levelRequirement
end

function content:setupBattlefield(battlefield)
    local player      = GetPlayerByID(battlefield:getInitiator())
    local playerLevel = player and player:getMainLvl() or 99

    battlefield:setLocalVar('playerLevel', playerLevel)
end

content.groups =
{
    {
        mobIds =
        {
            {
                navukgoID.mob.SHAMARHAAN,
                navukgoID.mob.SHAMARHAAN + 1,
            },

            {
                navukgoID.mob.SHAMARHAAN + 2,
                navukgoID.mob.SHAMARHAAN + 3,
            },

            {
                navukgoID.mob.SHAMARHAAN + 4,
                navukgoID.mob.SHAMARHAAN + 5,
            },
        },

        superlink = true,

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
